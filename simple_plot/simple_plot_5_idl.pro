; NAME:                simple_plot_5_idl
;
; DESCRIPTION:         Plots data read from two files.
;                      Plots vertical error bars
;                      Creates two side by side figures with a common x axis.
;
; EXECUTION COMMAND:
;                      IDL> .compile simple_plot_5_idl
;                      IDL> simple_plot_5_idl
;
; INPUTS:              File: radial_velocities_cfa.dat
;                      File: radial_velocities_griffin.dat
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
pro simple_plot_5_idl


; define page size (in cm)
page_height = 27.94
page_width = 21.59

; define position of plot
; bottom left corner (in cm)
plot_left = 4
plot_bottom = 12

; define plot size (in cm)
xsize = 14
ysize = 10


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


; read input data from two given files
readcol, 'radial_velocities_cfa.dat', id, year, jd, phase, rv, err, rvcalc, oc, ocerr   
readcol, 'radial_velocities_griffin.dat', idg, yearg, jdg, phaseg, rvg, errg, rvcalcg, ocg, ocerrg   


; load black and white color table
loadct, 0
        
; position and size of upper plot
plot_left = 6                                          
plot_bottom = 12                                       
xsize = 10.5                                          
ysize = 7.5                                          
 
ploterror, phase, rv, err, $                           
psym = symcat(16), $                                   
position = [plot_left, plot_bottom, plot_left + $      
            xsize, plot_bottom + ysize] * 1000., $
color = cgcolor("black"), $                            
xrange = [-0.05, 1.05], $                              
yrange = [-16., 4.], $                                 
symsize = 0.7, $                                        
ytitle = 'Radial Velocity (km s!E-1!N)', $            
xcharsize = 1., $                                      
ycharsize = 1., $                                      
charthick = 3, $ 
hatlength = 100., $                                    
xtickname = replicate(' ',60), $                      
xthick = 3 , $
ythick = 3 , $
xstyle = 1, $                                          
ystyle = 1, $  ;; use exact y range
/device                                              
                                                
oplot, phaseg, rvg-1.043, $                            
psym = symcat(9), $                                    
color = cgcolor("black"), $                            
symsize = 0.7                                            

oplot, [-0.05,1.05], [-7.826,-7.826], $                
linestyle = 1, $                                         
color = cgcolor("black")                               



; position and size of lower plot
plot_left = 6                                          
plot_bottom = 9.2                                      
xsize = 10.5                                          
ysize = 2.5                                           

ploterror, phase, oc ,  err, $                       
psym = symcat(16), $                                    
position = [plot_left, plot_bottom, plot_left + $      
            xsize, plot_bottom + ysize] * 1000., $
color = cgcolor("black") ,$                            
xrange = [-0.05, 1.05], $                             
yrange = [-2.9, 2.9], $                                
symsize = 0.7, $                                    
ytitle = 'O-C (km s!E-1!N)', $                        
xtitle = 'Orbital Phase', $                           
xcharsize = 1., $                                     
ycharsize = 1., $                                      
charthick = 3, $ 
xthick = 3 , $
ythick = 3 , $
hatlenght = 100., $                                   
yminor = 1, $                                         
xticklen = 0.08 , $                                   
xstyle = 1, $                                          
ystyle = 1, $                                          
/device, $                                             
/noerase                                              

oplot, phaseg, ocg, $                                  
psym = symcat(9), $                                    
color = cgcolor("black"), $                            
symsize = 0.7                                          

oplot, [-0.05,1.05], [0.,0.], $                        
linestyle = 1, $                                        
color = cgcolor("black")                              


; close postscript file
device,/close

; create a PDF file
cgps2pdf, psname, /delete_ps 

end
; ------------------------ idl code ends here

 