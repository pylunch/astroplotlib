#! /usr/bin/env python

# Header

"""
Display two histograms to show x and y histogram distributions.

:Author: Tommy Le Blanc

:Organization: Space Telescope Science Institute

Example
-------

>>> python histogram_4_python
"""

# Import necessary modules
import numpy as np
import matplotlib.pyplot as plt

# Generate random input data
np.random.seed(1)
x1 = 1.2 * np.random.randn(1800)
np.random.seed(3)
x2 = 0.2 * np.random.randn(500) - 1.0
np.random.seed(3)
x3 = 0.3 * np.random.randn(200) - 2.0
x = numpy.hstack((x1, x2, x3))
np.random.seed(2)
y1 = 1.2 * np.random.randn(1800)
np.random.seed(4)
y2 = 0.2 * np.random.randn(500) - 2.0
np.random.seed(5)
y3 = 0.3 * np.random.randn(200) + 2.0
y = numpy.hstack((y1, y2, y3))

# Calculate number of bins based on binsize for both x and y
min_x_data, max_x_data = np.min(x), np.max(x)
binsize = 0.2
num_x_bins = np.floor((max_x_data - min_x_data) / binsize)

min_y_data, max_y_data = np.min(y), np.max(y)
binsize = 0.1
num_y_bins = np.floor((max_y_data - min_y_data) / binsize)

# Axes definitions
nullfmt = NullFormatter()
left, width = 0.1, 0.4
bottom, height = 0.1, 0.4
bottom_h = left_h = left + width + 0.02

rect_scatter = [left, bottom, width, height]
rect_histx = [left, bottom_h, width, 0.4]
rect_histy = [left_h, bottom, 0.4, height]

# Generate initial figure, scatter plot, and histogram quadrants
fig = plt.figure(221, figsize=(6.3, 6.3))

axScatter = fig.add_subplot(223, position=rect_scatter)
axScatter.set_xlabel('x')
axScatter.set_ylabel('y')
axScatter.set_xlim(-4., 4.)
axScatter.set_ylim(-4., 4.)

axHistX = fig.add_subplot(221, position=rect_histx)
axHistX.set_xlim(-4., 4.)
axHistX.set_ylim(0, 300.)

axHistY = fig.add_subplot(224, position=rect_histy)
axHistY.set_xlim(0, 150.)
axHistY.set_ylim(-4., 4.)

# Remove labels from histogram edges touching scatter plot
axHistX.xaxis.set_major_formatter(nullfmt)
axHistY.yaxis.set_major_formatter(nullfmt)

# Draw scatter plot
axScatter.scatter(x, y, marker='o', color = 'darkblue', edgecolor='none', s=3, alpha=0.7)

# Draw x-axis histogram
axHistX.hist(x, num_x_bins, ec='green', fc='none', histtype='bar')

# Draw y-axis histogram
axHistY.hist(y, num_y_bins, ec='green', fc='none', histtype='step', orientation='horizontal')

# Save figure
fig.savefig('plot.pdf')