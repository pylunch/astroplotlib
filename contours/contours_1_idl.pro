; NAME:                contours_1_idl
;
; DESCRIPTION:         Displays simple contour plot.
;
; EXECUTION COMMAND:
;                      IDL> .compile contours_1_idl
;                      IDL> contours_1_idl
;
; INPUTS:              FITS file input_data.fits
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
;                      Changed input data. Leonardo UBEDA, OCT 2012
;                      Written by Leonardo UBEDA, JAN 2012. 
;
;

 

; ------------------------ idl code begins here
pro contours_1_idl

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

; read input data from FITS file
data = mrdfits("input_data.fits", 0, hdr)

; define x and y labels
x = findgen(50) + 100.0
y = findgen(50) + 10.0

; display labeled contours 
cgcontour, data, x, y, $
xtitle = 'x axis', $
ytitle = 'y axis', $
thick = 5, $
xthick = 5, $
ythick = 5, $
label = 1, $                ;  (0, no labels)
color = cgcolor("black"), $ 
xcharsize = 0.8, $
ycharsize = 0.8, $
xstyle = 1, ystyle = 1, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
