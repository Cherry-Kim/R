        data <- read.delim("input.db.t.txt",header=T,stringsAsFactors=F)
        #  Accession Subtype Size gene1
        #1 sample1  A            0         3
        
        library(dplyr)
        library(ggplot2)
        A <- subset(data, Subtype=="A") 
        ggplot(A, aes(x=gene1, y=Size)) + geom_point()+ geom_smooth(method=lm, se=FALSE)
            + annotate("text", x=400,y=6, label= "A", col="blue", size=14)
            + ggtitle("A") + theme(plot.title = element_text(size = 36,face = "bold"))
            + xlab("gene1")+ theme(axis.text = element_text(size = 19,face = "bold"))
            + theme(axis.title.y = element_text(size =33,face = "bold"))
            + theme(axis.title.x = element_text(size = 38,face = "bold"))
        cor.test(A$Size, A$gene1, method="spearman")


#-----------------------------------------------------
        data1 <- read.delim('temp1.txt', header=T)
        data1$group <- "temp1"     
        data2 <- read.delim('temp2.txt', header=T)
        data2$group <- "temp2" 

        merged_data <- rbind(data1, data2)
        ggplot(merged_data, aes(x = x, y = y, color = group, shape = group)) +
          geom_point(size = 2) +
          labs(x = "X", y = "Y", color = "group") +
          ggtitle("test") + theme(plot.title = element_text(size = 36,face = "bold",hjust = 0.5, color="purple")) +          theme(axis.text = element_text(size = 20), legend.text = element_text(size = 20, face = "bold")) +
          theme(axis.title.x = element_text(size = 38,face = "bold")) +   
          theme(axis.title.y = element_text(size =33,face = "bold"))   
