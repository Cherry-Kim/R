#!/usr/bin/env Rscript
library(ggplot2)
library(ggsignif)
library(tidyverse)
library(rstatix)
library(ggpubr)

file_list = dir(pattern="*.t.txt")
for (i in 1:length(file_list)){
	data <- read.csv(file_list[i], header=T,stringsAsFactors=F,sep="\t")
	sample = unlist(strsplit(file_list[i],split=".t.txt"))
#	print(sample)

	png(paste0(sample,".png"), width=800, height=600, res=200)
	h <- ggplot(data, aes(x=Tissue, y=TPM, fill=GENE))+geom_violin(trim=FALSE)+geom_jitter(shape=16, position=position_jitter(0.2))+theme(axis.title = element_text(size=10))+theme(axis.text = element_text(face="bold",size=8))+scale_fill_hue(l=50)+coord_cartesian(ylim=c(0,50))
	    + stat_compare_means(method = "t.test", paired=T, label.x = 1.5, label.y = 45, label="p.signif")
	print(h2)
	a <- compare_means(TPM ~ CMS, method = "anova")
	print(a)
	dev.off()
}
