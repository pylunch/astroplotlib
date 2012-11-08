; NAME:                images_2_idl
;
; DESCRIPTION:         displays a FITS image on a PDF file with annotations.
;
; EXECUTION COMMAND:
;                      IDL> .compile images_2_idl
;                      IDL> images_2_idl
;
; INPUTS:              WFPC2 image u9w10107m_drz.fits
;
; OUTPUTS:             PDF file: plot.pdf
;
; NOTES:               change the input data. 
;                      change the output PDF name.
;
; AUTHOR:              Leonardo UBEDA
;                      Space Telescope Science Institute, USA 
; 
; REVISION HISTORY:
;                      Written by Leonardo UBEDA, Jan 2012. 
;
;

 

; ------------------------ idl code begins here
pro images_2_idl

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 5
plot_bottom = 5

; define plot size (in cm)
xsize = 14
ysize = 14

; use postscript output 
set_plot, 'ps'
; name the output file 
psname = 'plot.ps'

; open the postscript file
device, filename = psname, $
xsize = page_width, $
ysize = page_height, $
xoffset = 0, $
yoffset = 0, $
scale_factor = 1.0, $
/portrait 

; read FITS file
image = mrdfits('u9w10107m_drz.fits', 1, header)

; select a sub array
image = image[100:800,100:800]
  
; scale the image
data = 255b - bytscl(image, min = 0., max = 6.)

tam = size(data, /dimensions)


; load colour table
cgloadct, 33, ncolors = 256, bottom = 0, clip = [0,256], /reverse
tvlct, redvector, greenvector, bluevector, /get
   
; display background image   
cgimage, data, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; load colour table
cgloadct, 0
tvlct, redvector, greenvector, bluevector, /get
   
; display axes   
cgplot, [0], [0], $
xcharsize = 1, ycharsize = 1, $
thick = 2, $
xrange= [0, tam[0]], $
yrange= [0, tam[1]], $
xtitle = 'x pixels',$
ytitle = 'y pixels',$
xstyle = 1, ystyle = 1, $
/nodata, /normal, /noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; define coordinates of sources
xc = [112.40, 194.21, 172.80, 385.57, 152.96, 302.10, 317.19, 195.28, 389.43]
yc = [ 399.14, 443.14,  496.3, 407.87, 677.33, 670.35, 675.82, 473.09, 376.93 ]

; display white circles around sources 
oplot, xc, yc, color = cgcolor("white"), psym = symcat(9), symsize = 2

; label two of the sources
xyouts, 125.00, 397.0, '1', charsize = 1.0, color = cgcolor("white") 
xyouts, 205.00, 440.0, '2', charsize = 1.0, color = cgcolor("white") 

; draw a line to indicate scale (values provided are fictitious)
oplot, [680,680], [150,300], linestyle = 0, thick = 3, color = cgcolor("white") 
xyouts, 675, 200, ' 1Kpc', charsize = 1., color = cgcolor("white"), orientation = 90 
 
 
; load colour table for colour bar
cgloadct, 33, ncolors = 256, bottom = 0, clip = [0,256], /reverse
tvlct, redvector, greenvector, bluevector, /get

; define position of colour bar   
plot_left = 6
plot_bottom = 6
xsize = 5
ysize = 0.5

; define colour bar 
cgcolorbar, divisions = 5, $
range = [max(image), min(image)], $
xminor = 1, $
xticklen = 0.1, format = '(I3)', $
palette= [[redvector],[greenvector],[bluevector]], $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] ,$
annotatecolor = 'white', $
charsize = 0.8
  
; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here
