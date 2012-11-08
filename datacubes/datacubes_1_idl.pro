; NAME:                datacubes_1_idl
;
; DESCRIPTION:         Displays a contour plot on a datacube slice.
;
; EXECUTION COMMAND:
;                      IDL> .compile datacubes_1_idl
;                      IDL> datacubes_1_idl
;
; INPUTS:              FITS datacube ngc4151_hband.fits
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
pro datacubes_1_idl


!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 3
plot_bottom = 4

; define plot size (in cm)
xsize = 16
ysize = 16

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
cube = readfits('ngc4151_hband.fits', hdr, exten = 1)

; load colour table
cgloadct, 3, ncolors = 256, bottom = 0, clip = [0,256], /reverse

; we plot slice 1067
slice = 1067
image = 255b - bytscl(cube[*, *, slice], min = 0, max = 100.)
tam = size(image, /dimensions)

; display the background image
cgimage, image, $
position = [plot_left /page_width ,plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]


; create contours 
contour_x = findgen(tam[0])
contour_y = findgen(tam[1])
image = cube[*, *, slice]
  
cgcontour, image, contour_x, contour_y, $
levels = [5, 10, 20, 30, 40, 50, 100, 200, 600] ,$
xstyle = 1, $
ystyle = 1, $
thick = 3, $
axiscolor = "black", $
xcharsize = 0.8, ycharsize = 0.8, $
xtitle = "x pixels", $
ytitle = "y pixels", $
;label = 0, $                 ; uncomment to get rid of labels
c_colors = cgcolor('green'), /noerase, $  
position= [plot_left /page_width ,plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height] 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
