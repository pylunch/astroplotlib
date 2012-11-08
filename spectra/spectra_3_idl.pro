; NAME:                spectra_3_idl
;
; DESCRIPTION:         Displays side by side plots: a FITS image and a spectrum.
;
; EXECUTION COMMAND:
;                      IDL> .compile spectra_3_idl
;                      IDL> spectra_3_idl
;
; INPUTS:              FITS files ibll62koq_flt.fits and Astar_ebv073.fits
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
pro spectra_3_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

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

       
; define position of plot
; bottom left corner (in cm)
plot_left = 2
plot_bottom = 4
 
; define plot size (in cm)
xsize = 18
ysize = 3

; read input image 
image = mrdfits("ibll62koq_flt.fits", 1, hdr_image)
image = image[200:750, 530:590]
image = BYTSCL(image, min = 0, max = 5)
tam = size(image, /dimensions)

; load colour table
cgloadct, 9, ncolors = 256, bottom = 0, clip = [50,256] 
  
; display background image   
cgimage, image, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


; plot border
cgplot, [0], [0], $
yminor = 1,$
xrange= [0.0, 10.0], $
yrange= [0.0, 10.0], $
xstyle = 1, ystyle = 1, $
xticks = 1, $
yticks = 1, $
xtickformat = "(a1)", $
ytickformat = "(a1)", $
/nodata, /normal, /noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; label spectral orders
xyouts, 0.14, 0.21, "zeroth order", /normal, color = cgcolor("yellow")
xyouts, 0.55, 0.21, "first order", /normal, color = cgcolor("yellow")

; spectrum plot
plot_left = 2
plot_bottom = 7.2
xsize = 18
ysize = 3 

; read spectrum   
spectrum = mrdfits("Astar_ebv073.fits", 1, hdr)

; define wavelength and flux
x = spectrum.wavelength
y = spectrum.flux
   

; scale and plot spectrum
cgplot, x, y * 1.e13, $
xcharsize = 0.8, ycharsize = 0.6, $
yminor = 1, $
xminor = 1, $
xrange= [3500., 7500.], $
yrange= [2.0, 18.0], $
xstyle = 9, ystyle = 1, $
xticklen = 0.08, $
yticklen = 0.01, $
ytitle = "flux", $
xtickformat = "(a1)", $
/nodata, /normal, /noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

oplot, x, y * 1.e13, thick = 3

; plot x axis on top
axis, xaxis = 1, xstyle = 1, xminor = 1, xticklen = 0.08, xcharsize=0.8

; display a label
xyouts, 0.74, 0.33, "HH 123", /normal, charsize = 2.0, color = cgcolor("black")
  

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
