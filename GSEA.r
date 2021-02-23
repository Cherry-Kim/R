#genpattern ID:syjoo2304, PW:password1!

source("GSEA_sub.r")

## Make CLS file
# Input: Expression data 1st column gene symbol.
#install.packages('xlsx')
library(xlsx)
fileXlsx<-read.xlsx2('RAW.xlsx',header=T,sheetIndex=1)
fileXlsx <- as.data.frame(fileXlsx,stringsAsFactors=F)

#Generating sampleinfo data for cls file
Sample <- as.data.frame(colnames(fileXlsx)[-1],stringsAsFactor=F)
names(Sample) <- "SampleID"

G1 <- as.character(Sample$SampleID[grepl("Raw_siNC_1",Sample$SampleID)])
G2 <- as.character(Sample$SampleID[grepl("Raw_siMix_2",Sample$SampleID)])
G3 <- as.character(Sample$SampleID[grepl("LPS_siNC_3",Sample$SampleID)])
G4 <- as.character(Sample$SampleID[grepl("LPS_siMix",Sample$SampleID)])

subtype1 = list('G1'=G1,'G2'=G3)
subtype2 = list('G1'=G2,'G3'=G4)
subtype3 = list('G1'=G1,'G4'=G4)
subtype4 = list('G2'=G2,'G3'=G3)
subtype5 = list('G2'=G1,'G4'=G2)
subtype6 = list('G3'=G3,'G4'=G4)

#Make CLS file
for (i in seq(6)){
	cls_make <- get(paste('subtype',i,sep=''))
	cls_maker(input_list = cls_make,file_export = paste('P',i,'_GSEA.cls',sep=''))	
}

###########################################
#Pre-processing for GCT file
for (i in seq(6)){
	col_select <- get(paste('subtype',i,sep=''))
	assign(paste('gct.input',i,sep=''),cbind(fileXlsx$Feature.ID,fileXlsx[,unlist(col_select)]))
	x = get(paste('gct.input',i,sep=''))
	colnames(x)[1] = 'symbol'
	x = dup.matrix(x,key_column = 'symbol',max)
	x$symbol <- toupper(x$symbol)
	assign(paste('gct.input',i,sep=''),x)
		
}


#Factor to numeric & Scaling
co <- 1
for (i in paste0('gct.input',1:6)){
	x <- get(i)
	#Factor to numeric
	x[,2] <- as.numeric(as.character(x[,2]))
	x[,3] <- as.numeric(as.character(x[,3]))
	x[,4] <- as.numeric(as.character(x[,4]))
	x[,5] <- as.numeric(as.character(x[,5]))
	#Scaling
#	x[,-1]=apply(x[,-1],2,function(k){
#          round(log2(k/sum(k)*1e+6+1),5)
#        })
        x=x[which(x$symbol!=''),]

	png(paste(co,'.png',sep=''))
        boxplot(x[,2:5])
	dev.off()

        head(x[,1:5])
	gct_maker(input = x,file_export = paste(co,'_','GSEA.gct',sep=''))
	co <- co+1 
}
	

# Check whether sample order identical
identical(colnames(gct.input)[-1],as.vector(unlist(subtype)))
