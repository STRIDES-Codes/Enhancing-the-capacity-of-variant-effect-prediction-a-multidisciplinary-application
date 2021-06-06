##load libaries
library(e1071)
library(naivebayes)
library(dplyr)
library(ggplot2)
library(psych)
library(plyr)
library(caret) 

## load data
dataset <- read.csv("~/Desktop/swaat_codeathon/dataset")
View(dataset)



### load energy class
energyclass <- read.csv("~/Desktop/swaat_codeathon/energyclass.csv", header=FALSE)
View(energyclass)

########## Binary classification (NBC) ###### 
energyclass=energyclass[-1,]
View(energyclass) 
energyclass=energyclass[,2]
class(energyclass)
length(energyclass)

SwaatData=cbind(dataset,energyclass)
ClassEnergy <- mapvalues(SwaatData$energyclass, from = c("0", "1"), to = c("Neu", "High"))
SwaatData1=cbind(dataset,ClassEnergy)

set.seed(1234)
xtabs(~ClassEnergy, data=SwaatData1)

classifier_cl = naiveBayes(ClassEnergy~ ., data = SwaatData1)
classifier_cl

# Predicting on test data'
variant_pred <- predict(classifier_cl, newdata = SwaatData1)

# Confusion Matrix
Atab <- table(SwaatData1$ClassEnergy, variant_pred)

# Model Evauation
confusionMatrix(Atab)


############ Binary (NBC with PCA)

## Using Caret
PreProcessed = preProcess(SwaatData2,method = "pca",prComp = 90)
SwaatPC = predict(PreProcessed,SwaatData2)
head(SwaatPC)
dim(SwaatPC)
  
SwaatData3=cbind(SwaatPC,ClassEnergy)

xtabs(~ClassEnergy, data=SwaatData3)

##naiveBayes model
model=  naiveBayes(ClassEnergy ~ ., data=SwaatData3)
model


# Predicting on  data'
variant_pred1 <- predict(model, newdata = SwaatData3)

# Confusion Matrix
Atab1 <- table(SwaatData1$ClassEnergy, variant_pred)

# Model Evauation
confusionMatrix(Atab1)



###### Multiclass classification (NBC)
energyclass2 <- read.csv("~/Desktop/swaat_codeathon/energyclass2.csv", header=FALSE)
View(energyclass2)


energyclass2=energyclass2[-1,]
View(energyclass2) 
energyclass2=energyclass2[,2]
View(energyclass2)
#length(energyclass)

SwaatData=cbind(dataset,energyclass2)
View(SwaatData)

ClassEnergy2 <- mapvalues(SwaatData$energyclass2, from = c("0", "1","2"), to = c("Neu", "stable","Destable"))
View(ClassEnergy2)

SwaatData21=cbind(dataset,ClassEnergy2)

xtabs(~ClassEnergy2, data=SwaatData21)
Multi1<- naiveBayes(ClassEnergy2~ ., data = SwaatData21)
Multi1

# Predicting on data'
Multi_pred <- predict(Multi1, newdata = SwaatData21)

# Confusion Matrix
Atab2 <- table(SwaatData21$ClassEnergy2, Multi_pred)
Atab2

# Model Evauation
confusionMatrix(Atab2)



################################# multiclass with PCA
SwaatData21 = SwaatData21[1:nrow(SwaatData21),1:ncol(SwaatData21)-1]
prComp = prcomp(SwaatData21)

## Using Caret
PreProcessed = preProcess(SwaatData21,method = "pca",prComp = 90)
SwaatMultiPC = predict(PreProcessed,SwaatData21)
head(SwaatMultiPC)


SwaatDataMpc=cbind(SwaatMultiPC,ClassEnergy2)
View(SwaatDataMpc)
xtabs(~ClassEnergy2, data=SwaatDataMpc)

classifier_clM <- naiveBayes(ClassEnergy2~ ., data = SwaatDataMpc)
classifier_clM

# Predicting on test data'
MultiPCA_pred <- predict(classifier_clM, newdata = SwaatDataMpc)

# Confusion Matrix
Atab3 <- table(SwaatDataMpc$ClassEnergy2, MultiPCA_pred)


# Model Evauation
confusionMatrix(Atab3)








