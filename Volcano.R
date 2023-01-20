volcano <- function(){
        data <- read.table('data.txt',header=T,sep='\t')
        head(data,2)
        topT <- data[,c(3,7,10,11)]
#  hgnc_symbol     log2FC     P
#1       IGHA2  3.2568975 8.05e-17
#2     DNAJC13 -0.5476099 3.52e-13
        colnames(topT) <- c("symbol","log2FC","pvalue","padj")

        cut_lfc <- 1.5
        cut_pvalue <- 0.01
        topT$Sig <- ifelse( (topT$pvalue <cut_pvalue & topT$log2FC<(-cut_lfc)) | (topT$pvalue <cut_pvalue & topT$log2FC>cut_lfc), TRUE, FALSE)
        table(topT$Sig)
        which(topT$Sig==TRUE)

        par(mar=c(5,5,5,5), cex=1.0, cex.main=1.4, cex.axis=1.4, cex.lab=1.4)
        with(topT, plot(log2FC, -log10(pvalue), pch=20, main="", col='grey', cex=1.0, xlab=bquote(~log2(Fold~Change)), ylab=bquote(~-log10(Pcom))) )
        with(subset(topT, pvalue<0.05 & log2FC>cut_lfc), points(log2FC, -log10(pvalue), pch=20, col='red', cex=1.5))
        with(subset(topT, pvalue<0.05 & log2FC <(-cut_lfc)), points(log2FC, -log10(pvalue), pch=20, col='blue', cex=1.5))
        #with(subset(topT, topT$Sig == TRUE), points(log2FC, -log10(pvalue), pch=20, col='green', cex=1.5))

        abline(v=0, col='black', lty=3, lwd=1.0)
        abline(v=-cut_lfc, col='black', lty=4, lwd=2.0)
        abline(v=cut_lfc, col='black', lty=4, lwd=2.0)
        abline(h=-log10(max(topT$pvalue[topT$pvalue<cut_pvalue], na.rm=TRUE)), col='black', lty=5, lwd=2.0)
        abline(h=-log10(max(topT$pvalue[topT$pvalue<0.05], na.rm=TRUE)), col='black', lty=2, lwd=2.0)
       ## label        
        #topT$gene <- rownames(topT)
        topT$gene <- topT$symbol
        Sig <- topT$Sig
        text(topT$log2FC[Sig], -log10(topT$pvalue)[Sig], vfont = NULL, lab=(topT$gene)[Sig], cex=0.6, col='black', pos=4)
        topT$gene[Sig]

## label2
topT$Sig2 <- ifelse( (topT$pvalue <0.05 & topT$log2FC<(-cut_lfc)) | (topT$pvalue <0.05 & topT$log2FC>cut_lfc), TRUE, FALSE)
table(topT$Sig2)
topT$gene <- rownames(topT)
Sig2 <- topT$Sig2
text(topT$log2FC[Sig2], -log10(topT$pvalue)[Sig2], vfont = NULL, lab=(topT$gene)[Sig2], cex=0.6, col='black', pos=4)
topT$gene[Sig2]
}
