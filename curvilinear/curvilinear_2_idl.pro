; NAME:                curvilinear_2_idl
;
; DESCRIPTION:         Displays polar plot of brightest stars. Right ascension (deg) vs distance (ly)
;
; EXECUTION COMMAND:
;                      IDL> .compile curvilinear_2_idl
;                      IDL> curvilinear_2_idl
;
; INPUTS:              file distance.dat
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
pro curvilinear_2_idl

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


readcol, 'distance.dat', ra, dec, dist


max_dist = 2000  ; largest distance to plot (in light years)
min_dist = 0

; number of radial grid intervals
ndist = 10


min_ang = 45.           ; minimum angle to display
max_ang = 315.          ; maximum angle to display  
ninterv = 10            ; number of anglular intervals

a = where(dist le max_dist and ra le max_ang and ra ge min_ang)
ra =ra[a] 
dist = dist[a]
  
; set up display area  
cgplot, dist, ra * !dtor, $
color = cgcolor("black"), $
xrange= [(-1) * max_dist, max_dist], $
yrange= [(-1) * max_dist, max_dist], $
xstyle = 5, ystyle =5, $
/polar,  /normal, /noerase, /nodata, $
position = [plot_left /page_width, plot_bottom /page_height , (plot_left+xsize) /page_width, (plot_bottom+ysize) /page_height]


; display points
oplot, dist, ra * !dtor, $
psym = symcat(16), symsize = 0.5, $
color = cgcolor("blu7"), /polar      


; draw grid
a = findgen(10000) * (!pi*2/9999.) 
b = where(a ge min_ang * !dtor and a le max_ang * !dtor)
grid_radii =  fillarr((max_dist-min_dist) / ndist, min_dist, max_dist) 

for k = 0, n_elements(grid_radii) - 1  do begin
oplot,  grid_radii[k] * cos(a[b]), grid_radii[k] *sin(a[b]), linestyle = 1, thick = 3, color = cgcolor("black") 
polrec,  grid_radii[k], min_ang * !dtor, x0, y0
;print, grid_radii[k] , min_ang*!dtor, x0, y0
xyouts, x0 , y0, string(grid_radii[k], format= '(I5)'), charsize = 0.8, orientation = -45
endfor

oplot, max_dist * cos(a[b]), max_dist * sin(a[b]), linestyle = 0, thick = 3, color = cgcolor("black")
angle = fillarr((max_ang-min_ang) / ninterv, min_ang, max_ang)
radials = angle * !dtor

for k = 0, n_elements(radials) - 1 do begin
oplot, [0., max_dist], [0., radials[k]], linestyle = 1, thick = 3 , color = cgcolor("black"), /polar
polrec, max_dist, radials[k], x0, y0
xyouts, x0 , y0, string(angle[k], format= '(I3)'), charsize = 1.2, orientation = angle[k]
endfor

oplot, [0., max_dist], [0., min_ang * !dtor], linestyle = 0, thick = 3, color = cgcolor("black"), /polar
oplot, [0., max_dist], [0., max_ang * !dtor], linestyle = 0, thick = 3, color = cgcolor("black"), /polar


; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
