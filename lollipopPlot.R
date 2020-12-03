#!/usr/bin/env Rscript

hy_sy = function(pd="", GENE){ 
	library(maftools)
	setwd(pd)
	file_list <- dir(pattern="IRD")
	file_list_cnt <- length(file_list)

	maf_merge <- c()
	for (i in 1:file_list_cnt) {
		lst <- paste("IRD",i,sep="")
		assign(lst, read.maf(maf=file_list[i]))
		# paste("IRD",i,sep="") = read.maf(maf=file_list[i])
		#IRD1 <- read.maf(maf="IRD-0014.txt")
		#IRD2 <- read.maf(maf="IRD-0015.txt")

		maf_merge <- append(maf_merge,get(lst))
	}

	IRD_merge <- merge_mafs(mafs=maf_merge ,verbose=TRUE)
	#IRD_merge <- merge_mafs(mafs=c(IRD1,IRD2),verbose=TRUE)

	pdf('lollipop.pdf',paper='letter')
	for (i in 1:length(GENE)) {	
		lollipopPlot(maf = IRD_merge, gene=GENE[i], showDomainLabel =FALSE, labelPos='all')
	}
	dev.off()
	#lollipopPlot(maf = IRD_merge, gene='GUCY2D', showDomainLabel =FALSE, labelPos='all')

	pdf('oncoplot.pdf',paper='letter')	
	oncoplot(maf = IRD_merge, genes=GENE)
	dev.off()
}

#source("lollipopPlot.R")
hy_sy( pd="/home/hykim/Project/KHB", GENE <- c('GUCY2D',"TAL1") )
