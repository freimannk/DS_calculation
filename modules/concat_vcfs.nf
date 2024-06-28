#!/usr/bin/env nextflow
nextflow.enable.dsl=2


process CONCAT_VCFS{ 
    container = 'quay.io/eqtlcatalogue/susie-finemapping:v20.08.1'
    publishDir "${params.outdir}/concated_vcf", mode: 'copy'



    input:
    tuple file(autosomal_PAR_vcf), file(autosomal_PAR_vcf_index)
    tuple file(non_PAR_vcf), file(non_PAR_vcf_index)


    output:
    file("${params.concated_vcf_file_name}.vcf.gz")

    script:
        """
        bcftools concat ${autosomal_PAR_vcf} ${non_PAR_vcf} -Oz -o ${params.concated_vcf_file_name}.vcf.gz

        """

}