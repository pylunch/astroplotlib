; NAME:                histograms_3_idl
;
; DESCRIPTION:         creates a simple rotated histogram from a given set of numbers.
;
; EXECUTION COMMAND:
;                      IDL> .compile histograms_3_idl
;                      IDL> histograms_3_idl
;
; INPUTS:              random input data
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
pro histograms_3_idl

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

; random input data
data =  randomn(2, 500) * 25

; create rotated histogram
cghistoplot, data, $
charsize = 1.2, $
xtitle = "N", $
ytitle = "data", $
thick = 5, $
charthick = 3, $ 
bin = 5, $
polycolor = ['red', 'dark red'], $
/fillpolygon, $
rotate=1, $
datacolorname = "dark red",$
/normal, $
position = [plot_left /page_width, plot_bottom/page_height, (plot_left + xsize)/page_width, (plot_bottom + ysize)/page_height]

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here

