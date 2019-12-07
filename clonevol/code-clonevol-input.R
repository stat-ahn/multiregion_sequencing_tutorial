setwd("../") #working directory

tsvfilelists <- c("data/tsv/SRR385938.tsv",
               "data/tsv/SRR385939.tsv",
               "data/tsv/SRR385940.tsv",
               "data/tsv/SRR385941.tsv")

samplenames <- c(
    "SRR385938",
    "SRR385939",
    "SRR385940",
    "SRR385941")

# prepare sample grouping
groupnames <- samplenames;
names(groupnames) <- samplenames

# output: clonevol-input.tsv (combined resulted tsv + loci.tsv)
library(dplyr)
library(tidyr)

p.out <- read.table("pyclone/outputall/tables/loci.tsv",header=T)
my.tsv.all <- as.list(1:length(tsvfilelists))

for(i in 1:length(tsvfilelists)){
    m.out <- read.table(tsvfilelists[i],header=T)
    m.out$sample_id <- samplenames[i]
    my.tsv.all[[i]] <- m.out
}
my.tsv <- do.call("rbind", my.tsv.all)

a.1 <- inner_join(my.tsv, p.out, by = c("mutation_id" = "mutation_id", "sample_id" = "sample_id")) # 24 input data do not have cluster information

a.2 <- a.1 %>%
    mutate(cluster = cluster_id,
           gene = mutation_id,
           ccf = cellular_prevalence * 100,
           var.count = var_counts,
           ref.count = ref_counts,
           depth = var_counts + ref_counts,
           vaf = var_counts/(var_counts + ref_counts)*100
           ) %>%
    select(cluster, gene, sample_id, vaf, ccf, ref.count, var.count, depth)

a.3 <- a.2 %>%
    gather(key, value, -cluster, -gene, -sample_id) %>%
    unite(col,sample_id, key, sep=".") %>%
    spread(col, value) %>%
    #filter(cluster < 4) %>%
    mutate(cluster = cluster +1) 
    
    

a.4 <- a.3 %>%
    #filter(cluster <= 4)  
    separate(gene, c("RefSeq","Allele","Chr","Pos")) 
    
a.5 <- a.4 %>%
    filter(cluster<=4)


y <- infer.clonal.models(
    variants = a.5,
    cluster.col.name = 'cluster',
    ccf.col.names = samplenames,
    sample.groups = groupnames,
    cancer.initiation.model='polyclonal',
    subclonal.test = 'bootstrap',
    subclonal.test.model = 'non-parametric',
    num.boots = 1000,
    founding.cluster = NULL,
    cluster.center = 'mean',
    ignore.clusters = NULL,
    min.cluster.vaf = 0.01,
    # min probability that CCF(clone) is non-negative
    sum.p = 0.05,
    # alpha level in confidence interval estimate for CCF(clone)                    
    alpha = 0.05                    
)

y <- convert.consensus.tree.clone.to.branch(y, branch.scale = 'sqrt')

plot.clonal.models(
    y, out.dir="./clonevol/"
)

plot.clonal.models(y,
                 box.plot = TRUE,
                 fancy.boxplot = FALSE,
                 clone.shape = 'bell',
                 bell.event = TRUE,
                 bell.event.label.color = 'blue',
                 bell.event.label.angle = 60,
                 clone.time.step.scale = 1,
                 bell.curve.step = 2,
                 merged.tree.plot = TRUE,
                 tree.node.label.split.character = NULL,
                 tree.node.shape = 'circle',
                 tree.node.size = 30,
                 tree.node.text.size = 0.5,
                 merged.tree.node.size.scale = 1.25,
                 merged.tree.node.text.size.scale = 2.5,
                 merged.tree.cell.frac.ci = FALSE,
                 merged.tree.clone.as.branch = TRUE,
                 mtcab.event.sep.char = ',',
                 mtcab.branch.text.size = 1,
                 mtcab.branch.width = 0.75,
                 mtcab.node.size = 3,
                 mtcab.node.label.size = 1,
                 mtcab.node.text.size = 1.5,
                 cell.plot = TRUE,
                 num.cells = 100,
                 cell.border.size = 0.25,
                 cell.border.color = 'black',
                 clone.grouping = 'horizontal',
                 scale.monoclonal.cell.frac = TRUE,
                 show.score = FALSE,
                 cell.frac.ci = TRUE,
                 disable.cell.frac = FALSE,
                 out.dir = 'clonevol',
                 out.format = 'pdf',
                 overwrite.output = TRUE,
                 width = 8,
                 height = 4,
                 panel.widths = c(3,4,2,4,2))


pdf('clonevol/trees.pdf', width = 3, height = 5, useDingbats = FALSE)
plot.all.trees.clone.as.branch(y, branch.width = 0.5,
node.size = 1, node.label.size = 0.5)
dev.off()
