## Users need to change the list of tsv file names.
## tsv file format: PyClone input tsv format
setwd("../") #working directory
tsvfilelists <- c("data/tsv/SRR385938.tsv",
               "data/tsv/SRR385939.tsv",
               "data/tsv/SRR385940.tsv",
               "data/tsv/SRR385941.tsv")

library(dplyr)
library(Clomial)
cC <- rep('NULL', 9)
cC[c(1)]<- 'character'
cC[c(3)]<- 'integer'
for(i in 1:length(tsvfilelists)){
    Ri <- read.table(tsvfilelists[i], sep="\t", header=T, colClasses=cC)
    if(i == 1){
        Rn <- Ri
    }else{
        Rn <- Rn %>%
            inner_join(Ri, by="mutation_id")
    }
}
cC <- rep('NULL', 9)
cC[c(1)]<- 'character'
cC[c(2)]<- 'integer'
for(i in 1:length(tsvfilelists)){
    Ti <- read.table(tsvfilelists[i], sep="\t", header=T, colClasses=cC)
    if(i == 1){
        Tn <- Ti
    }else{
        Tn <- Tn %>%
            inner_join(Ti, by="mutation_id")
    }
}
Dr <- Rn[,-1]
Dt <- Tn[,-1]
Dc <- Dr + Dt
colnames(Dt) <- paste("S", 1:length(tsvfilelists),sep="")
colnames(Dc) <- paste("S", 1:length(tsvfilelists),sep="")


set.seed(20)
ClomialResult<-Clomial(Dc=Dc,Dt=Dt,maxIt=20,C=5,doParal=FALSE,binomTryNum=50,fliProb=0)
chosen <- choose.best(models=ClomialResult$models)
M1 <- chosen$bestModel
print("Genotypes:")
print(round(M1$Mu))
print("Clone frequencies:")
print(round(M1$P,2))
