#!/usr/bin/env Rscript

hy_sy = function(pd="", GENE){ 
	library(maftools)
	setwd(pd)
	file_list <- dir(pattern=".txt")
	file_list_cnt <- length(file_list)

	maf_merge <- c()
	for (i in 1:file_list_cnt) {
		lst <- paste("colon",i,sep="")
		assign(lst, read.maf(maf=file_list[i]))
		# paste("colon",i,sep="") = read.maf(maf=file_list[i])
		#IRD1 <- read.maf(maf="colon-0014.txt")
		#IRD2 <- read.maf(maf="colon-0015.txt")

		maf_merge <- append(maf_merge,get(lst))
	}

	colon_merge <- merge_mafs(mafs=maf_merge ,verbose=TRUE)
	#colon_merge <- merge_mafs(mafs=c(colon1,colon2),verbose=TRUE)

	pdf('lollipop.pdf',paper='letter')
	for (i in 1:length(GENE)) {	
		lollipopPlot(maf = colon_merge, gene=GENE[i], showDomainLabel =FALSE, labelPos='all')
	}
	dev.off()
	#lollipopPlot(maf = colon_merge, gene='GUCY2D', showDomainLabel =FALSE, labelPos='all')

	pdf('oncoplot.pdf',paper='letter')	
	oncoplot(maf = colon_merge, genes=GENE)
	dev.off()
}

#source("lollipopPlot.R")
hy_sy( pd="/home/hykim", GENE <- c('BRACA1',"BRACA2") )
