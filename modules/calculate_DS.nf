#!/usr/bin/env nextflow
nextflow.enable.dsl=2



process CALCULATE_AUTOSOMAL_PAR_DS{  
    container = 'quay.io/kfkf33/hail_ds_calc'

    input:
    file vcf

    output:
    tuple file("${vcf.simpleName}_DS.vcf.bgz"), file("${vcf.simpleName}_DS.vcf.bgz.tbi")   


    script:
        """
            calc_autosomal_PAR_DS.py -v ${vcf} -n ${vcf.simpleName}


        """
}


process CALCULATE_NON_PAR_DS{  
    container = 'quay.io/kfkf33/hail_ds_calc'

    input:
    file vcf
    file metadata

    output:
    tuple file("${vcf.simpleName}_DS.vcf.bgz"), file("${vcf.simpleName}_DS.vcf.bgz.tbi")   


    script:
        """
            calc_non_PAR_DS.py -v ${vcf} -m ${metadata} -n ${vcf.simpleName}


        """
}