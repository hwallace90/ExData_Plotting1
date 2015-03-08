url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url, 'power.zip', mode ='wb')

unzip('power.zip')

power_full <- read.table('household_power_consumption.txt', header=TRUE, sep = ';', na.strings = '?')

##make names lowercase
names(power_full) <- tolower(names(power_full))

library(dplyr)

##select subset of dates we need
##d/m/yyyy
power <- filter(power_full, date == '1/2/2007' | date == '2/2/2007')

##make columns numeric
power[,3:9] <- sapply(power[,3:9], as.numeric)

##make plot
png(filename = 'plot1.png')

hist(power$global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')

dev.off()
