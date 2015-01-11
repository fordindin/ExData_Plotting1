#!/usr/bin/env Rscript

source('getdata.R')

png(filename='plots/plot2.png')

plot(
		power.df$date.time,
		power.df$Global_active_power,
		ylab='Global Active Power (kilowatts)',
		xlab='',
		type='l'
		)

dev.off()
