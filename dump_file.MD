# Dump all notes or bits here
Its sort of a filtered version of our sketch file:
https://docs.google.com/document/d/1B9IwwWGrIxScWaakNaTiNLVlafGndmDw6KI9xmf0Zrc/edit?usp=sharing
(team access only)

### Its about the journey! 


## Task 1 - Rep Transvar
Things to consider: 
	1.) Uniprot sequence may not match ensembl (another part of swaat takes raw data from uniprot with uniprotID, it parses annotation data, and it needs to match). 
	2.) How to select the canonical transcript (will affect variant outcome i.e missense, intron etc)
	3.) It would be ideal to have an input of genome reference version (37, 38) to match coordinates
	4.) If biomart server down, alert user correctly


Barriers: 
We can use Biomart to retrieve variant info, with coord, protein allele. Problem is that these are listed for variants and not in a base genome sense.
Idea - test other genes to see if this happens a lot
Some positions have missing protein alleles 
Pot FIX - Can we use the protein fasta to obtain the AA and position, to match what biomart returned. 

WORKAROUND - New bioconductor package:
https://www.bioconductor.org/packages/devel/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html#3_Mapping_genomic_coordinates_to_protein-relative_coordinates

## Task 2
Problem: SWAAT uses a random forest machine learning model to classify variants based on structural features. 
While this model outperforms genomic classifiers, it could still be improved in terms of accuracy and specificity. 

Try out some other models!

Try to make a multiclassifier

## Task 3

Goal: generate a basic version of a web app.
VCF > treatment at the back-end > report (rendered)/raw data cvs/tsv 

Sketching the output (designing the interactive interface)
PAPER PROTOTYPES

Generate dummy nextflow pipeline - just to test running.
