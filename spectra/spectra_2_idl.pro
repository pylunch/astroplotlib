; NAME:                spectra_2_idl
;
; DESCRIPTION:         Displays several spectra read from a FITS file.
;                      Displays a plot within a plot.
;
; EXECUTION COMMAND:
;                      IDL> .compile spectra_2_idl
;                      IDL> spectra_2_idl
;
; INPUTS:              Twelve ckp00_*.fits files
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
pro spectra_2_idl

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

        
; main plot
; define position of plot
; bottom left corner (in cm)
plot_left = 2
plot_bottom = 10

; define plot size (in cm)
xsize = 18
ysize = 10
 

; read the first model to define axes
spect1 = mrdfits( 'ckp00_40000.fits', 1, hdr_image) 
x = spect1.wavelength
y = spect1.g45


; we define the axes for the main plot
cgplot, x, y / 1.e11, $
color = cgcolor("blu7") ,$
xrange = [200., 3000.], $
yrange = [0., 2.2], $
xcharsize = 0.8, $
ycharsize = 0.8, $
thick = 5, $
xthick = 5, $
ythick = 5, $
ytitle = '!n!3F!i!7k!n!3  (10!e-11!n!3 ergs cm!e-2!n!3 s!e-1!n!3 ' + string(197b) + '!e-1!n!3) ' , $
xtitle = '!n!7k!3 (' + string(197b) + ')!3'  ,$                   
xstyle = 1, ystyle = 9, $
/noerase, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 


; we plot ten kurucz models
teff = ['40000', '39000', '38000', '37000', '36000', '35000', '34000' ,'33000', '32000', '30000', '25000']
for k = 0, n_elements(teff)-1 do begin
spect1 = mrdfits( 'ckp00_' + teff[k] + '.fits', 1, hdr_image) 
x = spect1.wavelength
y = spect1.g45

oplot, x, y / 1.e11, $
linestyle = 0, $
thick = 3, $
color = cgcolor("blu7")  
endfor 


; we emphasize the 35000K model in red
spect1 = mrdfits( 'ckp00_35000.fits', 1, hdr_image) 
x = spect1.wavelength
y = spect1.g45

oplot, x, y / 1.e11, $
linestyle = 0, $
color = cgcolor("red")  

; right axis in log scale
axis, yaxis = 1, /ylog, ystyle = 1, ythick = 5, color = cgcolor("black")
 

; inner histogram of fake data

; define position
; bottom left corner (in cm)
plot_left = 14
plot_bottom = 13.5

; define plot size (in cm)
xsize = 5
ysize = 6


; define random data to plot 
data = randomn(1, 1000)

cgloadct, 0
cghistoplot, data, $
binsize = 0.1, $
/outline , $
xstyle = 1, ystyle = 1, $
xminor = 1, $
yminor = 1, $
thick = 3, $
yrange= [0., 55.], $ 
xrange= [-4., 4.], $ 
/noerase, $
ytitle = 'N', $
xcharsize = 0.8, $
ycharsize = 0.8, $
position = [plot_left / page_width, plot_bottom / page_height, (plot_left + xsize) / page_width, (plot_bottom + ysize) / page_height] 

 

; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps

end
; ------------------------ idl code ends here
