#! /usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

flux_cigale = np.genfromtxt('cigale_fit.txt', comments=';', 
			names = ['lambda_cigale', 'flux_cigale'])
flux_m82 = np.genfromtxt('m82_match.txt', comments=';', 
			names = ['lambda_m82', 'flux_m82'])
flux_arp = np.genfromtxt('arp220_match.txt', comments=';', 
			names = ['lambda_arp', 'flux_arp'])
flux_rr = np.genfromtxt('rr_fit.txt', comments=';', 
			names = ['lambda_rr', 'flux_rr'])
flux_data = np.genfromtxt('observed_fluxes.txt', comments=';', 
			names = ['lambda_data', 'flux_data', 'flux_error_data'])

# Create the figure and axes instances
fig, ax1 = plt.subplots(figsize=(4.7, 6.3))

# Plot the CIGALE line with a specially defined line style.
ax1.plot(flux_cigale['lambda_cigale'], flux_cigale['flux_cigale'],'r', 
		label = 'CIGALE')
line = ax1.plot(flux_m82['lambda_m82'], flux_m82['flux_m82'], 'b-.', 
		label = 'M82')
seq = [2, 4, 2, 4, 2, 4, 7, 4]
line[0].set_dashes(seq)

# Plot the other lines. Remove the flux from the legend. 
ax1.plot(flux_arp['lambda_arp'], flux_arp['flux_arp'], color='orange', 
		linestyle='-.', label = 'Arp220')
ax1.plot(flux_rr['lambda_rr'], flux_rr['flux_rr'], 'g--', 
		label = 'Rowan-Robinson')
ax1.plot(flux_data['lambda_data'], flux_data['flux_data'], 'b.', 
		label = '_nolegend_')

#Plot the error bars on the flux.
ax1.errorbar(flux_data['lambda_data'], flux_data['flux_data'], 
			yerr = flux_data['flux_error_data'])

# Limits, scale, legend, and labels.
ax1.set_xscale('log')
ax1.set_yscale('log')
ax1.set_xlim(0.2, 5500)
ax1.set_ylim(0.001, 1000)
leg = ax1.legend(fancybox=True, loc = 'upper left')
leg.draw_frame(False)
ax1.set_xlabel('Wavelength [$\mu$m]')
ax1.set_ylabel('Flux desnisty [mJy]')
