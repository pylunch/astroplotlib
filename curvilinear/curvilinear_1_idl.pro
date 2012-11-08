; NAME:                curvilinear_1_idl
;
; DESCRIPTION:         Displays an LMC extinction map on curvilinear coordinates.
;
; EXECUTION COMMAND:
;                      IDL> .compile curvilinear_1_idl
;                      IDL> curvilinear_1_idl
;
; INPUTS:              FITS binary table lmc_map.fits
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
pro curvilinear_1_idl

!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 0.5
plot_bottom = 5

; define plot size (in cm)
xsize = 18
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


; read the input LMC extinction map file
img = mrdfits('lmc_map.fits', 0, hdr)


; define the curvilinear coordinates   
map_set, -70, 80., $
/azimuthal, $
limit = [-66, 64, -73, 96], $ 
reverse = 1, $
/noborder, $
position = [plot_left /page_width, plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]

; define axes values
alpha0 = 66.8
delta0 = -73.1

dalpha = 0.1
ddelta = 0.1

nx = (94.2 - 66.8) / dalpha
ny = (73.1 - 66.8) / ddelta

contour_y = delta0 + findgen(ny) * ddelta
contour_x = findgen(nx) * dalpha + alpha0
 
; load colour table
; use reds and yellows 
cgloadct, 33, ncolors = 256, bottom = 0, clip = [180,255]  
 
; display filled contour plot (LMC extinction map)  
cgcontour, smooth(img,2), contour_x, contour_y, $
xcharsize = 1.2, $
ycharsize = 1.2, $
xstyle = 1, ystyle = 1, $
levels = [0, 0.1, 0.2, 0.5], $
/noerase, /overplot, /fill, $
position = [plot_left /page_width, plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]
 

cgloadct,  0  

; overplot grid  
map_set, -70, 80., $
/azimuthal, $
limit = [-66, 64, -73, 96], $ 
/grid, /label, /noerase, $
glinethick = 5, $
reverse = 1, /noborder, $
latlab = 96.8, lonlab = -73.3, londel = 2, $   
position = [plot_left /page_width, plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]


; write titles  
xyouts, 82.0, -73.7, textoidl("\alpha (degree) "), charsize= 1.2, /data
xyouts, 97.5, -70.0, textoidl("\delta (degree) "), charsize= 1.2, orientation= 105., /data

 
; display colour bar

; define position in cm
xcb =  19.5
ycb = 5
widthcb = 0.7
heightcb = 10


; load the same colour table
cgloadct, 33, ncolors = 256, bottom = 0, clip = [180,255]   
tvlct, redvector, greenvector, bluevector, /get

a = where(img gt -500.)   ; select only physical values
cgcolorbar, divisions = 6, $
range = [min(img[a]), max(img[a])], $
xminor = 1, $
yticklen = 1, $
format = '(f5.2)', $
palette = [[redvector], [greenvector], [bluevector]], $
position = [xcb /page_width, ycb /page_height , (xcb+widthcb) /page_width, (ycb+heightcb) /page_height], $
/vertical, /right, $
annotatecolor = 'black', charsize = 1.

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
