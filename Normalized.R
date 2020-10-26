> library(preprocessCore)
> 
> data2 <- read.table("PCA_input2.txt", header=T, stringsAsFactors=F, sep="\t")
> re.dat2 <- data2[,-1]
> 
> dat2.log2 <- re.dat2
> for (i in 1:col(re.dat2)){
+         dat2.log2[,i] <- log(re.dat2[,i]+1,2)
+ }
Warning message:
In 1:col(re.dat2) :
  numerical expression has 26387760 elements: only the first used
> 
> itr2 <- c()
> for(i in 1:nrow(dat2.log2)){
+         if(sd(dat2.log2[i,])==0)
+          {itr2 <- c(itr2,i)}
+ }
> in.dat2 <- dat2.log2[-itr2,]
> norm.q.dat2 <- normalize.quantiles(as.matrix(in.dat2))
> 
> colnames(norm.q.dat2) <- colnames(in.dat2)
> rownames(norm.q.dat2) <- NULL
> rownames(norm.q.dat2) <-data2[-c(itr2),1]
> write.table(norm.q.dat2, 'Normalized_entire.txt', col.names=NA, row.names=T, quote=F, sep='\t')

data <- read.csv("Normalized_entire.txt",header=T,stringsAsFactors=F,sep="\t")
a=t(data)
write.table(a,"Normalized_entire.t.txt", col.names=F,row.names=T,quote=F,sep="\t")

