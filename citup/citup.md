# Constructing tree using CITUP 

## Prepare the input data in R

* code-citup-input.R: prepare input data format

## Run CITUP
```
run_citup_iter.py citup-input.tsv --submit local citup-SRR385.h5
run_citup_qip.py citup-input.tsv citup-cluster.tsv citup-SRR385-qip.h5 --submit local
```

## Check the output of CITUP in R

* code-citup-output.R: check output data format





