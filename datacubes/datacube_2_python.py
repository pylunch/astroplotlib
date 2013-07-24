#! /usr/bin/env python

# Header

"""
Display the spectrum of one pixel of a datacube

:Author: Tommy Le Blanc

:Organization: Space Telescope Science Intitute

Example
-------

>>> python datacubes_2_python.py
"""

# Import necessary modules
import pyfits as pf
import matplotlib.pyplot as plt
import numpy as np

# Read datacube
# This datacube is not continuum subtracted
f = pf.open('ngc4151_hband.fits')
cube = f[1].data
hdr = f[1].header
f.close()

# Calibrate in wavelength from header keywords
crpix3 = hdr['CRPIX3']
cdelt3 = hdr['CDELT3']
crval3 = hdr['CRVAL3']

tam = cube.shape

pixel = np.arange(tam[0]) + 1.0
lamb = crval3 + (pixel - crpix3) * cdelt3

# Select pixel with coodinates [30, 30]
flux = cube[100:1900, 30, 30]
lambda_microns = lamb[100:1900] / 1.e4

# Setup plot, figure size in inches
fig, ax = plt.subplots(figsize = (6.7, 2.75))

# Define axes
ax.set_xlabel('wavelength ('+'$\mu$'+'m)')
ax.set_ylabel('flux')
ax.set_xlim([min(lambda_microns), max(lambda_microns)])
ax.set_ylim([min(flux), max(flux)])

# Plot spectrum
ax.plot(lambda_microns, flux, 'r-', linewidth = 2)

# Save figure
fig.savefig('plot.pdf')