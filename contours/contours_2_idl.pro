; NAME:                contours_2_idl
;
; DESCRIPTION:         Displays a filled contour plot and a color bar.
;
; EXECUTION COMMAND:
;                      IDL> .compile contours_2_idl
;                      IDL> contours_2_idl
;
; INPUTS:              Random data.
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
pro contours_2_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 6
plot_bottom = 4

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

; define random input data
x = findgen(50) + 100.0
y = findgen(50) + 10.0
gauss2d, 50, 50, 35, 35, 10., array1
gauss2d, 50, 50, 10, 10, 45., array2
z = (array1 + array2) * 10.
 
 
cgloadct, 33

; display filled contours 
cgcontour, z, x, y, $
xtitle = 'x axis', $
ytitle = 'y axis', $
thick = 5, $
xthick = 5, $
ythick = 5, $
/fill, $
levels = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], $
color = cgcolor("black"), $ 
xcharsize = 0.8, $
ycharsize = 0.8, $
xstyle = 1, ystyle = 1, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; define position of color bar
; bottom left corner (in cm)
plot_left = 6
plot_bottom = 16.3

; define color bar size (in cm)
xsize = 12
ysize = 0.7
         
cgcolorbar, $
range = [min(z), max(z)], $
xminor = 1, $
xticklen = 1.0, $
format = '(I2)', $
top = 1, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
