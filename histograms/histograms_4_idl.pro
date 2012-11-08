; NAME:                histograms_4_idl
;
; DESCRIPTION:         displays two histograms to show x and y histogram distributions
;
; EXECUTION COMMAND:
;                      IDL> .compile histograms_4_idl
;                      IDL> histograms_4_idl
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
pro histograms_4_idl


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

 
 
x1 = 1.2 * random(1, 1800)  
x2 = 0.2 * random(3, 500) - 1.0
x3 = 0.3 * random(3, 200) - 2.0
x =[x1, x2, x3]
y1 = 1.2 * random(2, 1800)  
y2 = 0.2 * random(4, 500) - 2.0
y3 = 0.3 * random(5, 200) + 2.0
y =[y1, y2, y3]
help, x
help, y

 

; first histogram ____________________________________________________

; define position of plot
; bottom left corner (in cm)
plot_left = 3
plot_bottom = 12.4

; define plot size (in cm)
xsize = 8
ysize = 8


; create rotated histogram
cghistoplot, x, $
charsize = 1.2, $
;xtitle = "N", $
ytitle = "", $
xrange= [-4., 4.], $
yrange= [0., 300.], $
thick = 5, $
charthick = 3, $ 
xstyle = 9, $
xtickname = replicate(' ', 60), $
bin = 0.2, $
datacolorname = "grn5",$
/normal, $
position = [plot_left /page_width, plot_bottom/page_height, (plot_left + xsize)/page_width, (plot_bottom + ysize)/page_height]



; first histogram ____________________________________________________
           
 
 
; second histogram rotated  ____________________________________________________
; define position of plot
; bottom left corner (in cm)
plot_left = 11.4
plot_bottom = 4

; define plot size (in cm)
xsize = 8
ysize = 8


; create rotated histogram
cghistoplot, y, $
charsize = 1.2, $
xtitle = "", $
;ytitle = "data", $
thick = 5, $
charthick = 3, $ 
yrange= [-4., 4.], $
xrange= [0., 150.], $
ystyle = 9, $
ytickname = replicate(' ', 60), $
bin = 0.1, $
rotate=1, $
/noerase, $
/outline , $
datacolorname = "grn5",$
/normal, $
position = [plot_left /page_width, plot_bottom/page_height, (plot_left + xsize)/page_width, (plot_bottom + ysize)/page_height]

; second histogram rotated  ____________________________________________________
      

; main plot  ____________________________________________________
; define position of plot
; bottom left corner (in cm)
plot_left = 3
plot_bottom = 4

; define plot size (in cm)
xsize = 8
ysize = 8

cgplot, x, y , $
xcharsize=0.8  , ycharsize=0.8   ,$
xrange= [-4., 4.], $
yrange= [-4., 4.], $
charthick = 3, $ 
ytitle = 'y',$
xtitle = 'x',$
xthick = 4, $
ythick = 4, $
/noerase, $
xstyle =1,ystyle =1 , /nodata, $
/normal, $
position = [plot_left /page_width, plot_bottom/page_height, (plot_left + xsize)/page_width, (plot_bottom + ysize)/page_height]


cgplot, x, y , $
psym = symcat(16), /overplot,/noerase, $
color = cgcolor("blu7") ,symsize= 0.5 
; main plot  ____________________________________________________
 
 
; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
