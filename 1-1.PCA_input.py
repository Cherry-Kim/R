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
GENE=['ENST00000307564','ENST00000356842']

TPM={}
ID=[]
fpout=open('PCA_input.txt','w')
file_list=os.listdir('/home/RNA-seq/')
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
