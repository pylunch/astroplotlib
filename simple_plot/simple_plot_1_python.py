'''
 NAME:                simple_plot_1_python

 DESCRIPTION:         Plots a function y = f(x) with a given formula.

 EXECUTION COMMAND:
                      > python simple_plot_1_python

 INPUTS:              x : dataset X
                      y : dataset Y 

 OUTPUTS:             PDF file: python_plot.pdf

 NOTES:               change the input data. 
                      change the output PDF name.


 AUTHOR:              Leonardo UBEDA
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      Written by Leonardo UBEDA, Jan 2012. 

'''


# ------------------------ python code begins here

#!/usr/bin/env python

# import packages
import numpy as np 
import pylab as pl

# name the output file 
pdfname = 'python_plot.pdf'

# define input data
# dataset x
x = np.arange(401) * 0.5
# dataset y
y = np.sin(x) * np.exp(-x / 30.)                     

# create plot
pl.plot(x, y, 'r-', linewidth = 2)
pl.ylabel('y title')
pl.xlabel('x title')
pl.ylim([-1.0, 1.5])
pl.xlim([0.0, 120.])
pl.savefig(pdfname) 
pl.clf()



# ------------------------ python code ends here
