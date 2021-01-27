#!/usr/bin/env Rscript

import string,sys,os
from rpy2 import robjects as ro
r = ro.r

def MAKE_INPUT(path) :
	GENE=['ENST00000307564','ENST00000356842']

	TPM={}
	fpout1=open('PCA_input3.txt','w')
	file_list=os.listdir(path)
	N_list= [file for file in file_list if file.endswith("N.genes.results")]
	T_list= [file for file in file_list if file.endswith("T.genes.results")]
	LIST= N_list+T_list
	
	fpout1.write("GENE"+'\t'+'\t'.join(map(lambda z:z, LIST))+'\n')
	os.chdir(path)
	for fname in LIST:
		fp1=open(fname,'r')
		hd=fp1.readline()
		for line in fp1:
			line_temp=line.split('\t')
			g=line_temp[0].split('.')[0]	#ENSG00000001561.6
			for i in GENE:
				if i in line_temp[1]:
					if not g in TPM:
						TPM[g]=[]
					TPM[g].append(line_temp[-2])
	for key,value in TPM.items():
		f = ['ENSG00000119866_BCL11A','ENSG00000106948_AKNA']
		for x in f:	#x=ENSG00000119866_BCL11A
			x = map(lambda z:z.strip(), x.split('_'))
			ens, ast = x[0],x[1]
			if ens in key:	#if 'ENSG00000159388' in key:
				key = ast	#key = 'BTG2'
				fpout1.write(str(key)+'\t'+'\t'.join(value)+'\n')
	fp1.close()
	fpout1.close()
	
def PCA():
	r.source('PCA.r')

def Main():
	path = '/home/hykim/Project/Cancer/Colon/RNA-seq/Quantified_Gene_Expression/'
	MAKE_INPUT(path)
	PCA()
Main()
