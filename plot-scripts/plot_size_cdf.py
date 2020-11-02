#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Nov 12 18:43:29 2019

@author: ndilo
"""

import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import re
from matplotlib.ticker import FormatStrFormatter



f_tcp = sys.argv[1]
f_udp = sys.argv[2]
#f_tcp = 'dirA_20190117-130000_tcp_inter-arrival_size'
#f_udp ='dirA_20190117-130000_udp_inter-arrival_size'

df_tcp = pd.read_csv(f_tcp, delimiter=" ", header=None)
data_tcp = df_tcp.values

df_udp = pd.read_csv(f_udp, delimiter=" ", header=None)
data_udp = df_udp.values

#tcp data
x_tcp = np.sort(data_tcp[:,2])
y_tcp = np.arange(1, len(x_tcp)+1)/len(x_tcp)

#udp data
x_udp = np.sort(data_udp[:,2])
y_udp = np.arange(1, len(x_udp)+1)/len(x_udp) 

#for q in [10, 50, 90]:
#  print("{}-th percentile: {}".format (q, np.percentile(dataset[:,0], q)))

fig, ax = plt.subplots()
ax.set_xlabel('Flow sizes (Bytes)', weight='bold')
ax.set_ylabel('ECDF', weight='bold')


plt.grid(b=True, which='major', color='#666666', linestyle=':' )
#ax.yaxis.grid(False)
plt.semilogx(x_tcp,y_tcp, label='TCP', color='green')
plt.semilogx(x_udp,y_udp, label='UDP', color='red')

ax.set_xticks([1, 10, 100, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9])
ax.set_xticklabels(["1", "10", "100", "1K", "10K", "100K", "1M", "10M", "100M", "1G"])
plt.grid(b=True, which='minor', color='#999999', linestyle=':', alpha=0.3)
#ax.xaxis.grid(True, which='minor')
plt.tick_params(axis='x', which='minor')
ax.xaxis.set_minor_formatter(FormatStrFormatter("%.1f"))

plt.legend()
figname = re.split(r'tcp', f_tcp)[0]
plt.savefig(figname+'tcp_udp_size.pdf')
#np.savetxt(f+'_cdf_data',np.c_[x, y], delimiter=' ', fmt='%1.2f %1.6f')
