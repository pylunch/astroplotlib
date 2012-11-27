#! /usr/bin/env python

# Header

"""
Creates a simple rotated histogram from a given set of numbers.

:Author: Tommy Le Blanc

:Organization: Space Telescope Science Institute

Example
-------

>>> python histogram_3_python
"""

# Import necessary modules
import numpy as np
import matplotlib.pyplot as plt

# Generate random input data, and calculate number of bins based on binsize
np.random.seed(1)
data = np.random.randn(500) * 25

min_data, max_data = np.min(data), np.max(data)
binsize = 5.
num_bins = np.floor((max_data - min_data) / binsize)

# Create histogram
fig, ax = plt.subplots(figsize = (4.724, 4.724))

# Define axes
ax.set_xlabel('N')
ax.set_ylabel('data')
for t in ax.get_xticklabels(): t.set_fontsize(8)
for t in ax.get_yticklabels(): t.set_fontsize(8)

# Draw histogram
n, bins, patches = ax.hist(data, num_bins, fc='darkred', ec='darkred', orientation='horizontal')
for b in patches[::2]: b.set_facecolor('red')


# Save plot as a PDF file
fig.savefig('plot.pdf')