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

STEP1_BOXPLOT <- function(
        ){
        library(ggplot2)
        library(ggpubr)
        file_list = dir(pattern="*input.txt")
        for (i in 1:length(file_list)){
                data <- read.csv(file_list[i], header=T, stringsAsFactors=F, sep='\t')
                sample = unlist(strsplit(file_list[i], split='_'))[1]
                print(sample)
                head(data,2)

                png(paste0("DDX3Y_",sample,".png"), width=800, height=1000,res=200)
                h <- ggboxplot(data, x = "Tissue", y = "X1", color = "Tissue", add = "jitter", legend = "right", ylim=c(0,100)) + labs(title="gene1", x="", y = "Methylation (%)")+theme(plot.title = element_text(hjust = 0.5,size=22,color='purple',face="bold"))+font("xlab", size = 18)+font("ylab", size = 18)
                a <- h + stat_compare_means(method = "wilcox.test", size =8)
                print(a)

                #a <- h + stat_compare_means(method = "wilcox.test",paired = FALSE)
                #a <- h + stat_compare_means(method = "t.test",paired = FALSE)
                #a <- h + stat_compare_means(aes(label = ..p.signif..), method = "wilcox.test") #****
                dev.off()
}

