#!/usr/bin/env Rscript
library('pheatmap')

zscore <- function(){
	# STEP1. Calculate z-score from TPM values
	args <- commandArgs(trailingOnly=TRUE)

	input_file_name <- args[1]
	output_file_name <- args[2]

	data_frame <- read.delim(file=input_file_name, sep='\t',header=TRUE)

	gene <- data_frame[,1]
	TPM <- data_frame[,2:5]
	TPM <- as.matrix(TPM)
	rownames(TPM) <- gene
	TPM.t <- TPM
	for (i in 1:nrow(TPM.t)) {
		TPM.t[i,]<-sapply(TPM.t[i,],function(x){(x-mean(TPM.t[i,]))/sd(TPM.t[i,])})
	
	}
	
	write.csv(TPM.t, file=output_file_name, quote=FALSE) 
	}

heatmap <- function(){
	args <- commandArgs(trailingOnly=TRUE)

	input_file_name <- args[1]

	data <- read.csv(input_file_name, header=T, stringsAsFactors=F, sep=",")
	#data <- read.csv(input_file_name, header=T, stringsAsFactors=F, sep="\t")

	sub.res.ori <- data
	sub.res <- data[,2:ncol(data)]
	rownames(sub.res) <- sub.res.ori[,1]
	
	my_sample_col <- data.frame(Group = rep(c("Raw_siNC","LPS_siNC"),c(2,2)))
	rownames(my_sample_col) <- colnames(sub.res)

	colors = list(Group = c(Raw_siNC="deep sky blue", LPS_siNC="coral"))
	#"dark red", "coral", "orange red", "deep sky blue", "dodger blue", "dark golden rod", "golden rod", "yellow green", "olive drab"

	png("heatmap.png", width=4000, height=4000, res=300)
	pheatmap(t(sub.res), cluster_rows=T, cluster_cols=T,
              clustering_distance_rows = "euclidean", clustering_distance_cols = "euclidean", fontsize_col = 11, clustering_method = "average", 
	      annotation_row = my_sample_col, annotation_colors=colors)
	dev.off()

	}

heatmap2 <- function(){
        data <- read.csv("heatmap_input8_e.txt",header=T,stringsAsFactors=F,sep="\t")

        data <- data[order(data$CMS, decreasing = F),]
#             X  CMS SPIB BCL11A IKZF1 NFE2 BTG2 AKNA TCF7 MYB
#20 PM.AS.0012.T CMS1    0      0     0    0    0    0    0   1
#30 PM.PS.0024.T CMS1    0      1     0    0    0    0    0   1
        sub.res.ori <- data
        sub.res <- data[,c(3:length(data))]
        rownames(sub.res) <- sub.res.ori[,1]

	data_subset <- t(sub.res)

	#Create col and row metadata
	my_sample <- data.frame( 
		c(rep("cond1", 32), rep("cond2", 35)), 
		c(rep("CMS1",3), rep("CMS2",29), rep("CMS3",9), rep("CMS4",26)), 
		row.names=colnames(data_subset))
	colnames(my_sample) <- c("condition","CMS")
#my_sample_col <- data.frame(Group = rep(c("CMS1","CMS2","CMS3","CMS4"),c(3,29,9,26)))
#row.names(my_sample_col) <- colnames(data_subset)

	my_gene <- data.frame( 
		c(rep("AST5",4), rep("AST10",4)), 
		row.names=rownames(data_subset))
	colnames(my_gene) <- c("cluster")
#my_gene_col <- data.frame(cluster = rep(c("AST5","AST10"),c(4,4)))
#rownames(my_gene_col) <- rownames(data_subset)

	my_color = list( 
		cluster = c(AST5="purple", AST10="orange"), 
		CMS = c(CMS1="blue", CMS2="red",CMS3="yellow green",CMS4="deep sky blue"), 
		condition = c(cond1="green", cond2="gold"))
	cols = colorRampPalette(c("white", "red"))(30)

	pheatmap(data_subset, 
		annotation_row = my_gene, annotation_col = my_sample, 
		color = cols, annotation_colors=my_color)
}
zscore()	#./heatmap.r 1_Raw_siNC_LPS_siNC_deg_heatmap.txt 1_Raw_siNC_LPS_siNC_deg_heatmap_Zscore.txt
heatmap()	#./heatmap.r 1_Raw_siNC_LPS_siNC_deg_heatmap_Zscore.txt
heatmap2()	#./heatmap.r heatmap_input8_e.txt

#https://davetang.org/muse/2018/05/15/making-a-heatmap-in-r-with-the-pheatmap-package/
#https://www.biostars.org/p/351551/
