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

##paste time onto date and convert to a date type
power$date <- paste(power$date, power$time)
power$date <- strptime(power$date, '%d/%m/%Y %H:%M:%S')

##make plot
png('plot3.png')

plot(power$date, power$sub_metering_1, type = 'l', col = 'black', xlab = '', ylab = 'Energy sub metering')
lines(power$date, power$sub_metering_2, col = 'red')
lines(power$date, power$sub_metering_3, col = 'blue')
legend('topright', lty = 1, col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

dev.off()
