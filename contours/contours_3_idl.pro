; NAME:                contours_3_idl
;
; DESCRIPTION:         Displays a contour on a  FITS image background.
;
; EXECUTION COMMAND:
;                      IDL> .compile contours_3_idl
;                      IDL> contours_3_idl
;
; INPUTS:              FITS file m101_blue.fits
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
pro contours_3_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 4

; define plot size (in cm)
xsize = 15
ysize = 15

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

LoadCT, 0
image = mrdfits("m101_blue.fits", 0, hdr_image)
image = image[300:800,300:800]


data =  255b - bytscl(image, min = 0000, max = 18000)
cgloadct, 3, ncolors = 256, bottom = 0, clip = [90,200]
 
cgimage, data, $
position = [plot_left /page_width ,plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]

tam = size(image, /dim)
contour_x  =  findgen(tam[0]) 
contour_y  =  findgen(tam[1]) 

cgcontour,image, contour_x, contour_y, $
levels = [8000, 12000, 14000], $
xstyle = 1, $
ystyle = 1, $
axiscolor = "black", $
label = 0, $
thick = 3, $
xtickformat = "(a1)", ytickformat = "(a1)", $
c_colors = cgcolor('dark green'), /noerase, $  
position = [plot_left /page_width ,plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height] 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
