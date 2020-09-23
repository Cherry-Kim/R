#!/usr/bin/env Rscript
library(ggsignif)
library(tidyverse)
library(rstatix)
library(ggpubr)

res.list <- dir(pattern="*.t.txt")
for (i in 1:length(res.list)){
	dat <- read.table(res.list[i], header=T)
	print(res.list[i])
	name <- unlist(strsplit(res.list[i],split=".t.txt"))	

	png(paste0(name,".png"), height=2000, width=2000,res=250)

	h <- compare_means(TPM ~ Tissue,  data = dat, method = "t.test", paired=T)
	write.table(h,paste0(name,".out"), col.names=T, row.names=T, sep='\t', quote=F)

	p <- ggboxplot(dat, x = "Tissue", y = "TPM",
       	  color = "Tissue",  palette = "jco",add = "jitter")
	p1 <- p + stat_compare_means(method = "t.test", paired=T, label.x = 1.5, label.y = 45, label="p.signif")		
	print(p1)
	dev.off()
}

###########################################
dat <- read.table("plot_input2.txt", header=T)
compare_means(TPM ~ Tissue,  data = dat, group.by="GENE", method = "t.test", paired=T)
# A tibble: 20 x 9
   GENE   .y.   group1 group2        p    p.adj p.format p.signif method
   <fct>  <chr> <chr>  <chr>     <dbl>    <dbl> <chr>    <chr>    <chr> 
 1 IRF8   TPM   N      T      3.32e- 7 3.60e- 6 3.3e-07  ****     T-test
 2 SPI1   TPM   N      T      7.60e-22 1.20e-20 < 2e-16  ****     T-test
 3 BCL11A TPM   N      T      4.51e-29 8.10e-28 < 2e-16  ****     T-test
 4 TCF7   TPM   N      T      6.44e-37 1.20e-35 < 2e-16  ****     T-test
 5 GATA1  TPM   N      T      5.67e- 2 2.30e- 1 0.05668  ns       T-test
 6 JUNB   TPM   N      T      5.53e- 3 4.40e- 2 0.00553  **       T-test
 7 POU2F2 TPM   N      T      3.45e- 4 3.10e- 3 0.00035  ***      T-test
 8 KLF1   TPM   N      T      1.38e-14 1.90e-13 1.4e-14  ****     T-test
 9 TAL1   TPM   N      T      4.29e- 1 8.60e- 1 0.42880  ns       T-test
10 NFE2   TPM   N      T      3.01e- 5 3.00e- 4 3.0e-05  ****     T-test
11 IRF5   TPM   N      T      1.83e-66 3.70e-65 < 2e-16  ****     T-test
12 BTG2   TPM   N      T      6.29e- 3 4.40e- 2 0.00629  **       T-test
13 IKZF3  TPM   N      T      9.39e-12 1.10e-10 9.4e-12  ****     T-test
14 IKZF1  TPM   N      T      2.92e-20 4.40e-19 < 2e-16  ****     T-test
15 AKNA   TPM   N      T      5.20e- 1 8.60e- 1 0.52023  ns       T-test
16 KLF2   TPM   N      T      1.28e- 2 6.40e- 2 0.01279  *        T-test
17 GFI1B  TPM   N      T      3.70e-28 6.30e-27 < 2e-16  ****     T-test
18 SPIB   TPM   N      T      3.19e-14 4.20e-13 3.2e-14  ****     T-test
19 MYB    TPM   N      T      9.77e- 3 5.90e- 2 0.00977  **       T-test
20 EAF2   TPM   N      T      2.21e- 1 6.60e- 1 0.22103  ns       T-test

