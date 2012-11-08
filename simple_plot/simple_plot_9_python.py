'''
 NAME:                simple_plot_9_python
 
 DESCRIPTION:         Displays a Hertzsprung-Russell diagram.

 EXECUTION COMMAND:
                      > python simple_plot_9_python

 INPUTS:              Six theoretical models M???Z14V0.dat.txt
                      from http://obswww.unige.ch/Recherche/evol/

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

# name the output file 
pdfname = 'python_plot.pdf'


# import packages
from numpy import *
from pylab import *
import matplotlib.pyplot as plt
from matplotlib import *

# read input files: luminosity and effective temperature
lum001, teff001 = loadtxt('M001Z14V0.dat.txt', usecols=(3, 4), unpack=True, skiprows=2)
lum002, teff002 = loadtxt('M002Z14V0.dat.txt', usecols=(3, 4), unpack=True, skiprows=2)
lum005, teff005 = loadtxt('M005Z14V0.dat.txt', usecols=(3, 4), unpack=True, skiprows=2)
lum020, teff020 = loadtxt('M020Z14V0.dat.txt', usecols=(3, 4), unpack=True, skiprows=2)
lum040, teff040 = loadtxt('M040Z14V0.dat.txt', usecols=(3, 4), unpack=True, skiprows=2)
lum060, teff060 = loadtxt('M060Z14V0.dat.txt', usecols=(3, 4), unpack=True, skiprows=2)

# create plot
fig = plt.figure(figsize = (7,9), dpi = 120)
plot = plt.plot(teff001, lum001, 'b-')
plot = plt.plot(teff002, lum002, 'b-')
plot = plt.plot(teff005, lum005, 'b-')
plot = plt.plot(teff020, lum020, 'b-')
plot = plt.plot(teff040, lum040, 'b-')
plot = plt.plot(teff060, lum060, 'b-')

xlabel(r'$\log(T_{eff} [K])$')
ylabel(r'$\log(L/L_{\odot})$')
ylim([-0.5, 6.3])
xlim([5.0, 3.4])

# make some annotations
txt = plt.text(4.35, 2.5, r'$5 M_{\odot}$', color ='blue')
txt = plt.text(4.65, 4.4, r'$20 M_{\odot}$', color ='blue')

# close and save file 
savefig(pdfname) 
clf()

 


# ------------------------ python code ends here
