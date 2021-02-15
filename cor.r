cor <- function(){
	dat2 <- read.delim("RAW.txt",header=T,stringsAsFactors=F)
	str(dat2)
	#data.frame:	48440 obs. of  9 variables:
	# $ Feature.ID    : chr  "0610006L08Rik" "0610007P14Rik" "0610009B22Rik" "0610009E02Rik" ...
	 #$ Raw_siNC_1.1  : num  0 36.849 23.202 0.108 0 ...
	 #$ Raw_siNC_1    : num  0 36.505 17.436 0.247 0 ...

	dat2 <- dat2[,2:9]
	res.cor <- cor(dat)
	corrplot.mixed(res.cor, tl.cex = 0.5, number.cex=1.2, upper = "ellipse", lower = "number", tl.col = rep(c("red","blue"),times=c(8,8)))

	s.res.cor <- cor(dat,method="spearman")
	corrplot.mixed(s.res.cor, tl.cex = 0.5,number.cex=1.2,upper = "ellipse", lower = "number",  tl.col = rep(c("red","blue"),times=c(8,8)))
}
cor()
