#! /usr/bin/env python

# Header

'''
 NAME:                spectra_3_python

 DESCRIPTION:         Displays stacked plots: a spectrum and a FITS image.

 EXECUTION COMMAND:
                      >>> python spectra_3_python.py
 
 INPUTS:              FITS file(s): ibll62koq_flt.fits and Astar_ebv073.fits
                    
 OUTPUTS:             PDF file: python_plot.ps


 AUTHOR:              Tommy LE BLANC
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      Written by Tommy LE BLANC, JUL 2013. 
'''

# Import ncessary modules
import numpy as np
import pyfits as pf
import matplotlib.pyplot as plt
import matplotlib.cm as cm

# Name the output file
psname = 'python_plot.ps'

# Read in spectrum
spectrum = pf.getdata('./data/Astar_ebv073.fits', 1)
x = spectrum.field('wavelength')
y = spectrum.field('flux')

# Read input image
image = pf.getdata('./data/ibll62koq_flt.fits', 1)
image = image[530:590, 200:750]

# Set up plot
fig = plt.figure(figsize=(12, 4))
ax_spec = plt.axes([.1, .525, .8, .4])
ax_spec.set_ylabel('flux')
ax_im = plt.axes([.1, .0925, .8, .4])

# Plot spectrum
ax_spec.set_xlim(3500., 7500.)
ax_spec.set_ylim(2., 18.)
ax_spec.plot(x, y * 1.e13, color='black')
ax_spec.text(6700, 12, 'HH 123', size=24)

# Plot image
cmap=cm.get_cmap('YlGnBu_r')
ax_im.imshow(image, cmap=cmap, vmin=0, vmax=5, aspect='auto')
ax_im.text(30, 35, '$zero^{th} order$', color='yellow', size=18)
ax_im.text(300, 35, '$1^{st} order$', color='yellow', size=18)

# Relabel spectrum axes and turn of image axes labels and ticks
nullfmt = plt.NullFormatter()
ax_spec.xaxis.set_ticks([4000, 5000, 6000, 7000], minor=False)
ax_spec.xaxis.set_ticks_position('top')
ax_spec.yaxis.set_ticks([5, 10, 15], minor=False)

ax_im.xaxis.set_major_formatter(nullfmt)
ax_im.yaxis.set_major_formatter(nullfmt)
ax_im.xaxis.set_ticks([])
ax_im.yaxis.set_ticks([])

# Save figure
fig.savefig(psname, orientation='landscape')