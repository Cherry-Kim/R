#! /usr/bin/env Rscript

import string,sys,glob,os
'''
### STEP1. File rename ###
fp=glob.glob('*genes.results')
for fname in fp:
	sample=fname.split('.genes.results')[0][:-3]
	os.system('cp '+fname+' '+sample+'.genes.results')

'''
### STEP2. Construct PCA input ###
GENE=['ENST00000307564','ENST00000356842','ENST00000290551','ENST00000273668','ENST00000376670','ENST00000339463','ENST00000331340','ENST00000346872','ENST00000357234','ENST00000268638','ENST00000302754','ENST00000264834','ENST00000248071','ENST00000341911','ENST00000435572','ENST00000526816','ENST00000294339','ENST00000342854','ENST00000378538','ENST00000595883']

TPM={}
ID=[]
fpout=open('PCA_input.txt','w')
file_list=os.listdir('/home/hykim/Project/Cancer/Colon/RNA-seq/Quantified_Gene_Expression/')
T_list= [file for file in file_list if file.endswith("T.genes.results")]
N_list= [file for file in file_list if file.endswith("N.genes.results")]
LIST= T_list+N_list

fpout.write("GENE"+'\t'+'\t'.join(map(lambda z:z, LIST))+'\n')
for fname in LIST:
	fp1=open(fname,'r')
	hd=fp1.readline()
	for line in fp1:
		line_temp=line.split('\t')
		g=line_temp[0].split('.')[0]
		for i in GENE:
			if i in line_temp[1]:
				if not g in TPM:
					TPM[g]=[]
				TPM[g].append(line_temp[-2])
for key,value in TPM.items():
	fpout.write(str(key)+'\t'+'\t'.join(value)+'\n')

fp1.close()
fpout.close()
'''

### STEP3. PCA ###
from rpy2 import robjects as ro
r = ro.r
r.source("PCA.R")
'''
