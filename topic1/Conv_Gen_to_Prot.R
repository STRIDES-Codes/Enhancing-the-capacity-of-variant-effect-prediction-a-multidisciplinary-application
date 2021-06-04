## Install the necessary packages and libraries into R
## This requires R version >  3.5.0 
## Could be cleaned up later into a conda env etc

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
#This was a trial to get the g6pd genes protein coordinates
# https://grch37.ensembl.org/Homo_sapiens/Gene/Summary?db=core;g=ENSG00000160211;r=X:153759606-153775787
# Try the strand thing
# We could define the gene start and end (even the user could)

gnmTest <- GRanges("X", IRanges(start = c(153759606),width = c(15863)))

gnm_prtTEST <- genomeToProtein(gnmTest, edbx)

#Trying stuff
#  X: 153759606-153775469 
gnm <- GRanges("X:107716399-107716401")
library(Gviz)
## Since we're using Ensembl chromosome names we have to set:
options(ucscChromosomeNames = FALSE)

## Define a genome axis track
gat <- GenomeAxisTrack(range = gnm)

## Get all genes in that region
gnm_gns <- getGeneRegionTrackForGviz(edbx, filter = GRangesFilter(gnm))
gtx <- GeneRegionTrack(gnm_gns, name = "tx", geneSymbol = TRUE,
                       showId = TRUE)

## Generate a higlight track
ht <- HighlightTrack(trackList = list(gat, gtx), range = gnm)
## plot the region
plotTracks(list(ht))

gnm_prt_WG <- genomeToProtein(gnm, edbx)

