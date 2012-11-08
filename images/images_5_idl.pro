; NAME:                images_5_idl
;
; DESCRIPTION:         Displays a contour plot labeled with astronomical coordinates.
;
; EXECUTION COMMAND:
;                      IDL> .compile images_5_idl
;                      IDL> images_5_idl
;
; INPUTS:              FITS file u9w10107m_drz.fits
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
pro images_5_idl

!p.charthick = 3.0


; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 4


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


; read the input image
image = mrdfits("u9w10107m_drz.fits", 1, hdr)

; select a sub array and transform from counts/sec to counts 
image = image[200:1400,600:1400] * 40.  

 
; scale the input image
data = 255b - bytscl(image, min = 0.0, max = 150.0)


; determine image size
tam = size(data, /dimensions)
 
; define plot size (in cm)
xsize = 15
ysize = 15 * tam[1] / tam[0]    ; keep aspect ratio

cgloadct, 0
   
; plot the background image
cgimage, data,  /keep_aspect_ratio, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


; overplot a contour with alpha and delta labels
imcontour, data, hdr, $
levels = [0.0, 10.0, 100.0, 150.0], $
/noerase, /type, $
thick = 3, $
c_colors = [cgcolor('red5'), cgcolor('red6'), cgcolor('red7')], $  
/keep_aspect_ratio, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
