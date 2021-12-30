CDP_VOLCANO <- function(
        ){
        library(ggplot2)
        library(tidyverse)
        
        a <- read.table('integrated_results.txt', sep='\t', header = T)
        Index	TF Symbol	Motif P-value	Motif Displacement score	Differetial expression P-value	log2FC(RNA-seq)	Z.Motif	Z.RNA	Avg.Z	Combined P-value(Motif+RNA)	Rank
        13	TF1	1.16E-07	-0.133	2.12E-300	6.46391011	5.170965929	37.02676866	29.83830428   1
        14	TF2	8.14E-06	0.1	3.41E-86	3.23987677	4.310711716	19.64167474	16.93689489   2

        topT <- as.data.frame(a)
        #topT$Sig <- ifelse( (topT$Rank <= 10) | (topT$Rank >= 322), TRUE, FALSE)
        topT$Sig <- ifelse( topT$Rank <= 5, TRUE, FALSE)
        topT$Sig2 <- ifelse( topT$Rank >= 210, TRUE, FALSE)

        par(mar=c(5,5,5,5), cex=1.0, cex.main=1.4,cex.axis=1.4,cex.lab=1.4)
        with(topT, plot(Rank,Avg.Z, xlab="Ranks", ylab="Combined Score (Avg.Z)"))
        #with(subset(topT, topT$Sig==TRUE), points(Rank,-log10(Combined.P.value..Motif.RNA.), pch=20,col='red',cex=1.5))
        with(subset(topT, topT$Sig==TRUE), points(Rank,Avg.Z, pch=20,col='red',cex=1.5))
        with(subset(topT, topT$Sig2==TRUE), points(Rank,Avg.Z, pch=20,col='blue',cex=1.5))
        Sig <- topT$Sig
        text(topT$Rank[Sig],topT$Avg.Z[Sig],lab=topT$TF.Symbol[Sig], cex=0.7,col='red', pos=4)
#       text(topT$Rank[Sig],topT$Avg.Z[Sig]),lab=topT$Motif.Symbol[Sig], cex=0.8,col='red', pos=4)      # 1=below, 2=left, 3=above, 4=right
        Sig2 <- topT$Sig2
        text(topT$Rank[Sig2],topT$Avg.Z[Sig2],lab=topT$TF.Symbol[Sig2], cex=0.7,col='blue', pos=2)      # 1=below, 2=left, 3=above, 4=right

# ====== VOLCANO PLOT ===============================================
        par(mar=c(5,5,5,5), cex=1.0, cex.main=1.4,cex.axis=1.4,cex.lab=1.4)
        with(topT, plot(log2FC..RNA.seq.,Avg.Z, pch=20,col='gray',cex=1.0,ylab="Combined Score (Avg.Z)",xlab="Log2 Fold Change (RNA-seq)"))
        with(subset(topT, topT$Sig==TRUE), points(log2FC..RNA.seq.,Avg.Z,pch=20,col='green',cex=1.5))
        with(subset(topT, topT$Sig2==TRUE), points(log2FC..RNA.seq.,Avg.Z,pch=20,col='green',cex=1.5))
        text(topT$log2FC..RNA.seq.[Sig],topT$Avg.Z[Sig],lab=topT$TF.Symbol[Sig],cex=0.7,col='red',pos=4)
        text(topT$log2FC..RNA.seq.[Sig2],topT$Avg.Z[Sig2],lab=topT$TF.Symbol[Sig2],cex=0.7,col='blue',pos=4)
        abline(v=0,col='black',lty=3,lwd=1.0)
        abline(v=1.5, col='black',lty=4,lwd=1.0)
        abline(v=-1.5, col='black',lty=4,lwd=1.0)
        abline(h=-log10(max(topT$Combined.P.value..Motif.RNA.[topT$Combined.P.value..Motif.RNA.<0.01],na.rm=TRUE)),col='black',lty=4,lwd=1.0)

}
CDP_VOLCANO()
