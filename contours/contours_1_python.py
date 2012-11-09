"""
Displays simple contour plot.

:Authors: Pey Lian Lim, Charles Lajoie

:Organization: Space Telescope Science Institute, USA

Examples
---------
>>> from contours_1_python import contours_1
>>> contours_1('input_data.fits', outplot='plot.pdf')

"""
# THIRD PARTY
import matplotlib.pyplot as plt
import numpy
import pyfits


def contours_1(fitsfile, ext=0, outplot=''):
    """
    Change the input data, plot contour, and save
    to output file.

    .. note::

        For simplicity, there are some plot behaviors
        that are hardcoded. This example is not meant
        to be used as a general function. Change the
        hardcoded values as needed.

    Parameters
    ----------
    fitsfile : string
        FITS file name.

    ext : int
        FITS data extension number.

    outplot : string
        Save plot as this file.

    """
    lw = 2  # Line widths throughout the plot
    fsz = 16  # Font size throughout the plot

    # Read input data from FITS file
    data = pyfits.getdata(fitsfile, ext)

    # Define X and Y labels
    x = numpy.arange(50) + 100.0
    y = numpy.arange(50) + 10.0

    # Square figure
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.set_aspect('equal')

    # Contour and labels
    cs = ax.contour(x, y, data, colors='k', linewidths=lw)
    plt.clabel(cs, fontsize=fsz)

    # Axes labels
    ax.set_xlabel('x axis', fontsize=fsz)
    ax.set_ylabel('y axis', fontsize=fsz)

    # Make tick lines thicker
    for l in ax.get_xticklines():
        l.set_markeredgewidth(lw)
    for l in ax.get_yticklines():
        l.set_markeredgewidth(lw)

    # Make axis label larger
    for tick in ax.xaxis.get_major_ticks():
        tick.label.set_fontsize(fsz)
    for tick in ax.yaxis.get_major_ticks():
        tick.label.set_fontsize(fsz)

    # Make figure box thicker
    for s in ax.spines.values():
        s.set_linewidth(lw)

    plt.show()

    # Centered on page by default
    if outplot:
        plt.savefig(outplot)
        print outplot, 'created'
