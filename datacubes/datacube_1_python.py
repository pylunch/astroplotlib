#! /usr/bin/env python

# Header

'''
 NAME:                datacube_1_python

 DESCRIPTION:         Displays a contour plot on a datacube slice.

 EXECUTION COMMAND:
                      >>> python datacube_1_python.py
 
 INPUTS:              FITS datacube: ngc4151_hband.fits
                    
 OUTPUTS:             PDF file: python_plot.pdf


 AUTHOR(S):           Derek HAMMER
 					  Tommy LE BLANC
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      * Written by Derek HAMMER, Tommy LE BLANC, NOV 2012.

                      * JUL 2013 - Optimized FITS datacube input, tweaked
                                 plot display.
'''

# Import necessary modules
import pyfits as pf
import matplotlib.pyplot as plt

# Name the output file
psname = 'python_plot.ps'

# Read datacube
cube, header = pf.getdata('./data/ngc4151_hband.fits', header=True)

# We plot slice 1067
cube_slice = 1067
image = cube[cube_slice, :, :]
tam = image.shape

# Display the background image
cmap = plt.cm.get_cmap('hot')
fig, ax = plt.subplots(figsize=(6, 6))
ax.imshow(image, cmap=cmap, vmin = 0, vmax = 100, interpolation='nearest')

# Define axes
ax.set_xlabel('x pixels')
ax.set_ylabel('y pixels')
ax.set_ylim([0, tam[0]-1])
ax.set_xlim([0, tam[1]-1])

# Create contours
levels = [5, 10, 20, 30, 40, 50, 100, 200, 600]
cplot = ax.contour(image, levels, colors='Lime')
cplot.clabel(inline=1, fontsize=8, fmt='%2d')

# Save figure
fig.savefig(psname)