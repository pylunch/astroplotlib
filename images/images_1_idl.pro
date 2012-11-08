; NAME:                images_1_idl
;
; DESCRIPTION:         displays a FITS image on a PDF file.
;
; EXECUTION COMMAND:
;                      IDL> .compile images_1_idl
;                      IDL> images_1_idl
;
; INPUTS:              WFC3 image ib6w71lxq_flt
;
; OUTPUTS:             PDF file: plot.pdf
;
; NOTES:               change the input data. 
;                      change the output PDF name.
;
;
; AUTHOR:              Leonardo UBEDA
;                      Space Telescope Science Institute, USA 
; 
; REVISION HISTORY:
;                      Written by Leonardo UBEDA, Jan 2012. 
;
;

 

; ------------------------ idl code begins here
pro images_1_idl


; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 6
plot_bottom = 12

; define plot size (in cm)
xsize = 12
ysize = 12

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
image = mrdfits('ib6w71lxq_flt.fits', 4, header)

; select a sub array
image = image[2000:2699,700:1399]
tam = size(image, /dimensions)

; scale the image
data = 255b - bytscl(image, min = 0, max = 100.)

; create plot
cgimage, data, $ 
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height]

; draw axes   
cgplot, [0], [0], $
xcharsize = 0.8, ycharsize = 0.8, $
xthick = 4, $
ythick = 4, $
charthick = 3, $ 
xrange= [0, tam[0]], $
yrange= [0, tam[1]], $
xtitle = 'x pixels',$
ytitle = 'y pixels',$
xstyle = 1, ystyle = 1, $
/nodata, /normal, /noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
