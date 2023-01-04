        library(dplyr)
        data <- read.delim("file.out", header=T)
        head(data,2)
        data <- data %>%mutate(info = paste0(data$GENESYMBOL,"_",data$chr,"_",data$start,"_",data$stop))         
        #data[data$info == 'gene_chr_st_ed',]

        data <- data %>%mutate(mean = apply(data[,c(3:35)],1,mean, na.rm=TRUE))
        #data[976089,3:40]

        b <- aggregate(data$mean ~ data$info, data, mean)
        pos <- data %>%count(data$info)

        result = merge(b,pos, by='data$info')
        names(result)[3] <- c("No.sites")
        write.table(result, file="file.mean.count.txt", sep="\t", col.names=NA, quote=FALSE)
