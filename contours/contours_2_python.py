#! /usr/bin/env python

# Header

'''
 NAME:                contours_2_python

 DESCRIPTION:         Displays a filled contour plot and a color bar.

 EXECUTION COMMAND:
                      >>> python contours_2_python.py
 
 INPUTS:              FITS file: input_data.fits
                    
 OUTPUTS:             PDF file: python_plot.pdf


 AUTHOR:              Tommy LE BLANC
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      Written by Tommy LE BLANC, JUL 2013. 
'''

# Import necessary modules
import numpy as np
import pyfits as pf
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from mpl_toolkits.axes_grid1 import ImageGrid

# Name the output file
psname = 'python_plot.ps'

# Read input data from FITS file
z = pf.getdata('./data/input_data.fits', 0)

# Define x and y labels
x = np.arange(50) + 100.
y = np.arange(50) + 10.

# Set colomap
#cmap = cm.get_cmap('jet')
cmap = cm.jet

# Setup contour levels
levels = np.arange(13)

# Setup figure and colorbar
fig = plt.figure(figsize=(6,6.5))

# Define custom grid for image
grid = ImageGrid(fig, 111, # similar to subplot(111)
                 nrows_ncols = (1, 1),
                 label_mode='L',
                 cbar_pad=0.05,
                 cbar_mode='single',
                 cbar_location='top')

# Set axis labels
grid[0].set_xlabel('x axis')
grid[0].set_ylabel('y axis')

# Display image contours and colorbar
im = grid[0].contourf(x, y, z, levels=levels, antialiased=False, cmap=cmap)
cbar = grid.cbar_axes[0].colorbar(im)

# Set tick labels to colorbar (even numbers)
cbar.ax.set_xticks(levels[::2])

# Save figure
fig.savefig(psname)
