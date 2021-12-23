data <- read.table( "group1:group2.count.txt",  sep="\t", header=T, stringsAsFactor=F)

sampleNames <- factor(as.character(unlist(strsplit(colnames(data[3:ncol(data)]), split=".fastq.gz"))))
sampleGroup <- factor( substr(colnames(data[3:ncol(data)]),1,nchar(colnames(data[3:ncol(data)]))-12) ) #remove fastq.gz 
sampleTable <- data.frame(sampleNames = sampleNames, sampleGroup = sampleGroup)

A <- data$Gene
B <-data[3:ncol(data)]
C <- cbind(A,B)

counts <- as.matrix(C[,-1])
rownames(counts) <- C[,1]

dds <- DESeqDataSetFromMatrix(countData = counts, colData = sampleTable, design = ~ sampleGroup)
dds <- DESeq(dds)
dds_results <- results(dds)
dds_results <- dds_results[order(dds_results$padj),]
df <- dds_results[!is.na(dds_results$padj),]

G1 <-  substr(colnames(data[3:3]),1,nchar(colnames(data[3:3]))-12)
G2 <-  substr(colnames(data[6:6]),1,nchar(colnames(data[6:6]))-12)
write.csv(dds_results, file=paste0("DESeq2.results.",G1,":",G2,".csv"), quote=F)
write.csv(df, file=paste0("DESeq2.results.",G1,":",G2,".csv"), quote=F)
