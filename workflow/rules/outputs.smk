import sys

from pathlib import Path
from typing import List


def get_sc_rna_seq_output(config: dict) -> List[str]:
    outputs = []

    input_list = list(set(config.keys()) - set(["output_dir"]))
    
    for input in input_list:
        
        if "scRNA-seq" in config[input]:
            outputs.append(f"{config['output_dir']}/{input}/scRNA-seq/mtx_orig.h5ad")
    
    return outputs
        


def get_final_output(confi: dict) -> List[str]:
    outputs = []

    outputs.extend(get_sc_rna_seq_output(config))

    return outputs