'''
 NAME:                simple_plot_8_python

 DESCRIPTION:         Displays a bubble plot.

 EXECUTION COMMAND:
                      > python simple_plot_8_python.py

 INPUTS:              File bubble.dat

 OUTPUTS:             PDF file: python_plot.pdf

 NOTES:               change the input data. 
                      change the output PDF name.


 AUTHOR:              Leonardo UBEDA
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      Written by Leonardo UBEDA, Oct 2012. 

'''


# ------------------------ python code begins here
#!/usr/bin/env python

# import packages
import numpy as np 
import pylab as pl

import matplotlib
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid.axislines import Subplot

# name the output file 
pdfname = 'python_plot.pdf'

# read input file: first column (X values) 
#                  second column (Y values)
x, y, size = np.loadtxt('bubble.dat', unpack=True)
size = size * 250.

# create plot

fig = plt.figure(1, (8,5), facecolor='white')
ax = Subplot(fig, 111)
fig.add_subplot(ax)

# make axes invisible
ax.axis["right"].set_visible(False)
ax.axis["top"].set_visible(False)

ax.scatter(x, y, c='b', s=size, alpha=1.0, lw = 0)

pl.ylabel('peak time rank number')
pl.xlabel(r'log($\nu$) [ghz]')
pl.ylim([0.0, 8.0])
pl.xlim([0.0, 2.5])


pl.savefig(pdfname) 
pl.clf()
# ------------------------ python code ends here
