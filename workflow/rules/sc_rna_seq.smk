ruleorder: mtx_to_h5ad > mtx_to_h5ad_no_metadata

# Converts gene-barcode matricies to h5ad format
rule mtx_to_h5ad:
    input:
        lambda wildcards: config[wildcards.sample]['scRNA-seq']['data'],
        lambda wildcards: config[wildcards.sample]['scRNA-seq']['metadata']    
    output:
        f"{config['output_dir']}/{{sample}}/{{modality}}/mtx_orig.h5ad"
    conda:
        "../envs/sc_rna_seq.yaml"
    script: 
        "../scripts/sc_rna_seq/mtx_to_h5ad.py"


use rule mtx_to_h5ad as mtx_to_h5ad_no_metadata with:
    input:
        lambda wildcards: config[wildcards.sample]['scRNA-seq']['data']


