#!/usr/bin/env Rscript

import sys,os
from rpy2 import robjects as ro
r = ro.r

def MAKE_INPUT(file):
	co=0
	fp1=open(file,'r')
	hd1=fp1.readline()
	g=hd1[:-1].split('\t')
	fpout1=[open(g[i+1]+'.t2.txt','a') for i in range(0,20)]
	for i in range(20):
		fpout1[i].write("Tissue"+'\t'+"TPM"+'\t'+"GENE"+'\n')
	for line in fp1:
       		co+=1
       		line_temp=line[:-1].split('\t')
#		for i in range(20):
#		        if co <= 226:
#      	        	        fpout1[i].write(str('N')+'\t'+line_temp[i+1]+'\t'+g[i+1]+'\n')
# 	  	    	else:
#                	        fpout1[i].write(str('T')+'\t'+line_temp[i+1]+'\t'+g[i+1]+'\n')

def ViolinPlot():
	r.source('ViolinPlot.r')

def Main():
	#MAKE_INPUT(file='Normalized.t.txt')
	ViolinPlot()
Main()
