#!/usr/bin/env Rscript

data <- read.table("PCA_input3.txt", header=T, stringsAsFactors=F, sep="\t")
#chrom   pos     Tumor_T       Tumor_T2
#chr1    10469   100     NA  
#dat <- na.omit(data)
#dat2 <- dat[-1,] #remove row1
#dat2[,"loc"] <- paste0(dat2[,1],':',dat2[,2], sep="")	#chr:pos
#dat2 <- dat2[,c(154,1:153)]	#154column -> 1column

#nsex <- dat2[dat2$chrom !='chrX' & dat2$chrom !='chrY' & dat2$chrom !='chrMT', ]
re.dat <- dat2[,-1:-3]
rownames(re.dat) <- dat2[,1]

#convert data frame to numeric
dat.log2 <- re.dat
for (i in 1:col(re.dat)){
	dat.log2[,i] <- log(re.dat[,i]+1,2)
}

#itr <- c()
#for(i in 1:nrow(dat.log2)){
#	if(sd(dat.log2[i,])==0)
#		{itr <- c(itr,i)}
#}
#in.dat2 <- dat.log2[-itr,]

library(preprocessCore)	
in.dat <- dat.log2
norm.q.dat <- normalize.quantiles(as.matrix(in.dat))
colnames(norm.q.dat) <- colnames(in.dat)
rownames(norm.q.dat) <- data[,1]
write.table(norm.q.dat, 'Normalized.txt', col.names=NA, row.names=T, quote=F, sep='\t')
write.table(t(norm.q.dat),"Normalized.t.txt", col.names=NA,row.names=T,quote=F,sep="\t")

########################################
#data2 <- read.table("PCA_input_whole.txt", header=T, stringsAsFactors=F, sep="\t")
#re.dat2 <- data2[,-1]

#dat2.log2 <- re.dat2
#for (i in 1:col(re.dat2)){
#	dat2.log2[,i] <- log(re.dat2[,i]+1,2)
#}

#itr2 <- c()
#for(i in 1:nrow(dat2.log2)){
#	if(sd(dat2.log2[i,])==0)
#	 {itr2 <- c(itr2,i)}
#}
#in.dat2 <- dat2.log2[-itr2,]

#norm.q.dat2 <- normalize.quantiles(as.matrix(in.dat2))

#colnames(norm.q.dat2) <- colnames(in.dat2)
#rownames(norm.q.dat2) <- NULL 
#rownames(norm.q.dat2) <-data2[-c(itr2),1] 
#write.table(norm.q.dat2, 'Normalized_whole.txt', col.names=NA, row.names=T, quote=F, sep='\t')
########################################

### PCA ###
output <- prcomp(t(norm.q.dat), scale = TRUE)
#                         chr1:629702 chr1:629711 chr1:629791 chr1:629825 chr1:629835
#Tumor_T    72.72727    72.54902    25.86207    56.00000    50.60241
#Tumor_T2     83.92857    93.61702    53.94737    54.34783    52.94118
write.table(round(predict(output), 2),"PC_TNW.txt",col.names=NA, sep='\t',quote=F)

pc1 <- predict(output)[, 'PC1']
pc2 <- predict(output)[, 'PC2']
pc3 <- predict(output)[, 'PC3']

color <- c("red","blue","green")
png("PCA.png",height=2000,width=2000,res=300) 
#par(mfrow=c(1,2))

plot(pc1, pc2, xlab = paste("PC1 (", round(summary(output)$importance[2,'PC1']*100,2), ")", sep=""), ylab = paste("PC2 (", round(summary(output)$importance[2,'PC2']*100,2), ")", sep=""),type="n", main="CpG methylation PCA")
grid()
points(pc1[1:65],pc2[1:65],col=color[1],pch=19,cex=1)
points(pc1[66:118],pc2[66:118],col=color[2],pch=19,cex=1)
points(pc1[119:151],pc2[119:151],col=color[3],pch=19,cex=1)

#par(mar=c(0,0,0,0))
#plot.new()
#legend('center',legend=c("N","T"), col=color,ncol=1,pch=19,cex=1.5)
legend(10, 9, legend=c("Tumor","Normal","WBC"), col=color,ncol=1,pch=10,cex=0.8)
dev.off()

plot(pc1, pc3, xlab = paste("PC1 (", round(summary(output)$importance[2,'PC1']*100,2), ")", sep=""), ylab = paste("PC3 (", round(summary(output)$importance[2,'PC3']*100,2), ")", sep=""),type="n", main="CpG methylation PCA")
grid()
points(pc1[1:65],pc3[1:65],col=color[1],pch=19,cex=1)
points(pc1[66:118],pc3[66:118],col=color[2],pch=19,cex=1)
points(pc1[119:151],pc3[119:151],col=color[3],pch=19,cex=1)

plot(pc2, pc3, xlab = paste("PC2 (", round(summary(output)$importance[2,'PC2']*100,2), ")", sep=""), ylab = paste("PC3 (", round(summary(output)$importance[2,'PC3']*100,2), ")", sep=""),type="n", main="CpG methylation PCA")
grid()
points(pc2[1:65],pc3[1:65],col=color[1],pch=19,cex=1)
points(pc2[66:118],pc3[66:118],col=color[2],pch=19,cex=1)
points(pc2[119:151],pc3[119:151],col=color[3],pch=19,cex=1)
