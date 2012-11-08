; NAME:                simple_plot_3_idl
;
; DESCRIPTION:         Plots random data as red squares. Obtains a linear fit and overplots the fit.
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_3_idl
;                      IDL> simple_plot_3_idl
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
pro simple_plot_3_idl


; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 10

; define plot size (in cm)
xsize = 12
ysize = 12


; use postscript output 
set_plot, 'ps'
; name the output file 
psname = 'plot.ps'

; open the postscript file
device, filename=psname, $
xsize = page_width, $
ysize = page_height, $
xoffset = 0, $
yoffset = 0, $
scale_factor = 1.0, $
/portrait 


;define some random data
x = randomn(5, 400) * 12.
y = x + randomn(1, n_elements(x))

; perform a line fit to the data
line = linfit(x,y)

; define x values for line fit
x_fit= findgen(20)
; linear fit formula
y_fit = line[1] * x_fit + line[0]

cgplot, x, y , $
xcharsize = 1, $
ycharsize = 1, $
charthick = 3, $ 
xtitle = 'x title', $
ytitle = 'y title', $
xrange = [0, 12], $
yrange = [0, 12], $
xstyle = 1, $
ystyle = 1, $
xthick = 3 , $
ythick = 3 , $
/nodata, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


oplot, x, y, $
psym = symcat(15), $
symsize = 1.2, $
color = cgcolor('red') 

oplot, x_fit, y_fit, $
linestyle = 5, $
thick = 5, $
color = cgcolor('teal') 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here


