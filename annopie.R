annoPie <- function(){
        library(ggplot2)
        library(dplyr)
        a <- read.csv('input.csv', header=T, sep=',')
        data <- data.frame( group=a$Feature, value=a$s1)
        data <- data %>% mutate(group2 = paste0(group, " (", round(value,2),"%)"))
        col <- c("#99CCFF","#0066CC","#99FF99", "green", "#FF9999", "#FF3333", "#FFB226", "#FF9933", "#E5CCFF","#9933FF","#FFFF99")
        par(mai = c(0,0,0,0))
        layout(matrix(c(1,2), ncol=2), widths=c(0.6,0.4))
        pie(x=data$value, labels=NA, main="s1", col=col)
        plot.new()
        legend("center", legend=data$group2, cex = 0.9,  bty = "n", fill=col)
}

bar <- function(){
        a <- read.csv('input22.csv', header=T, sep='\t')
        a$category <- factor(a$category, 
            levels=rev(c("Promoter (<=1kb)","Promoter (1-2kb)","Promoter (2-3kb)","5' UTR","3' UTR","1st Exon","Other Exon","1st Intron","Other Intron","Downstream (<=300)","Distal Intergenic")))
        levels(a$category)
        #a$sample <- factor(a$sample)
        levels(a$sample)
        a$sample <- factor(a$sample, 
            levels=c("s3","s2","s1"))
        col <- c("#99CCFF","#0066CC","#99FF99", "green", "#FF9999", "#FF3333", "#FFB226", "#FF9933", "#E5CCFF","#9933FF","#FFFF99")
        ggplot()+ geom_bar(data=a, aes(x =sample, y =value, fill =category),
            position='stack',stat = "identity")
            + coord_flip()
            + scale_fill_manual(values=rev(col),guide=guide_legend(reverse=TRUE)) 
            + theme_bw()
            +ylab("Percentage(%)") + xlab("") 
            + ggtitle("State4")+theme(axis.text=element_text(size=16,face="bold"),axis.title.y=element_text(size=18,face="bold"))
            + theme(legend.text=element_text(size=12,face="bold"))
}
