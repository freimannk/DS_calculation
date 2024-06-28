#!/usr/bin/env python3

import argparse
import hail as hl

parser = argparse.ArgumentParser(description="")

parser.add_argument('-v', '--vcf', required=True, type=str,
                    help="VCF.gz or vcf file with GT field to calculate DS (chr labeled in vcf as chr*)")
parser.add_argument('-m', '--metadata_file', required=True, type=str,
                    help="Metadata file containing genotype_id and sex fields")
parser.add_argument('-n', '--updated_file_name', required=True, type=str,
                    help="Updated vcf file name")

args = parser.parse_args()


hl.init()
recode = {f"{i}": f"chr{i}" for i in (list(range(1, 23)) + ['X', 'Y'])}
data_non_par = hl.import_vcf(args.vcf,
                             force=True, reference_genome='GRCh38', contig_recoding=recode)
samples_metadata = hl.import_table(args.metadata_file,
                                   key='genotype_id')
samples_metadata = samples_metadata.key_by('genotype_id')
data_non_par = data_non_par.annotate_cols(sample_metadata=samples_metadata[data_non_par.s])
data_non_par = data_non_par.annotate_entries(DS=data_non_par.GT.n_alt_alleles())
data_non_par = data_non_par.annotate_entries(DS=hl.if_else(data_non_par.sample_metadata.sex == 'male',
                                                           data_non_par.DS * 2,
                                                           data_non_par.DS))
hl.export_vcf(data_non_par, f"{args.updated_file_name}_DS.vcf.bgz", tabix=True)
















