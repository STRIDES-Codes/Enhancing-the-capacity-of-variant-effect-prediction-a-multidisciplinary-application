# Enhancing-the-capacity-of-variant-effect-prediction-a-multidisciplinary-application


##  SWAAT - Structural Workflow for Annotating ADME Targets
This work is to update and upgrade SWAAT. SWAAT is a workflow that uses structural properties of missense variants to predict the likely outcome (deleterious, benign). ADME genes are those involved in key facets of drug metabolism. Variants in these genes may result in adverse reactions, which may be related to drug safety or efficacy. Classifying variants in terms of protein impact (Deleterious, Neutral, Benign) could be used to help prevent adverse reactions or assist in drug safety protocols.


Regarding upgrading - there are three main areas to be addressed.


## TASK 1 - Replace the Transvar based mapping of protein and genomic coordinates part of the workflow

### Problem
SWAAT uses depreciated Transvar to map genomic to protein coordinates
Task - 
Match the amino acids in a sequence of a human protein to their genome coordinates. 

We needed an output that looks like this:

AA_ID	chr	AA	start	end

1	    6	  R 	12321	12323

2	    6	  H	  12324	12326

### Codeathon Results
Given a ensembl proteinID, we have developed an[ R script ](https://github.com/STRIDES-Codes/Enhancing-the-capacity-of-variant-effect-prediction-a-multidisciplinary-application/blob/main/topic1/Conv_Gen_to_Prot.R)to retrieve the amino acid sequence of that protein, convert that to a dataframe and add the numerical sequence. With this sequence, we can query for the genomic coordinate (GRch38) and add it to that dataframe, and output a csv file. 

Workflow of the process:
![r_gen-prot_coords](https://user-images.githubusercontent.com/20955296/120924716-e3a80700-c6cc-11eb-89c8-86f0c38149ff.png)

Example of output for CYP2D6 (GRch38)

"ID","RefAminoAcid","CHR","start","end"

1,"M",22,42130789,42130791

2,"G",22,42130786,42130788

3,"L",22,42130783,42130785




Next steps - we can retrieve the seq - we can use this to create a table of position and AA which can match to the coords retrieved

## TASK 2 - Assess additional machine learning methods for SWAATS's classification functions
### Problem
SWAAT uses a random forest machine learning model to classify variants based on structural features. 
While this model outperforms genomic classifiers, it could still be improved in terms of accuracy and specificity. 

Investigate other ML methods to improve SWAAT Predictions, code is hosted currently in this [R script](https://github.com/STRIDES-Codes/Enhancing-the-capacity-of-variant-effect-prediction-a-multidisciplinary-application/blob/main/topic2/SWAAt.R).



### Progress  5 June
naive bayes classifier and NBC with PCA
Multiclass modeling  (splitting data into categories) 

NB:: The accuracy for the multiclass is quite low  (0.5861) more effort should 
be channelled here to get a better accuracy. Tried to improve w PCA - Accuracy : 0.602        

Next Steps:
There are some issues with data transformation, specifically regarding negative integers as part of data to assess. 

## TASK 3 - Run SWAAT on a webserver
### Goal
Generate a basic version of a web app.
VCF input > treatment at the back-end (SWAAT) > report (rendered)/raw data cvs/tsv 

### Progress 5 June
A basic HTML/CSS code for the user interface (front end) has been [built](https://github.com/STRIDES-Codes/Enhancing-the-capacity-of-variant-effect-prediction-a-multidisciplinary-application/tree/main/topic3). 
Back end, deploying a Flask app to handle input and run SWAAT.

![flowRoot1336](https://user-images.githubusercontent.com/20955296/120924904-f0792a80-c6cd-11eb-8642-adf7f7d08764.png)

Next steps:


## Contributors
Houcem Othman

Isabel Mensah

Tsaone Tamuhla

Yagoub Adam

Jorge da rocha 

Kais Ghedira

Yaniv Swiel
