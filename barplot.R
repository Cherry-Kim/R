Bar <- function(){
        library(ggplot2)
        library(tidyverse)
        data <- read.table('Top10.txt', header=T)
        #  Symbol       cor
        #1  gene1 0.5438481
        g1 <- data[,1:2]
        df <- gl%>%arrange(cor)
        df$Symbol <- factor(rev(g1$Symbol), levels = rev(gl$Symbol))
        levels(df$Symbol)

        #Data Visualization with ggplot2
        ggplot(df, aes(x =Symbol, y =cor), width = 0.6) +geom_col(fill = "gray70") 
            +ggtitle("gl")+coord_flip()
            +theme(text = element_text(size = 20))
            + theme(axis.text = element_text(size = 20,face = "bold")) 
            + theme(plot.title = element_text(size = 22,face = "bold")) 
            +theme(panel.background = element_rect(fill = "white"), axis.line.y.left = element_line(color = "black"))
            + ylim(0,1)+xlab("")+ylab("value")
            +geom_text(aes(label = round(cor,2)),face = "bold",size = 7)
        
        B <- data[1:5,5:8] #negative value
        df <- B%>%arrange(desc(B_cor))
        df$Symbol <- factor(rev(B$B_Symbol), levels = rev(B$B_Symbol))
        ggplot(df, aes(x =Symbol, y =B_cor), width = 0.6) +geom_col(fill = "gray70") +ggtitle("LumA")
             +coord_flip()+theme(text = element_text(size = 30))+ theme(axis.text = element_text(size = 30,face = "bold")) 
             + theme(plot.title = element_text(size = 36,face = "bold",colour="purple")) 
             +theme(panel.background = element_rect(fill = "white"), axis.line.y.left = element_line(color = "black"))
             + ylim(-1,0)
             +xlab("")+ylab("Correlation Coefficient")+geom_text(aes(label = round(LumA_cor,2)),face = "bold",size = 12)
        
}
