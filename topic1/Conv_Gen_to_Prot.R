## Install the necessary packages and libraries into R
## This requires R version >  3.5.0 

#Install the latest bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.13")

#Install the biomaRt package
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("biomaRt")

#Install the ensembldb package
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ensembldb")

# Install the ensembl db you wish to access, this is a human db, from ensembl version 86
# This is from the following example - https://www.bioconductor.org/packages/devel/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html#3_Mapping_genomic_coordinates_to_protein-relative_coordinates

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("EnsDb.Hsapiens.v86")

## Code to convert coordinates
