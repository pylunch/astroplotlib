; NAME:                datacubes_2_idl
;
; DESCRIPTION:         Displays a contour plot on a datacube slice.
;
; EXECUTION COMMAND:
;                      IDL> .compile datacubes_2_idl
;                      IDL> datacubes_2_idl
;
; INPUTS:              FITS datacube ngc4151.fits
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
pro datacubes_2_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 3
plot_bottom = 4

; define plot size (in cm)
xsize = 17
ysize = 7

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

  
; read datacube
; this cube is not continuum subtracted
cube = readfits('ngc4151_hband.fits', hdr, exten = 1)

; we calibrate in wavelength from header keywords
crpix3 = sxpar(hdr,'CRPIX3')
cdelt3 = sxpar(hdr,'CDELT3')
crval3 = sxpar(hdr,'CRVAL3')

tam = size(cube, /dimensions)

pixel = findgen(tam[2]) + 1.0
lambda = crval3 + (pixel - crpix3)* cdelt3
 
; select pixel with coordinates [30, 30]
flux = cube[30, 30, 100:1900] 
lambda_microns =  lambda[100:1900] / 1.e4

; plot axes
cgplot, [0], [0], $
xcharsize = 0.8, ycharsize = 0.8, $
thick = 3, $
xthick = 3, $
ythick = 3, $
xrange= [min(lambda_microns), max(lambda_microns)], $
yrange= [min(flux) - 10., max(flux) + 10.], $
xtitle = 'wavelength ' + textoidl("(\mum) "), $
ytitle = 'flux',$
xstyle = 1, ystyle = 1, $
yminor = 1, $
/nodata, /normal, /noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


; display spectrum
; flux in arbitrary units
oplot, lambda_microns, flux, $
thick = 3, $
color = cgcolor("red")  
 
; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
