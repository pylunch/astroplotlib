; NAME:                simple_plot_8_idl
;
; DESCRIPTION:         Displays a bubble plot.
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_8_idl
;                      IDL> simple_plot_8_idl
;
; INPUTS:              File bubble.dat
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
pro simple_plot_8_idl

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
ysize = 9

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

; we read the input file
readcol, 'bubble.dat', x, y, size


; define the axes
cgplot, x, y, $
xtitle = textoidl("log(\nu) [ghz] "), $
ytitle = 'peak time rank number', $
xthick = 4, $
ythick = 4, $
color = cgcolor("black"), $ 
xcharsize = 0.8, $
ycharsize = 0.8, $
ytickinterval = 1, $
xticklayout = 0, $
thick = 5, /nodata, $
xrange = [0., 2.5], $ 
yrange= [ 0., 8], $
xstyle = 8, ystyle = 8, $
xticklen = -0.02, yticklen = -0.01, $
xminor = 1, yminor = 1, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; plot the bubbles
for k = 0, n_elements(x)-1  do begin
oplot, [x[k]], [y[k]], $
color = cgcolor("navy"), $
psym = symcat(16), $
symsize = size[k]
endfor  

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here

 