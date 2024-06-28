#!/usr/bin/env python3


import argparse
import hail as hl

parser = argparse.ArgumentParser(description="")

parser.add_argument('-v', '--vcf', required=True, type=str,
                    help="VCF.gz or vcf file with GT field to calculate DS (chr labeled in vcf as chr*)")
parser.add_argument('-n', '--updated_file_name', required=True, type=str,
                    help="Updated vcf file name")
args = parser.parse_args()
hl.init()
recode = {f"{i}": f"chr{i}" for i in (list(range(1, 23)) + ['X', 'Y'])}
data = hl.import_vcf(args.vcf,
                             force=True, reference_genome='GRCh38', contig_recoding=recode)
data_w_DS = data.annotate_entries(DS=data.GT.n_alt_alleles())
hl.export_vcf(data_w_DS, f"{args.updated_file_name}_DS.vcf.bgz", tabix=True)
















