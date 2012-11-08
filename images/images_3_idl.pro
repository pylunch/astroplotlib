; NAME:                images_3_idl
;
; DESCRIPTION:         shows the use of colour tables.
;
; EXECUTION COMMAND:
;                      IDL> .compile images_3_idl
;                      IDL> images_3_idl
;
; INPUTS:              FITS file proplyd.fits
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
pro images_3_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

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
img = mrdfits('proplyd.fits', 0, header)
; scale the image
data = 255b - bytscl(img, min = 0, max = 6)


; left figure

; define position and size (in cm)
plot_left = 2
plot_bottom = 5
xsize = 8
ysize = 8

; load colour table
cgloadct,  3  , ncolors = 256, bottom =  00, clip=[0, 200]


; display image
cgimage, data, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; draw axes
cgplot, [0], [0], $
xcharsize = 1.0, $
ycharsize = 1.0, $
thick = 5, $
xrange = [4, -4], $
yrange = [-4, 4], $
title = 'Disk 114-426' ,$
ytitle = textoidl("\Delta\delta [''] "), $
xtitle = textoidl("\Delta\alpha [''] "), $
xstyle = 1, ystyle = 1, /nodata, /normal, /noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height]  
  

; right figure

; define position and size (in cm)
plot_left = 10.5
plot_bottom = 5
xsize = 8
ysize = 8

; scale pixel values
contour_x =  4.0 - findgen(90)* ((4.0 - (-4.0))/89.)  
contour_y = -4.0 + findgen(90)* ((4.0 - (-4.0))/89.)


; draw contour axes
cgloadct, 0
 
cgcontour, img, contour_x, contour_y, $
xcharsize = 1.0, $
title = '345 GHz', $
xrange = [4, -4], $
yrange = [-4, 4], $
xtitle = textoidl("\Delta\alpha [''] "), $
ytickname = replicate(' ',60), $
/noerase, /nodata, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height]  
 
; draw contours using colour table 33
cgloadct, 33, ncolors = 220, bottom =  0, clip = [0,256] 
 
cgcontour, img, contour_x, contour_y, $
levels = [0.0, 0.6, 0.8, 0.9,1.0, 1.2, 2.0, 3.0, 5.0, 7.0],$
xcharsize = 1.0, $
c_labels = [0], $
/fill, $
xrange = [4, -4], $
yrange = [-4, 4], $
xtickname = replicate(' ',60),$
ytickname = replicate(' ',60),$
/noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height]  
 
 
; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here
