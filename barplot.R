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

library(ggplot2)
data <- data.frame(type = c("Inversions","Deletions", "Duplications","Insertions"),
                   Value = c(25,23,19,10))

#Keep in mind that we have reversed the ordering since {ggplot2} plots factors from bottom to top when being mapped to y.
data$type <- factor(data$type, levels = c("Insertions","Duplications","Deletions","Inversions"))

ggplot(data, aes(y = type, x = Value, fill = type)) +
  geom_col() +
  geom_text(aes(label = Value),size=4, hjust = 0, nudge_x = .5) +
   ## make sure labels doesn't get cut, part 1
  coord_cartesian(clip = "off") +
   ## reduce spacing between labels and bars
  scale_x_continuous(expand = c(.01, .01)) +
  theme_void() +
  theme(axis.text.y = element_text(size = 14, hjust = 1, family = "Fira Sans"),
        ## make sure labels doesn't get cut, part 2
    plot.margin = margin(15, 30, 15, 15))




