'''
 NAME:                images_1_python

 DESCRIPTION:         displays a FITS image on a PDF file.

 EXECUTION COMMAND:
                      > python images_1_python

 INPUTS:              WFC3 image ib6w71lxq_flt

 OUTPUTS:             PDF file: plot.pdf

 NOTES:               change the input data. 
                      change the output PDF name.


 AUTHOR:              Leonardo UBEDA
                      Space Telescope Science Institute, USA 
 
 REVISION HISTORY:
                      Written by Leonardo UBEDA, Jan 2012. 

'''

 

# ------------------------ python code begins here
#!/usr/bin/env python


# import packages
import pylab
import pyfits

# name the output file 
pdfname = 'python_plot.pdf'


# read FITS file 
image = pyfits.open('ib6w71lxq_flt.fits')

# select extension 4
sci = image[4].data

# select a sub array
sci = sci[700:1399, 2000:2699]


# obtain sub array size
tam = sci.shape

# display scaled sub array
pylab.clf()
pylab.gray()
pylab.imshow(sci, vmin = 0, vmax = 100)

pylab.xlabel('x pixels')
pylab.ylabel('y pixels')
pylab.ylim([0, tam[0]])
pylab.xlim([0, tam[1]])

# close and save file 
pylab.savefig(pdfname) 


# ------------------------ python code ends here
