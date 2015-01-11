#!/usr/bin/env Rscript


# Download archive file, if it does not exists
if ( !file.exists('workdir/') ) {
	dir.create('workdir')
}

archiveFile <- "workdir/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFile <- "workdir/household_power_consumption.txt"
rdsFile <-"workdir/data.rds"


if( !file.exists(archiveFile) )
{
		archiveURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(url=archiveURL, destfile=archiveFile, method="curl");
}

if (!file.exists(dataFile))
{
		unzip(archiveFile);
}


if (!file.exists(rdsFile))
{
		# Read data into a table with appropriate classes
		power.df <- read.table(dataFile,
				header=TRUE,
				sep=';', na.strings='?',
				colClasses=c(
						rep('character', 2),
						rep('numeric', 7)
						)
		)

		# Convert dates and times
		power.df$Date <- lubridate::dmy(power.df$Date)
		power.df$Time <- lubridate::hms(power.df$Time)

		# Limit dataframe to only nessesary records
		start <- lubridate::ymd('2007-02-01')
		end <- lubridate::ymd('2007-02-02')
		power.df <- subset(power.df,
				lubridate::year(Date) == 2007 &
				lubridate::month(Date) == 2 &
				 (lubridate::day(Date) == 1 | lubridate::day(Date) == 2)
		)

		# Combine date and time in the same field
    power.df$date.time <- power.df$Date + power.df$Time

		# Save file
		saveRDS(power.df, file=rdsFile)
} else {
		power.df <- readRDS(rdsFile)
}
