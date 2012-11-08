'''
 NAME:                simple_plot_5_python

 DESCRIPTION:         Plots data read from two files.
                      Plots vertical error bars
                      Creates two side by side figures with a common x axis.

 EXECUTION COMMAND:
                      > python  simple_plot_5_python

 INPUTS:              File: radial_velocities_cfa.dat
                      File: radial_velocities_griffin.dat

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

from numpy import *
from pylab import *
import matplotlib.pyplot as plt
from matplotlib import *
import matplotlib.gridspec as gridspec


# read input data from two given files
id, year, jd, phase, rv, err, rvcalc, oc, ocerr = loadtxt('radial_velocities_cfa.dat', usecols=(0,1,2,3,4,5,6,7,8), unpack=True, skiprows=2)
idg, yearg, jdg, phaseg, rvg, errg, rvcalcg, ocg, ocerrg = loadtxt('radial_velocities_griffin.dat', usecols=(0,1,2,3,4,5,6,7,8), unpack=True, skiprows=4)


# create the main figure
fig = plt.figure(figsize=(8,6), dpi=120)
fig.subplots_adjust(hspace=0.05, wspace=0.0001, bottom=0.1, top=0.96, left=0.2, right=1.5)
                    
                
# define two subplots with different sizes
gs = gridspec.GridSpec(2, 2, width_ratios=[1,1], height_ratios=[3,1] )


# upper plot
upperplot = plt.subplot(gs[0])
plot(phaseg, rvg-1.043, 'ko', markeredgecolor="k" , markerfacecolor="w")
errorbar(phase, rv, err, fmt='ko')
plot([-0.05,1.05], [-7.826,-7.826], 'k:')
ylabel("Radial Velocity (km s$^{-1}$)")
xlim([-0.05, 1.05])
ylim([-16., 4.])
plt.setp(upperplot.get_xticklabels(), visible=False)

# lower plot
lowerplot = plt.subplot(gs[2])
plot(phaseg, ocg, 'ko', markeredgecolor="k" , markerfacecolor="w")
errorbar(phase, oc, err, fmt='ko')
plot([-0.05,1.05], [0.,0.], 'k:')
xlabel("Orbital Phase")
ylabel("O-C (km s$^{-1}$)")
xlim([-0.05, 1.05])
ylim([-2.9, 2.9])

 
# close and save file 
savefig(pdfname) 
clf()

                                          
                                          
 

# ------------------------ python code ends here

 