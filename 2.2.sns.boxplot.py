### python3 ~.py

import seaborn as sns
import pandas as pd
import numpy as np
from statannot import add_stat_annotation

sns.set(style="ticks")
df = pd.read_table('plot_input2.txt')
x="GENE"
hue="Tissue"
y = "TPM"
box_pairs = [(('IRF8','T'),('IRF8','N')),(('JUNB','T'),('JUNB','N'))]
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
