; NAME:                simple_plot_2_idl
;
; DESCRIPTION:         Plots data from a file. First column in file (X) Second column in file (Y).
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_2_idl
;                      IDL> simple_plot_2_idl
;
; INPUTS:              File: data.xy
;                      
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
pro simple_plot_2_idl


; define page size (in cm)
page_height = 21.59
page_width = 27.94

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 5

; define plot size (in cm)
xsize = 20
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
yoffset = page_width, $
scale_factor = 1.0, $
/landscape


; read input file: first column (X values) 
;                  second column (Y values)
readcol, 'data.xy', x, y 

x = x - 54000.

cgplot, x, y , $
xcharsize = 1.0, $ 
ycharsize = 1.0, $
charthick = 3, $ 
xtitle = 'Time (BJD-2,450,000)', $
ytitle = 'Scaled counts/cadence', $
xrange = [962, 1000], $
yrange = [0.5, 1.05] , $
xthick = 3, $
ythick = 3, $
xstyle = 1, $
ystyle = 1, $
thick = 5, $
xticklen = 0.04, $
yticklen = 0.01, $
yminor = 1, $
/nodata, $
/normal, $
position = [plot_left /page_width, plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]

oplot, x, y, $
psym = symcat(16), $
symsize = 0.5, $
color = cgcolor('navy') 


; close postscript file
device, /close
; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here

