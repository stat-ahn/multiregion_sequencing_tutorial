# Constructing tree using LICHeE

## Prepare the input data in R

* code-lichee-input.R: prepare input data format

## Run CITUP
```
./lichee -build -i ./SRR385-lichee.tsv  -maxVAFAbsent 0.005 -minVAFPresent 0.005 -n 0 -minPrivateClusterSize 2 -showTree 1 -s 1 -cp -o ./SRR385-lichee-output.tsv
./lichee -build -i ./SRR385-lichee.tsv  -maxVAFAbsent 0.005 -minVAFPresent 0.005 -n 0 -minPrivateClusterSize 2 -showTree 1 -s 1 -cp 
```






