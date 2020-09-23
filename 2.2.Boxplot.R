#!/usr/bin/env Rscript
library(ggsignif)
library(tidyverse)
library(rstatix)
library(ggpubr)

res.list <- dir(pattern="*.t.txt")
for (i in 1:length(res.list)){
	dat <- read.table(res.list[i], header=T)
	print(res.list[i])
	name <- unlist(strsplit(res.list[i],split=".t.txt"))	

	png(paste0(name,".png"), height=2000, width=2000,res=250)

	h <- compare_means(TPM ~ Tissue,  data = dat, method = "t.test", paired=T)
	write.table(h,paste0(name,".out"), col.names=T, row.names=T, sep='\t', quote=F)

	p <- ggboxplot(dat, x = "Tissue", y = "TPM",
       	  color = "Tissue",  palette = "jco",add = "jitter")
	p1 <- p + stat_compare_means(method = "t.test", paired=T, label.x = 1.5, label.y = 45, label="p.signif")		
	print(p1)
	dev.off()
}

###########################################
dat <- read.table("plot_input2.txt", header=T)
compare_means(TPM ~ Tissue,  data = dat, group.by="GENE", method = "t.test", paired=T)

