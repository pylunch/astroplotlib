; NAME:                simple_plot_6_idl
;
; DESCRIPTION:         Plots data read from a file.
;                      Plots single data points using different symbols and colors.
;                      Labels data points.

; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_6_idl
;                      IDL> simple_plot_6_idl
;
; INPUTS:              File: data.mag
;
; OUTPUTS:             PDF file: plot.pdf
;
; NOTES:               change the input data. 
;                      change the output PDF name.
;
;
; AUTHOR:              Leonardo UBEDA
;                      Space Telescope Science Institute, USA 
; 
; REVISION HISTORY:
;                      Written by Leonardo UBEDA, Jan 2012. 
;
;




; ------------------------ idl code begins here
pro simple_plot_6_idl

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 5

; define plot size (in cm)
xsize = 15
ysize = 15

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

; we read the input file
; first column: magnitude in 3.6 microns
; second column: magnitude in 4.5 microns
; third column: spectral classification

readcol, 'data.mag', mag36, mag45, classif

typeo = where(classif eq 1)
typebe = where(classif eq 2)
typebl = where(classif eq 3)
typewr = where(classif eq 4)
typelvb = where(classif eq 5 )
typeagc = where(classif eq 6)
typesg = where(classif eq 7)
typerest = where(classif eq 8)

cgplot, mag36 - mag45, mag36, $
xtitle = '[3.6]-[4.5]', $
ytitle = '[3.6]', $
xthick = 4, $
ythick = 4, $
thick = 5, $
xcharsize = 1.0, $
ycharsize = 1.0, $
xticklayout = 0, $
/device, $
/nodata, $
xrange = [-1., 3.2], $
yrange = [18., 4.], $
xstyle = 1, $
ystyle = 8, $ 
xtickinterval = 0.5, $ 
ytickinterval = 2, $
xminor = 0, $
yminor = 0, $
/normal, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


axis, yaxis = 1, $
yrange = (!y.crange - 18.41), $
ystyle = 1, $
ythick = 4, $
ycharsize = 1.4, $
ytitle = '!N!3M!D3.6!N'  

oplot, mag36[typebe] - mag45[typebe], mag36[typebe], $
color = cgcolor("cyan"), psym = symcat(15), symsize = 0.5
 
oplot, mag36[typebl] - mag45[typebl], mag36[typebl], $
color=cgcolor("magenta"), psym = symcat(2), symsize = 1

oplot, mag36[typeo] - mag45[typeo], mag36[typeo], $
color=cgcolor("blu7"), psym = symcat(17), symsize = 1

oplot, mag36[typelvb] - mag45[typelvb], mag36[typelvb], $
color = cgcolor("yellow"), psym = symcat(16), symsize = 1

oplot, mag36[typeagc] - mag45[typeagc], mag36[typeagc], $
color = cgcolor("navy"), psym = symcat(2), symsize = 1

oplot, mag36[typewr] - mag45[typewr], mag36[typewr], $
color = cgcolor("blu8"), psym = symcat(9), symsize=1

oplot, mag36[typerest] - mag45[typerest], mag36[typerest], $
color = cgcolor("red"), psym = symcat(18), symsize=1

oplot, mag36[typesg] - mag45[typesg], mag36[typesg], $
color = cgcolor("blue"), psym = symcat(14), symsize=1

legend = ['O','early B','late B', 'AFG I', 'RSG', 'WR', 'sgB[e]', 'LBV']
symbol = [17, 15, 2, 2 ,18, 9, 14, 16]
clr = [cgcolor("blu7"), cgcolor("cyan"), cgcolor("magenta"), cgcolor("navy"), cgcolor("red"), cgcolor("blu8"), cgcolor("navy"), cgcolor("yellow")]

for k = 0, n_elements(legend)-1 do begin
oplot, [2.5], [6 + k / 2.], color = clr[k], psym = symcat(symbol[k]), symsize=1
xyouts, 2.6, (6 + k / 2.) + 0.1, legend[k], /data, charsize = 1., color = cgcolor("black") 
endfor
  
; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here

 