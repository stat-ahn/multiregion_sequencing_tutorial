
[comment]: # (working directory: ./pyclone)
[comment]: # (https://bitbucket.org/aroth85/pyclone/wiki/Home)


PyClone run
```
PyClone run_analysis_pipeline --in_files tsv/SRR385938.tsv tsv/SRR385939.tsv tsv/SRR385940.tsv tsv/SRR385941.tsv --working_dir outputall --density pyclone_beta_binomial --max_clusters 4

```

PyClone run separately
```
PyClone build_mutations_file --in_file tsv/SRR385938.tsv --out_file yaml/SRR385938.yaml
PyClone build_mutations_file --in_file tsv/SRR385939.tsv --out_file yaml/SRR385939.yaml
PyClone build_mutations_file --in_file tsv/SRR385940.tsv --out_file yaml/SRR385940.yaml
PyClone build_mutations_file --in_file tsv/SRR385941.tsv --out_file yaml/SRR385941.yaml
PyClone run_analysis --config_file config.yamli
```

