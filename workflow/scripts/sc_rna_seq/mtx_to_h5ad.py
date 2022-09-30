import anndata
import pandas as pd
import scanpy as sc
import sys

from anndata import AnnData
from pathlib import Path



def add_metadata(adata, metadata_path):
    metadata = pd.read_csv(metadata_path, index_col=0)

    for col_name in metadata.columns:
        adata.obs[col_name] = pd.Categorical(metadata[col_name])
    
    return adata


def from_csv(data_path, metadata_path=None):
    adata = anndata.read_csv(data_path, dtype="int")
    
    if metadata_path:
       adata = add_metadata(adata, metadata_path)
    
    return adata


def from_folder(data_path, metadata_path=None):
    adata = sc.read_10x_mtx(data_path, var_names="gene_symbols")

    if metadata_path:
       adata = add_metadata(adata, metadata_path)
    
    return adata
   

def main(snakemake):
    
    data_path = Path(snakemake.input[0])
    metadata_path = Path(snakemake.input[1]) if len(snakemake.input) > 1 else None

    if data_path.suffix == ".csv":
        adata = from_csv(data_path, metadata_path=metadata_path)
    elif data_path.is_dir():
        adata = from_folder(data_path, metadata_path=metadata_path)
    else:
        print(f"Error in recognizing file type. ", file=sys.stderr)
        exit(1)
    
    adata.write(snakemake.output[0])


if __name__ == "__main__":
    main(snakemake)