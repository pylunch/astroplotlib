; NAME:                simple_plot_7_idl
;
; DESCRIPTION:         Plots data read from several files.
;                      Uses different line styles and colors
;                      Labels datapoints
; 
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_7_idl
;                      IDL> simple_plot_7_idl
;
; INPUTS:              
;                      File cigale_fit.txt
;					   File m82_match.txt
;                      File arp220_match.txt
;                      File rr_fit.txt
;                      File observed_fluxes.txt
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
pro simple_plot_7_idl


!p.charthick = 3.0

; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 5

; define plot size (in cm)
xsize = 12
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

; we read the input files

readcol, 'cigale_fit.txt', lambda_cigale, flux_cigale, format = '(F,A)'
flux_cigale = double(flux_cigale)
readcol, 'm82_match.txt', lambda_m82, flux_m82, format = '(F,A)'
flux_m82 = double(flux_m82)
readcol, 'arp220_match.txt', lambda_arp, flux_arp, format = '(F,A)' 
flux_arp = double(flux_arp)
readcol, 'rr_fit.txt', lambda_rr, flux_rr, format = '(F,A)'
flux_rr = double(flux_rr)
readcol, 'observed_fluxes.txt', lambda_data, flux_data, flux_error_data, format = '(F,A,A)'
flux_data = double(flux_data)
flux_error_data = double(flux_error_data)


cgplot, lambda_cigale, flux_cigale, $
psym = symcat(16), $
color = cgcolor("black"), $
xrange = [0.2, 5500.], $
yrange = [1.e-3, 1000], $
ytickformat = '(g7.1)', $
xcharsize = 1.0, $
ycharsize = 1.0, $
ytitle = '!N!3Flux density [mJy!N!3]', $
xtitle = '!NWavelength [!7l!3m]!3', $                   
xstyle = 1, $
ystyle = 1, $
thick = 4, $
/xlog, /ylog, $
/device, $
/noerase, $
/nodata, $
/normal, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


oplot, lambda_cigale, flux_cigale, $
linestyle = 0, $
color = cgcolor("red"), $
thick = 5    

oplot,  lambda_m82, flux_m82, $
linestyle = 4, $
color = cgcolor("navy"), $
thick = 5    


oplot,  lambda_arp, flux_arp, $
linestyle = 3, $
color = cgcolor("orange"), $
thick = 5   

oplot,  lambda_rr, flux_rr, $
linestyle = 2, $
color = cgcolor("green"), $
thick = 5   


oploterror, lambda_data, flux_data, flux_error_data, $
psym = symcat(16), $
symsize= 0.7, $
color = cgcolor("blu7"), $
errcolor = cgcolor("blu7"), $
thick =4


oplot, [0.5,3.5], [400,400.], $
linestyle = 0, $
color = cgcolor("red"), $
thick = 5
xyouts, 4.5 ,350, 'CIGALE', charsize = 1.2, /data

oplot, [0.5,3.5], [220,220.], $
linestyle = 2, $
color = cgcolor("green"), $
thick = 5   
xyouts, 4.5 ,190 , 'Rowan-Robinson', charsize = 1.2, /data

oplot, [0.5,3.5], [120,120.], $
linestyle = 3, $
color = cgcolor("orange"), $
thick = 5   
xyouts, 4.5 ,110, 'Arp220', charsize = 1.2, /data

oplot, [0.5,3.5], [70,70.], $
linestyle = 4, $
color = cgcolor("navy"), $
thick = 5   
xyouts, 4.5 ,60 , 'M82', charsize = 1.2, /data


; close postscript file
device, /close
; create a PDF file
cgps2pdf, psname, /delete_ps
end
; ------------------------ idl code ends here

 