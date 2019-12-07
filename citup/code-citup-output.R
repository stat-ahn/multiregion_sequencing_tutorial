setwd("../") #working directory

library(rhdf5)
h5f = H5Fopen("citup/citup-SRR385.h5")
h5f&'results'
h5f&'results'&'optimal'
h5f$"/results/optimal/index"[1] #The first index: 175
index1 <- h5f$"/results/optimal/index"[1]
h5closeAll()

h5foptimal <- h5read("citup/citup-SRR385.h5", paste0("trees/",index1))
h5foptimal$'adjacency_list'$block0_values #ancestor node, descendant node
h5foptimal$'clone_freq'$block0_values #clonal frequency
write.table(t(h5foptimal$'adjacency_list'$block0_values), file='citup/citup-SRR385.optimaltree.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
write.table(h5foptimal$'clone_freq'$block0_values, file='citup/citup-SRR385.clonefreq.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
h5closeAll()

h5f = H5Fopen("citup/citup-SRR385-qip.h5")
h5f&'results'
h5f&'results'&'optimal'
h5f$"/results/optimal/index"[1] #The first index: 175
index1 <- h5f$"/results/optimal/index"[1]
h5closeAll()

h5foptimal <- h5read("citup/citup-SRR385-qip.h5", paste0("trees/",index1))
h5foptimal$'adjacency_list'$block0_values #ancestor node, descendant node
h5foptimal$'clone_freq'$block0_values #clonal frequency
write.table(t(h5foptimal$'adjacency_list'$block0_values), file='citup/citup-SRR385-qip.optimaltree.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
write.table(h5foptimal$'clone_freq'$block0_values, file='citup/citup-SRR385-qip.clonefreq.tsv', quote=FALSE, sep='\t', col.names = FALSE, row.names=FALSE)
h5closeAll()


