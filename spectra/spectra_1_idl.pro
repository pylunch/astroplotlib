; NAME:                spectra_1_idl
;
; DESCRIPTION:         displays a simple spectrum read from a FITS file.
;
; EXECUTION COMMAND:
;                      IDL> .compile spectra_1_idl
;                      IDL> spectra_1_idl
;
; INPUTS:              FITS file Astar_ebv073.fits
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
pro spectra_1_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 2
plot_bottom = 4

; define plot size (in cm)
xsize = 18
ysize = 10


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

; read FITS file with spectrum
spectrum = mrdfits('Astar_ebv073.fits', 1, header)
  
; define variables from structure
x = spectrum.wavelength
y = spectrum.flux
 

; define axes
cgplot, x, y * 1.e13, $
xrange = [3300., 7500.], $
yrange = [0., 18.], $
xcharsize = 0.8 , $
ycharsize = 0.8, $
thick = 5, $
xthick = 5, $
ythick = 5, $
color = cgcolor("black"), $
ytitle=  '!n!3F!i!7k!n!3 (10!e-13!n!3 ergs cm!e-2!n!3 s!e-1!n!3 '+ string(197b) + '!e-1!n!3)', $
xtitle = '!n!3 wavelength (' + string(197b) + ')!3', $                   
xstyle = 1, ystyle = 1, $
/noerase, /nodata, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


; create plot
oplot, x, y * 1.e13, $
linestyle = 0, $
color=cgcolor("blu7")  

 
 
oplot, 6562.85*[1,1], [1.7, 1], thick = 5
oplot, 4861.36*[1,1], [3.5, 1], thick = 5
oplot, 4340.49*[1,1], [4, 1], thick = 5
oplot, 4101.77*[1,1], [4, 1], thick = 5
oplot, 3970.07*[1,1], [4, 1], thick = 5
oplot, 3889.05*[1,1], [4.5, 1], thick = 5
oplot, 3835.38*[1,1], [4.5, 1], thick = 5
oplot, 3797.90*[1,1], [4.5, 1], thick = 5
oplot, 3770.63*[1,1], [4.5, 1], thick = 5
oplot, [3770.63, 6562.85], [1,1], thick = 5
xyouts, 5700., 1.3, 'hydrogen balmer series', alignment = 0.5, charsize = 1.2 
 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
