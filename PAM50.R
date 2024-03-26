#https://www.bioconductor.org/packages/release/bioc/vignettes/genefu/inst/doc/genefu.html 
#BiocManager::install("genefu")
library(genefu)
library(xtable)
library(rmeta)
library(Biobase)
library(caret)
data(pam50.robust)
data(scmod2.robust)

dd <- read.csv('ddata.csv', header=T, row.names=1)
annot <- read.csv('dannot.csv', header=T)
head(dd[,1:3])
#     NM_000662 NM_001168 NM_004323
#sample1   -0.61397 -0.044513 -0.069973
#sa2ple1    0.23311 -0.021574  0.166060
head(annot[,1:3])
#               X          probe EntrezGene.ID
#1 Contig45645_RC Contig45645_RC         64388

annote_new<-dannot[which(dannot[,1]%in%colnames(dd)),]

PAM50Preds<-molecular.subtyping(sbt.model = "pam50", data=dd, annot=annot, do.mapping=TRUE)
table(PAM50Preds$subtype)
PAM50Preds$subtype

SubtypePredictions <- molecular.subtyping(sbt.model = "scmod2",data = dd, annot=annote_new, do.mapping = TRUE)
SubtypePredictions$subtype
table(SubtypePredictions$subtype)

#Select samples pertaining to Basal Subtype
Basals<-names(which(SubtypePredictions$subtype == "ER-/HER2-"))
HER2s<-names(which(SubtypePredictions$subtype == "HER2+"))
LuminalB<-names(which(SubtypePredictions$subtype == "ER+/HER2- High Prolif"))
LuminalA<-names(which(SubtypePredictions$subtype == "ER+/HER2- Low Prolif"))
