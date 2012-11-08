; NAME:                simple_plot_9_idl
;
; DESCRIPTION:         Displays a Hertzsprung–Russell diagram.
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_9_idl
;                      IDL> simple_plot_9_idl
;
; INPUTS:              Six theoretical models M???Z14V0.dat.txt
;                      from http://obswww.unige.ch/Recherche/evol/
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
pro simple_plot_9_idl


PREF_SET, 'IDL_PATH', '+/users/lubeda/idl:' + '+/users/lubeda/idl/textoidl:' + !PATH,/COMMIT 



; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 4

; define plot size (in cm)
xsize = 12
ysize = 14


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


readcol, 'M001Z14V0.dat.txt', a, a, a, lum001, teff001 
readcol, 'M002Z14V0.dat.txt', a, a, a, lum002, teff002 
readcol, 'M005Z14V0.dat.txt', a, a, a, lum005, teff005 
readcol, 'M020Z14V0.dat.txt', a, a, a, lum020, teff020 
readcol, 'M040Z14V0.dat.txt', a, a, a, lum040, teff040 
readcol, 'M060Z14V0.dat.txt', a, a, a, lum060, teff060 
 
x_title_text = textoidl("log(T_{eff} [K])")
y_title_text = 'log(L/L'+cgsymbol('sun') + ')'

cgplot, teff060, lum060, $
xtitle = x_title_text  , $
ytitle = y_title_text  , $
xthick = 4, $
ythick = 4, $
color = cgcolor("black"), $ 
xcharsize = 1.0, $
ycharsize = 1.0, $
charthick = 3, $ 
thick = 5, $
/nodata, $
yminor = 2, $
xrange = [5.0, 3.4], $
yrange = [ -0.5, 6.3], $
xstyle = 1, $
ystyle = 1, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 



oplot, teff001, lum001, color = cgcolor("navy"), symsize = 1, thick = 5
oplot, teff002, lum002, color = cgcolor("navy"), symsize = 1, thick = 5
oplot, teff005, lum005, color = cgcolor("navy"), symsize = 1, thick = 5
oplot, teff020, lum020, color = cgcolor("navy"), symsize = 1, thick = 5
oplot, teff040, lum040, color = cgcolor("navy"), symsize = 1, thick = 5
oplot, teff060, lum060, color = cgcolor("navy"), symsize = 1, thick = 5


; make some annotations
xyouts, 4.35, 2.5, $
'5 M' + cgsymbol('sun')  , $
/data, $
charsize = 1.3, $
charthick = 4, $
color = cgcolor("blu6") 

xyouts, 4.65, 4.4, $
'20 M' + cgsymbol('sun')  , $
/data, $
charsize = 1.3, $
charthick = 4, $
color = cgcolor("blu6") 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here
