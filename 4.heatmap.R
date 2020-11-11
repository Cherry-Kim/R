#!/usr/bin/env Rscript
library(pheatmap)
data <- read.csv("Normalized.txt",header=T,stringsAsFactors=F,sep="\t")

#sub.res.ori <- data 	
sub.res.ori <- data[,c(1:227)]
#sub.res <- data[,2:ncol(data)]	
sub.res <- data[,c(2:227)]
rownames(sub.res) <- sub.res.ori[,1]

#my_sample_col <- data.frame(Group = rep(c("T","N"),c(226,226)))
#rownames(my_sample_col) <- colnames(sub.res)

#colors = list(Group = c(T="red", N="blue"))
#"dark red", "coral", "orange red", "deep sky blue", "dodger blue", "dark golden rod", "golden rod", "yellow green", "olive drab"

png("heatmap_T.png", width=4000, height=4000, res=300)
pheatmap(t(sub.res), cluster_rows=T, cluster_cols=T,
              clustering_distance_rows = "euclidean", clustering_distance_cols = "euclidean", fontsize_col = 11, clustering_method = "average")
#pheatmap(t(sub.res), cluster_rows=T, cluster_cols=T,
#              clustering_distance_rows = "euclidean", clustering_distance_cols = "euclidean", fontsize_col = 11, clustering_method = "average", annotation_row = my_sample_col, annotation_colors=colors)
dev.off()
