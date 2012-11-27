#! /usr/bin/env python

# Header

"""
Creates a simple outline histogram from a given set of numbers.

:Author: Tommy Le Blanc

:Organization: Space Telescope Science Institute

Example
-------

>>> python histograms_1_python
"""

# Import necessary modules
import numpy as np
import matplotlib.pyplot as plt

# Read input data and calculate number of bins
xref, yref, mag = loadtxt('master.xy', usecols = (0, 1, 2), unpack = True)

min_mag, max_mag = np.min(mag), np.max(mag)
binsize = 0.2
num_bins = np.floor((max_mag - min_mag) / binsize)

# Create histogram, figure size in inches
fig, ax = plt.subplots(figsize = (4.724, 4.724))

# Define axes
ax.set_xlabel('Mag')
ax.set_ylabel('Histogram Density')
ax.set_xlim(-17., -6.)
ax.set_ylim(0., 2800.)
for t in ax.get_xticklabels(): t.set_fontsize(8)
for t in ax.get_yticklabels(): t.set_fontsize(8)    

# Draw histogram
ax.hist(mag, num_bins, color='red', lw=3., histtype='step')

# Save plot as a PDF file
fig.savefig('plot.pdf')