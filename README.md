# Workflow to calculate DS with Hail

Workflow uses Hail: [Hail Team. Hail 0.2.131-11d9b2ff89da.](https://github.com/hail-is/hail/releases/tag/0.2.131) 


## Usage examples

###  Running the workflow

```
nextflow run main.nf -resume
```

Pipeline should create the following files in your working directory:

```bash
work            # Directory containing the nextflow working files
{outdir}/concatenated_vcf/         # Concatenated VCF file with DS field 
```


###  Info needed in nextflow.config file

* autosomal_PAR_vcf : path to the VCF file containing autosomal chromosomes and the chrX PAR region with GT field
* non_PAR_vcf : path to the VCF file containing the chrX non-PAR region without structural variants with GT field
* metadata : path to the metadata file containing columns `genotype_id` and `sex`. The sex column must exclusively contain values `female` and `male`.
* concated_vcf_file_name : output VCF.gz file name
* outdir : output path
