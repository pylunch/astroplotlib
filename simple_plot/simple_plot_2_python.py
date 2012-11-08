'''
 NAME:                simple_plot_2_python

 DESCRIPTION:         Plots data from a file. First column in file (X) Second column in file (Y).

 EXECUTION COMMAND:
                       > python simple_plot_2_python

 INPUTS:              File: data.xy
                      

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
from numpy import *
from pylab import *
import matplotlib.pyplot as plt



# name the output file 
pdfname = 'python_plot.pdf'

# read input file: first column (X values) 
#                  second column (Y values)
x, y = loadtxt('data.xy', usecols=(0, 1), unpack=True)

x = x - 54000.


# create plot
fig = plt.figure(figsize = (9,4), dpi=120)
plot = plt.plot(x, y, 'b.')
ylabel('Scaled counts/cadence')
xlabel('Time (BJD-2,450,000)')
ylim([0.5, 1.05])
xlim([962, 1000])

savefig(pdfname) 
clf()


# ------------------------ python code ends here
