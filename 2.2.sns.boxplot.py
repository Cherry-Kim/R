import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
from statannot import add_stat_annotation

sns.set(style="ticks")
df = pd.read_table('plot_input2.txt')
x="GENE"
hue="Tissue"
y = "TPM"
box_pairs = [(('IRF8','T'),('IRF8','N')),(('JUNB','T'),('JUNB','N')),(('GFI1B','T'),('GFI1B','N')),(('POU2F2','T'),('POU2F2','N')),(('MYB','T'),('MYB','N')),(('AKNA','T'),('AKNA','N')),(('IKZF1','T'),('IKZF1','N')),(('KLF2','T'),('KLF2','N')),(('IRF5','T'),('IRF5','N')),(('BTG2','T'),('BTG2','N')),(('TAL1','T'),('TAL1','N')),(('BCL11A','T'),('BCL11A','N')),(('EAF2','T'),('EAF2','N')),(('SPIB','T'),('SPIB','N')),(('KLF1','T'),('KLF1','N')),(('SPI1','T'),('SPI1','N')),(('IKZF3','T'),('IKZF3','N')),(('NFE2','T'),('NFE2','N')),(('TCF7','T'),('TCF7','N')),(('GATA1','T'),('GATA1','N'))]
ax = sns.boxplot(data=df, x=x, y=y, hue=hue)
ax,test_result=add_stat_annotation(ax, data=df, x=x, y=y, hue=hue, box_pairs=box_pairs,test='t-test_paired', comparisons_correction=None, loc='inside', verbose=2)
#t-test_ind, t-test_welch, t-test_paired, Mann-Whitney, Mann-Whitney-gt, Mann-Whitney-ls, Levene, Wilcoxon, Kruskal

plt.legend(loc='upper left', bbox_to_anchor=(1.03, 1))
plt.savefig('test.png', dpi=600, bbox_inches='tight')
sns.despine()
plt.show()

'''
for res in test_results:
    print(res)
print("\nStatResult attributes:", test_results[0].__dict__.keys())
'''
