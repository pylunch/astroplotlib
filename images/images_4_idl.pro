; NAME:                images_4_idl
;
; DESCRIPTION:         Displays an ACS footprint on a DSS image. No geometric distortion applied.
;
; EXECUTION COMMAND:
;                      IDL> .compile images_4_idl
;                      IDL> images_4_idl
;
; INPUTS:              FITS file m101_blue.fits
;                      j8d602gxq_flt.fits
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
pro images_4_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define plot position and size (in cm)
plot_left = 5.
plot_bottom = 5 
xsize = 14. 
ysize = 14.

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

; load the background DSS image   
image = mrdfits( "m101_blue.fits",0 , hdr_image)

; get image size
dim = [sxpar(hdr_image,'naxis1'), sxpar(hdr_image,'naxis2')] 
x = [0.0, dim[0]-1]
y = [0.0, dim[1]-1]

; read both ACS chips (extensions 1 and 4) 
image1 = mrdfits( "j8d602gxq_flt.fits",1 ,hdr_flt1)
image4 = mrdfits( "j8d602gxq_flt.fits",4 ,hdr_flt4)

chip_x1 = 0.0
chip_x2 = 4096.
chip_x3 = 4096.
chip_x4 = 0.0
chip_y1 = 0.0
chip_y2 = 0.0
chip_y3 = 2048.
chip_y4 = 2048.

; use WCS to obtain celestial coordinates of corners
; acs chip 1
extast, hdr_flt1, astr1
xy2ad, [chip_x1,chip_x2,chip_x3,chip_x4], [chip_y1,chip_y2,chip_y3,chip_y4], astr1, ra, dec
extast, hdr_image, astr
ad2xy, ra ,dec, astr, x_acs1, y_acs1


; acs chip 2
extast, hdr_flt4, astr4
xy2ad, [chip_x1,chip_x2,chip_x3,chip_x4], [chip_y1,chip_y2,chip_y3,chip_y4], astr4, ra, dec
extast, hdr_image, astr
ad2xy, ra ,dec, astr, x_acs2, y_acs2

cgloadct, 0
cgimage, image, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; define axes
plot, [0], [0] , $
xcharsize = 1, ycharsize = 1, $
xrange = [x[0], x[1]], $
yrange = [y[0], y[1]], $
xtitle = 'x pixels', $
ytitle = 'y pixels', $
xstyle = 1, ystyle = 1, $
/nodata, /normal, /noerase, $ 
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; plot ACS chip 1 footprint
plots, [ [  x_acs1[0] , y_acs1[0] ] ], color = cgcolor("red"), thick = 3, /data
plots, [ [  x_acs1[1] , y_acs1[1] ] ], /continue, color = cgcolor("red"), thick=3, /data
plots, [ [  x_acs1[2] , y_acs1[2] ] ], /continue, color = cgcolor("red"), thick=3, /data
plots, [ [  x_acs1[3] , y_acs1[3] ] ], /continue, color = cgcolor("red"), thick=3, /data
plots, [ [  x_acs1[0] , y_acs1[0] ] ], /continue, color = cgcolor("red"), thick=3, /data

; plot ACS chip 2 footprint
plots, [ [  x_acs2[0] , y_acs2[0] ] ], color = cgcolor("red"), thick=3, /data
plots, [ [  x_acs2[1] , y_acs2[1] ] ], /continue, color = cgcolor("red"), thick = 3, /data
plots, [ [  x_acs2[2] , y_acs2[2] ] ], /continue, color = cgcolor("red"), thick = 3, /data
plots, [ [  x_acs2[3] , y_acs2[3] ] ], /continue, color = cgcolor("red"), thick = 3, /data
plots, [ [  x_acs2[0] , y_acs2[0] ] ], /continue, color = cgcolor("red"), thick = 3, /data

 
; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here
