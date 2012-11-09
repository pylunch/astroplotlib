#! /usr/bin/env python

# Header

__author__ = 'D. Hammer, T.S. Le Blanc'
__version__ = 0.1

'''
NAME:
	datacubes_1_python

ABOUT:
	Displays a contour plot on a datacube slice

EXECUTE:
	>>> datacubes_1_python.py

INPUTS:
	FITS datacube ngg4151_hband.FITS

OUTPUTS:	
	PDF file: plot.pdf

NOTES:
	None.

AUTHOR:
	Derek Hammer and Tommy Le Blanc for STScI, Nov. 2012

VERSION HISTORY:
	0.1 - Initial version of datacube_1.py
'''

# Import necessary modules
import pyfits as pf
import matplotlib.pyplot as plt

# read datacube
f = pf.open(wd+'ngc4151_hband.fits')
cube = f[1].data
header = f[1].header

# we plot slice 1067
cube_slice = 1067
image = cube[cube_slice, :, :]
tam = image.shape

# display the background image
fig, ax = plt.subplots()
alplot = ax.imshow(image, vmin = 0, vmax = 100)
alplot.set_cmap('hot')

# define axes
ax.set_xlabel('x pixels')
ax.set_ylabel('y pixels')
ax.set_ylim([0, tam[0]-1])
ax.set_xlim([0, tam[1]-1])

# create contours
levels = [5, 10, 20, 30, 40, 50, 100, 200, 600]
ax.contour(image, levels, colors='g')

fig.savefig('plot.pdf')
