; NAME:                histograms_1_idl
;
; DESCRIPTION:         creates a simple outline histogram from a given set of numbers.
;
; EXECUTION COMMAND:
;                      IDL> .compile histograms_1_idl
;                      IDL> histograms_1_idl
;
; INPUTS:              file called 'master.xy'
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
pro histograms_1_idl

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
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

; read input data
readcol, 'master.xy', xref, yref, mag

; create histogram
cghistoplot, mag, $
charsize = 1.2, $
thick = 5, $
charthick = 3, $ 
xrange = [-17., -6.], $
yrange = [0., 2800.], $
bin = 0.2, $
/outline, $
datacolorname = "red",$
/normal, $
position = [plot_left /page_width, plot_bottom/page_height, (plot_left + xsize)/page_width, (plot_bottom + ysize)/page_height]

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
