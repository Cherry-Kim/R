library(OmicCircos)
fus.d <- read.csv("_fus.txt", header=T,stringsAsFactors=F,sep="\t")
#   chr1     pos1 gene1  chr2     pos2 gene2
#1 chr16  1644997  GENE  chr5 54865793 GENE2

colors <-  rainbow(10 , alpha=0.5 )
plot( c(1:800), c(1:800), type="n", axes=FALSE, xlab="ADPKD2", ylab="")
circos(R=400, cir="hg19", type="chr", W=10, scale=FALSE, print.chr.lab=T)

#labels
#egfr.pos<-data.frame( chr=c(rep("chr16",1)), po=c(2138711), Gene=c("PKD1"), CNV=c("DEL") )
#gene.pos <- egfr.pos[,1:3]
circos(R=380 , cir="hg19" , W=20, mapping=gene.pos , type="label" , side="in" , col=c("black") , cex=0.5 )

#linking data
circos(R=300, cir="hg19", type="link", W=10, mapping=fus.d, col=colors[7], lwd=1)

arc.d <- data.frame( chr1=c(rep("chr1",2)), start=c("36640688","43008214"), end=c("36640815","43000670"), value=c("0","0") )

circos(R=355, cir="hg19", type="b3", W=40, mapping=arc.d, B=T,  col=colors[7])
circos(R=320, cir="hg19", type="s2", W=35, mapping=arc.d, B=T,  col=colors, lwd=10, cutoff=0)


