; NAME:               simple_plot_1_idl
;
; DESCRIPTION:         Plots a function y = f(x) with a given formula.
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_1_idl
;                      IDL> simple_plot_1_idl
;
; INPUTS:              x : dataset X
;                      y : dataset Y 
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
pro simple_plot_1_idl

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 12

; define plot size (in cm)
xsize = 14
ysize = 8


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


; define input data
; dataset x
x = findgen(401) * 0.5
; dataset y
y = sin(x) * exp(-x/30)                     
 
; create the plot
cgplot, x, y , $
xcharsize = 1.0, $ 
ycharsize = 1.0, $
xrange = [0, 120], $
yrange = [-1.0, 1.5], $
charthick = 3, $ 
xtitle = 'x title', $
ytitle = 'y title', $
xthick = 3 , $
ythick = 3 , $
yminor = 1, $
xstyle = 1, $
ystyle = 1, $
/nodata, $
/normal, $
position = [plot_left /page_width, plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]


oplot, x, y , $
color = cgcolor('red') ,$
linestyle = 0 ,$
thick = 5


; close postscript file
device, /close
; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
