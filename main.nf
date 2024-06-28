#!/bin/bash nextflow
nextflow.enable.dsl=2

include { CALCULATE_AUTOSOMAL_PAR_DS; CALCULATE_NON_PAR_DS } from './modules/calculate_DS'
include {CONCAT_VCFS} from './modules/concat_vcfs'





workflow {
    autosomal_PAR_vcf_ch = Channel.fromPath(params.autosomal_PAR_vcf, checkIfExists: true).collect()
    non_PAR_vcf_ch = Channel.fromPath(params.non_PAR_vcf, checkIfExists: true).collect()
    metadata_ch = Channel.fromPath(params.metadata, checkIfExists: true).collect()
    CALCULATE_AUTOSOMAL_PAR_DS(autosomal_PAR_vcf_ch)
    CALCULATE_NON_PAR_DS(non_PAR_vcf_ch, metadata_ch)
    CONCAT_VCFS(CALCULATE_AUTOSOMAL_PAR_DS.out, CALCULATE_NON_PAR_DS.out)

    
}