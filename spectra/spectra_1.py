'''
displays a simple spectrum read from a FITS file.

:Author: Rosa I Diaz

:Organization: Space Telescope Science Institute, USA

Examples
---------
>>>from spectra import spectra_1
>>> spectra_1('Astar_ebv073.fits', outplot = 'plot.pdf')

'''

import pyfits as py
from pylab import *
import matplotlib as mpl
import matplotlib.pyplot as plt

def spectra_1(fitsfile, outplot=''):
    """
    Open the spectra from a fits file and plots it.
    Saves the plot to an output file.

    ..note::
        For simplicity, there are some plot behaviors
        that are hardcoded. This example is not meant
        to be used as a gneral function. Change the
        hardcoded values as needed

    Parameters
    ----------
    fitsfile : string
        FITS file name

    output : string
        Save plot as this file
    """


    #Read data
    file_spec= py.open(fitsfile)
    data = file_spec[1].data

    # Plotting variables
    x = data.field('wavelength')
    y = data.field('flux')

    #create plot
    fig, ax = plt.subplots(1,1)

    # Plots data scaled to 1.0e13
    ax.plot(x, (y*1.0e13), 'b')

    # Axis Lables
    plt.ylabel('Flux (10 $^{-13}$ ergs cm$^{-2}$ s$^{-1}$ $\AA ^{-1}$)')
    plt.xlabel('Wavelength ($\AA$)')

    # Define limits
    plt.xlim(3500,7500)
    plt.ylim(0,16)

    mz=3   # Set thickness of the tick marks
    lz=8   # Set length of the tick marks
    # Make tick lines thicker
    for l in ax.get_xticklines():
        l.set_markersize(lz)
        l.set_markeredgewidth(mz)
    for l in ax.get_yticklines():
        l.set_markersize(lz)
        l.set_markeredgewidth(mz)

    # Make figure box thicker
    for s in ax.spines.values():
        s.set_linewidth(mz)

    # Overplot lines for the locations of the Balmer lines
    xline = np.array([1.0,1.0])
    yline17 = np.array([1.7,1.0])
    yline35 = np.array([3.5,1.0])
    yline4 = np.array([4,1.0])
    yline45 = np.array([4.5,1.0])
    ax.plot(6562.85*xline, yline17, 'k')
    ax.plot(4861.36*xline, yline35, 'k')
    ax.plot(4340.49*xline, yline4, 'k')
    ax.plot(4101.77*xline, yline4, 'k')
    ax.plot(3970.07*xline, yline4, 'k')
    ax.plot(3889.05*xline, yline45, 'k')
    ax.plot(3835.38*xline, yline45, 'k')
    ax.plot(3797.90*xline, yline45, 'k')
    ax.plot(3770.63*xline, yline45, 'k')
    ax.plot([3770.63, 6562.85], xline,'k')

    # Add Text to the figure at possition 5000A and Flux=1.6
    text(5000,1.3, 'Hidrogen Balmer Series', fontsize = 11)


    plt.savefig(outplot)
