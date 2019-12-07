setwd("../") #working directory
library(timescape)

tree_edges <- read.table("citup/citup-SRR385.optimaltree.tsv",header=FALSE)
colnames(tree_edges) <- c("source","target")
clonal_wide_prev <- read.table("citup/citup-SRR385.clonefreq.tsv",header=FALSE)
cluster_info<- read.table("citup/citup-cluster.tsv",header=FALSE)
sample_info<- read.table("citup/citup-samplename.tsv",header=FALSE,as.is=TRUE)
colnames(clonal_wide_prev) <- sample_info[,1]
clonal_prev <- reshape2::melt(as.matrix(clonal_wide_prev))
colnames(clonal_prev) <- c("clone_id","timepoint","clonal_prev")
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15)

tree_edges <- read.table("citup/citup-SRR385-qip.optimaltree.tsv",header=FALSE)
colnames(tree_edges) <- c("source","target")
clonal_wide_prev <- read.table("citup/citup-SRR385-qip.clonefreq.tsv",header=FALSE)
cluster_info<- read.table("citup/citup-cluster.tsv",header=FALSE)
sample_info<- read.table("citup/citup-samplename.tsv",header=FALSE,as.is=TRUE)
colnames(clonal_wide_prev) <- sample_info[,1]
clonal_prev <- reshape2::melt(as.matrix(clonal_wide_prev))
colnames(clonal_prev) <- c("clone_id","timepoint","clonal_prev")
timescape(clonal_prev = clonal_prev, tree_edges = tree_edges, height=260, alpha=15)
