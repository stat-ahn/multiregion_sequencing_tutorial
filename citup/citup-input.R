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

# output: citup-input.tsv (combined resulted tsv + loci.tsv)
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
           ccf = cellular_prevalence
           ) %>%
    select(gene, cluster, sample_id, ccf)
a.3 <- a.2 %>%
    gather(key, value, -cluster, -gene, -sample_id) %>%
    unite(col,sample_id, key, sep=".") %>%
    spread(col, value) %>%
    filter(cluster < 4) %>%
    mutate(cluster = cluster +1)

write.table(a.3[, -c(1:2)], file='citup/citup-input.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
write.table(a.3[, 2], file='citup/citup-cluster.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
write.table(unlist(strsplit(colnames(a.3[,-c(1:2)]),".ccf")), file='citup/citup-samplename.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
