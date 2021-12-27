#!/usr/bin/env Rscript
library(tximport)
library(DESeq2)

DESeq2 <- function(
           dir
           ){
        samples <- read.table(file.path(dir, "samples.txt"), header = TRUE)

        files_C <- paste0(  samples[which(samples$TREATMENT == "untreated"),1], ".genes.results")
        sample.C.list <- list()
        for( i in 1:length(files_C)){
                sample.C.list[i] <- unlist(strsplit(files_C[i], split=".genes.results"))[1]
        }

        files_T <- paste0(  samples[which(samples$TREATMENT == "treated"),1], ".genes.results")
        sample.T.list <- list()
        for( i in 1:length(files_T)){
                sample.T.list[i] <- unlist(strsplit(files_T[i], split=".genes.results"))[1]
        }

        files <- c(files_C, files_T)

        sample.list <- c(sample.C.list, sample.T.list)
        names(files) <- sample.list

        txi.rsem <- tximport(files, type = "rsem", txIn = FALSE, txOut = FALSE)
        write.table(txi.rsem$counts, "DESeq2_input.txt", col.names=NA, row.names=T, quote=F,sep='\t')

        #------------------------------------------------------------------------------
        sampleNames <- factor(as.character(sample.list))
        sampleGroup <- factor(samples$TREATMENT)
        sampleTable <- data.frame(sampleNames = sampleNames, sampleGroup = sampleGroup)

        dds <- DESeqDataSetFromMatrix(countData = round(txi.rsem$counts), colData = sampleTable, design = ~ sampleGroup)
        dds <- DESeq(dds)
        dds_results <- results(dds)     #res <- results(dds, pAdjustMethod="BH")
        write.csv(dds_results, file="DESeq2_results.csv")

}
DESeq2( dir <- "/BIO/")
############################
# Remove 1 column
# cat file.txt | awk '{$1=""; print $0}' > file.out

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
