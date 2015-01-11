#!/usr/bin/env Rscript

source('getdata.R')

png(filename='plots/plot1.png')

hist(
		power.df$Global_active_power,
		main='Global Active Power',
		xlab='Global Active Power (kilowatts)',
		col='red'
		)

dev.off()
