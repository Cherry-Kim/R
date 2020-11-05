#!/usr/bin/env Rscript

data <- read.table("PCA_input.txt", header=T, stringsAsFactors=F, sep="\t")
re.dat <- data[,-1]

### log2 transformation ###
dat.log2 <- re.dat
for (i in 1:col(re.dat)){
	dat.log2[,i] <- log(re.dat[,i]+1,2)
}

### Filter-out genes
itr <- c()
for(i in 1:nrow(dat.log2)){
	if(sd(dat.log2[i,])==0)
	 {itr <- c(itr,i)}
}

### Quantile Normalization ###
#install.packages("BiocManager")
#BiocManager::install("preprocessCore")
library(preprocessCore)	

in.dat <- dat.log2
norm.q.dat <- normalize.quantiles(as.matrix(in.dat))

colnames(norm.q.dat) <- colnames(in.dat)
rownames(norm.q.dat) <- data[,1]
write.table(norm.q.dat, 'Normalized.txt', col.names=NA, row.names=T, quote=F, sep='\t')

########################################
data2 <- read.table("PCA_input2.txt", header=T, stringsAsFactors=F, sep="\t")
re.dat2 <- data2[,-1]

dat2.log2 <- re.dat2
for (i in 1:col(re.dat2)){
	dat2.log2[,i] <- log(re.dat2[,i]+1,2)
}

itr2 <- c()
for(i in 1:nrow(dat2.log2)){
	if(sd(dat2.log2[i,])==0)
	 {itr2 <- c(itr2,i)}
}
in.dat2 <- dat2.log2[-itr2,]

library(preprocessCore)	
norm.q.dat2 <- normalize.quantiles(as.matrix(in.dat2))

colnames(norm.q.dat2) <- colnames(in.dat2)
rownames(norm.q.dat2) <- NULL 
rownames(norm.q.dat2) <-data2[-c(itr2),1] 
#length(data2[-c(itr2),1]) #48979
#length(in.dat2[,1]) #48979

write.table(norm.q.dat2, 'Normalized2.txt', col.names=NA, row.names=T, quote=F, sep='\t')

##A <- data2[.1]
##B_tumor <- data2[,2:227]
##C <- cbind(A,B)

### PCA ###
output <- prcomp(t(norm.q.dat), scale = TRUE)
pc1 <- predict(output)[, 'PC1']
pc2 <- predict(output)[, 'PC2']

output2 <- prcomp(t(norm.q.dat2), scale = TRUE)
pc11 <- predict(output2)[, 'PC1']
pc22 <- predict(output2)[, 'PC2']

color <- c("purple", "pink")
png("out.png",height=2000,width=6000,res=250) 
par(mfrow=c(1,3))
plot(pc1, pc2, xlab = paste("PC1 (", round(summary(output)$importance[2,'PC1']*100,2), ")", sep=""), ylab = paste("PC2 (", round(summary(output)$importance[2,'PC2']*100,2), ")", sep=""),type="n", main="20 genes")
grid()
points(pc1[1:226],pc2[1:226],col=color[1],pch=19,cex=1)
points(pc1[227:452],pc2[227:452],col=color[2],pch=19,cex=1)

plot(pc11, pc22, xlab = paste("PC1 (", round(summary(output2)$importance[2,'PC1']*100,2), ")", sep=""), ylab = paste("PC2 (", round(summary(output2)$importance[2,'PC2']*100,2), ")", sep=""),type="n", main="Entire genes")
grid()
points(pc11[1:226],pc22[1:226],col=color[1],pch=19,cex=1)
points(pc11[227:452],pc22[227:452],col=color[2],pch=19,cex=1)

par(mar=c(0,0,0,0))
plot.new()
legend('center',legend=c("T", "N"), col=color,ncol=1,pch=19,cex=1.5)
dev.off()

#############################################################
##install.packages("ggfortify")
##library(ggfortify)

##pca_res <- prcomp(re.dat, scale. = TRUE)
##png("pca_res.png")
##autoplot(pca_res, data = data, colour = 'GENE')
##dev.off()
