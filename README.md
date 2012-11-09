astroplotlib
============

This is the repo for the PyLunch astroplotlib sprint on 11/09/12.

The astroplotlib project lives here: [astroplotlib.stsci.edu](astroplotlib.stsci.edu)

This repo contains the code for generating the plots on the website. The data
for the plots can be found here:
https://www.dropbox.com/sh/q44tw4y8k6qun66/hLRF872umr.

Python Conventions
==================

Imports
-------

Import matplotlib via `import matplotlib.pyplot as plt`.

Figures and Axes
----------------

Use the [subplots](http://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.subplots)
function to create Figure and Axes objects at the beginning of your example.
For a figure with one axes:

    fig, ax = plt.subplots()

Or a figure with two axes:

    fig, (ax1, ax2) = plt.subplots(1, 2)

Formats
-------

Save figures as PDF.

Reading Data
------------

For reading txt files use NumPy's
[loadtxt]
(http://docs.scipy.org/doc/numpy/reference/generated/numpy.loadtxt.html#numpy.loadtxt)
or
[genfromtxt]
(http://docs.scipy.org/doc/numpy/reference/generated/numpy.genfromtxt.html#numpy.genfromtxt)
when possible.

Fits data should of course be read by pyfits.

Example
-------

    import numpy as np
    import matplotlib.pyplot as plt

    x_data, y_data = np.loadtxt('data.txt', unpack=True)

    fig, ax = plt.subplots()

    ax.plt(x_data, y_data)

    fig.savefig('plot.pdf')
