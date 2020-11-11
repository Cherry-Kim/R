import sys,os

data <- read.csv("Normalized.txt",header=T,stringsAsFactors=F,sep="\t")
a=t(data)
write.table(a,"plot_input.txt", col.names=F,row.names=T,quote=F,sep="\t")

import sys,os,numpy

VAL=[]
fp=open("h.txt","r")
for line in fp:
        line_temp=line[:-1].split('\t')
        if not line_temp[0] in VAL:
                VAL.append(line_temp[:])
X = numpy.transpose(VAL)
print type(X)
numpy.savetxt("test.txt", X, fmt='%s')


co=0
fp=open('plot_input.txt','r')
hd=fp.readline()
g=hd[:-1].split('\t')

fpout=[open(g[i+1]+'.t.txt','a')for i in range(0,20)]

for line in fp:
        co+=1
        line_temp=line[:-1].split('\t')
        if co <= 226:
                for i in range(20):
                        fpout[i].write(str('T')+'\t'+line_temp[i+1]+'\t'+g[i+1]+'\n')
        elif co > 226:
                for i in range(20):
                        fpout[i].write(str('N')+'\t'+line_temp[i+1]+'\t'+g[i+1]+'\n')
'''
file_list=os.listdir('/home/hykim/Project/Cancer/Colon/RNA-seq/2.Beanplot')
file_list_py= [file for file in file_list if file.endswith(".t.txt")]
print file_list_py
os.system('cat '+' '.join(map(lambda z:z, file_list_py))+' > plot_input2.txt')

import seaborn as sns
import pandas as pd

df = pd.read_table('plot_input2.txt')
print(df.head())

# Grouped violinplot
sns.violinplot(x="GENE", y="TPM", hue="Tissue", data=df)
import matplotlib.pyplot as plt
plt.show()
'''
