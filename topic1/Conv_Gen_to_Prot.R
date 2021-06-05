## Install the necessary packages and libraries into R
## This requires R version >  3.5.0 
## Could be cleaned up later into a conda env etc
## this version of bionconductor wants R > v4.1
## If you have it, skip it 

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
library(ensembldb)
library(EnsDb.Hsapiens.v86)

edbx <- filter(EnsDb.Hsapiens.v86, filter = ~ seq_name == "X")

gnm <- GRanges("X", IRanges(start = c(630898, 644636, 644633, 634829),
                            width = c(12, 1, 1, 3)))
gnm_prt <- genomeToProtein(gnm, edbx)

gnm_prt

#Where the magic happens
# 


# This is what we would want in the end: 
# OUTPUT: acsv/tsv file 
# AA_ID	chr	AA	start	 end
#     1	6	  R	  12321	 12323
#     2	6	  H	  12324	 12326
#
# With ENSP ID! Matching uniprot! (we had to check this based on uniprot P10635)
# CYP2D6 - ENSP00000351927 
#summon the db
library(EnsDb.Hsapiens.v86)
edb <- EnsDb.Hsapiens.v86

#Split the DB to the chr of interest (22 for CYP2D6)
edx22 <- filter(EnsDb.Hsapiens.v86, filter = ~ seq_name == "22")

# Select the AA (we need to loop this for each AA, could tie to seq retrieval and conversion!)
CYP2D6_protein <- IRanges(start = 1, end = 1, names = "ENSP00000351927")

#Convert to genomic coordinates
CYP2D6_gnm <- proteinToGenome(CYP2D6_protein, edx22)
#to look at all what was retrieved
CYP2D6_gnm

#This is the string to see your coords
CYP2D6_gnm[["ENSP00000351927"]]@ranges

#Sequence retrieval
prts <- proteins(edb, filter = ProteinIdFilter("ENSP00000351927") ,return.type = "AAStringSet")

# The AA seq is there but we havent found a way to pull it out, its "seq"
prts
