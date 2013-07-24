#! /usr/bin/env python

# Header

'''
 NAME:                contours_4_python

 DESCRIPTION:         Displays a contour plot labeled with astronomical coordinates.

 EXECUTION COMMAND:
                      >>> python contours_4_python.py
 
 INPUTS:              FITS file: input_data.fits
                    
 OUTPUTS:             PDF file: python_plot.pdf


 AUTHOR:              Tommy LE BLANC
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      Written by Tommy LE BLANC, JUL 2013. 
'''

# Import necessary modules
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import pyfits as pf
import pywcsgrid2

# Name the output file
psname = 'python_plot.ps'

# Read in image data (extension #1) and header
image, hdr = pf.getdata('./data/u9w10107m_drz.fits', 1, header=True)

# Select subarray and transform from counts/sec to counts
image = image[600:1400, 200:1400] * 60.

# Scale input image
bottom, top = 0., 150.
data = (((top - bottom) * (image - image.min())) / (image.max() - image.min())) + bottom

# Determine image size
tam = data.shape

# Define plot size
xsize = 15
ysize = xsize * tam[0] / tam[1]

# Setup plot and custom axes
fig = plt.figure(figsize=(ysize, xsize))
ax = pywcsgrid2.subplot(111, header=hdr)

# Select image colormap
cmap = cm.get_cmap('gray_r')

# Setup axes ticks and labels
ax.locator_params(axis='x', nbins=6)
ax.locator_params(axis='y', nbins=14)
ax.set_xlabel('RIGHT ASCENSION')
ax.set_ylabel('DECLINATION')

# Display background image
im = ax.imshow(data, cmap=cmap, vmax=7.)

# Calculate contours
contour_x = np.arange(tam[1])
contour_y = np.arange(tam[0])

# Set contour levels and colours
levels = [2.2, 3.5, 5.5, 10.]
colors = ['firebrick', 'darkred', 'red']

# Display contours
cnt = plt.contour(contour_x, contour_y, data, colors=colors, levels=levels)

# Save figure
fig.savefig(psname, orientation='landscape')