#!/usr/bin/env Rscript
library(ggplot2)
library(ggsignif)
library(tidyverse)
library(ggpubr)
library(stats)
library(gridExtra)

png("ViolinPlot.png", width=3000, height=2000, res=250)

data <- read.csv("BTG2.t.txt", header=T,stringsAsFactors=F,sep="\t")
h = ggplot(data, aes(x=Tissue, y=TPM, fill=GENE))+geom_violin(trim=FALSE)+geom_jitter(shape=16, position=position_jitter(0.2))+scale_fill_hue(l=50)+coord_cartesian(ylim=c(0,50))
a = h + stat_compare_means(method = "t.test", paired=T, label.x = 1.5, label.y = 45, label="p.signif")

data2 <- read.csv("IKZF1.t.txt", header=T,stringsAsFactors=F,sep="\t")
h = ggplot(data2, aes(x=Tissue, y=TPM, fill=GENE))+geom_violin(trim=FALSE)+geom_jitter(shape=16, position=position_jitter(0.2))+scale_fill_hue(l=50)+coord_cartesian(ylim=c(0,50))
b = h + stat_compare_means(method = "t.test", paired=T, label.x = 1.5, label.y = 45, label="p.signif")

data3 <- read.csv("IRF.t.txt", header=T,stringsAsFactors=F,sep="\t")
h = ggplot(data3, aes(x=Tissue, y=TPM, fill=GENE))+geom_violin(trim=FALSE)+geom_jitter(shape=16, position=position_jitter(0.2))+scale_fill_hue(l=50)+coord_cartesian(ylim=c(0,50))
c = h + stat_compare_means(method = "t.test", paired=T, label.x = 1.5, label.y = 45, label="p.signif")


grid.arrange(a,b,c, nrow=5, ncol=4)
dev.off()
