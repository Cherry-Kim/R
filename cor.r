cor <- function(){
	dat2 <- read.delim("RAW.txt",header=T,stringsAsFactors=F)
	
	dat2 <- dat2[,2:9]
	res.cor <- cor(dat)
	corrplot.mixed(res.cor, tl.cex = 0.5, number.cex=1.2, upper = "ellipse", lower = "number", tl.col = rep(c("red","blue"),times=c(8,8)))

	s.res.cor <- cor(dat,method="spearman")
	corrplot.mixed(s.res.cor, tl.cex = 0.5,number.cex=1.2,upper = "ellipse", lower = "number",  tl.col = rep(c("red","blue"),times=c(8,8)))
}
cor()

cor <- function(){
        data <- read.delim("../input.db.t.txt",header=T,stringsAsFactors=F)
        #  Accession Classification Subtype Size_Tumor gene1
        #1 sample1  CR  HER2            1.6         3000.5

        library(corrplot)       
        library(dplyr)
        Basal <- subset(data, Subtype=="Basal") 
        p.value <- Basal[,4:100]%>%cor.mtest(method="spearman")
        a <- as.data.frame(p.value$p)
        #                 Size_Tumor 
        #Size_Tumor        0.0000000      
        #gene1      0.4042324      
        sig <- which(a$Size_Tumor.cm. < 0.05)   #[1]  1 19 78 79        
        p.val <- data.matrix(a)[sig,1]
        
        M <- cor(Basal[,4:100], method="spearman")
        cor <- M[sig,1]         
        Basal_spear <- rbind(p.val, cor)
        write.table(t(Basal_spear), "Basal_result.txt",col.names=NA, sep='\t',quote=F)
}
