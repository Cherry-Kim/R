cor <- function(){
	dat2 <- read.delim("RAW.txt",header=T,stringsAsFactors=F)
	
	dat2 <- dat2[,2:9]
	res.cor <- cor(dat)
	corrplot.mixed(res.cor, tl.cex = 0.5, number.cex=1.2, upper = "ellipse", lower = "number", tl.col = rep(c("red","blue"),times=c(8,8)))

	s.res.cor <- cor(dat,method="spearman")
	corrplot.mixed(s.res.cor, tl.cex = 0.5,number.cex=1.2,upper = "ellipse", lower = "number",  tl.col = rep(c("red","blue"),times=c(8,8)))
}
cor()
