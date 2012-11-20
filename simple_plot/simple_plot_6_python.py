#! /usr/bin/env python

# Header

"""
Plots data read from a file.
Plots single data points using different symbols and colors.
Labels data points.

:Autor: Tommy Le Blanc

:Organization: Space Telescope Science Intitute

Example
-------

>>> python simple_plot_6_python
"""

# Import necessary modules
import pyfits as pf
import matplotlib.pyplot as plt
import numpy as np

# We read the input file
# first column: magnitude in 3.6 µm
# second column: magnitude in 4.5 µm
# third column: spectral classification
mag36, mag45, classif = loadtxt('data.mag', usecols = (0, 1, 2), unpack = True)

typeo = np.where(classif == 1)
typebe = np.where(classif == 2)
typebl = np.where(classif == 3)
typewr = np.where(classif == 4)
typelvb = np.where(classif == 5)
typeagc = np.where(classif == 6)
typesg = np.where(classif == 7)
typerest = np.where(classif == 8)

# Setup plot, figure size in inches
fig, ax1 = plt.subplots(figsize = (5.9, 5.9))

# Define axes
ax1.set_xlabel('[3.6] - [4.5]')
ax1.set_ylabel('[3.6]')
ax1.set_xlim(-1., 3.2)
ax1.set_ylim(18., 4.)

for t in ax1.get_xticklabels(): t.set_fontsize(10)
for t in ax1.get_yticklabels(): t.set_fontsize(10)    

# Create an alternate axis (for M)
ax2 = ax1.twinx()
ax2.set_ylabel('M$_{3.6}$', fontsize='small')
ax2.set_xlim(-1., 3.2)
ax2.set_ylim(18., 4.)

y1,y2 = ax2.get_ylim()

ax2.set_ylim(y1-18.41, y2-18.41)
for t in ax2.get_yticklabels(): t.set_fontsize(10)

# Plot data
ax1.plot(mag36[typebe] - mag45[typebe], mag36[typebe], marker='s', ms=3, mec='c', mfc = 'c', ls='none', label='early B')
ax1.plot(mag36[typebl] - mag45[typebl], mag36[typebl], marker='*', mec='m', mfc='m', ls='none', alpha=1.0, label='late B')
ax1.plot(mag36[typeo] - mag45[typeo], mag36[typeo], marker='^', ms=5, mec='b', mfc='b', ls='none', alpha=0.7, label='O')
ax1.plot(mag36[typelvb] - mag45[typelvb], mag36[typelvb], marker='o', mec='y', mfc='y', ls='none', alpha=0.7, label='LBV')
ax1.plot(mag36[typeagc] - mag45[typeagc], mag36[typeagc], marker='*', mec='darkblue', mfc='darkblue', ls='none', alpha=0.7, label = 'AFG I')
ax1.plot(mag36[typewr] - mag45[typewr], mag36[typewr], marker='o', mec='darkblue', mfc='white', ls='none', alpha=0.7, label = 'WR')
ax1.plot(mag36[typerest] - mag45[typerest], mag36[typerest], marker='v', ms=5, mec='r', mfc='r', ls='none', alpha=0.7, label = 'RSG')
ax1.plot(mag36[typesg] - mag45[typesg], mag36[typesg], marker='D', ms=3, mec='darkblue', mfc='darkblue', ls='none', alpha=0.7, label = 'sgB[e]')

ax1.legend(numpoints=1, frameon=False, prop={'size':'small'})

# Save plot as PDF
fig.savefig('plot.pdf')