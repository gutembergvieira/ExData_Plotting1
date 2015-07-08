# config device, TRUE for png and FALSE for default
CONFIG_DEV_PNG = TRUE

# check if the data exists and download if necessary
if (!file.exists('household_power_consumption.zip')) {
  download.file('http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                'household_power_consumption.zip')
}

# read data
data <- read.csv(unz('household_power_consumption.zip', 'household_power_consumption.txt'), sep=';', na.strings = "?", 
                 colClasses=c('character', 'character', 'numeric', 'numeric', 'numeric',
                              'numeric', 'numeric', 'numeric', 'numeric'))

# subset to get only desired data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data_ss <- subset(data, Date=='2007-02-01' | Date=='2007-02-02')


# clear memory
rm(data)

# graph
if (CONFIG_DEV_PNG) {
  png('plot4.png', width=480, height=480)
}
par(mfrow=c(2,2))

# graph 1
plot(data_ss$Global_active_power, type='l', xaxt='n', xlab='', ylab='Global Active Power')
axis(1, at=c(0, which(data_ss$Date == '2007-02-02')[1], dim(data_ss)[1]+1), labels=c('Thu', 'Fri', 'Sat'))

# graph 2
plot(data_ss$Voltage, type='l', xaxt='n', xlab='datetime', ylab='Voltage')
axis(1, at=c(0, which(data_ss$Date == '2007-02-02')[1], dim(data_ss)[1]+1), labels=c('Thu', 'Fri', 'Sat'))

# graph 3
plot(data_ss$Sub_metering_1, type='l', xaxt='n', xlab='', ylab='Energy sub metering')
lines(data_ss$Sub_metering_2, col='red' )
lines(data_ss$Sub_metering_3, col='blue' )
axis(1, at=c(0, which(data_ss$Date == '2007-02-02')[1], dim(data_ss)[1]+1), labels=c('Thu', 'Fri', 'Sat'))
legend('topright', col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 
      'Sub_metering_2', 'Sub_metering_3'), lty=1, bty='n')

# graph 4
plot(data_ss$Global_reactive_power, type='l', xaxt='n', xlab='datetime', ylab='Global_reactive_power')
axis(1, at=c(0, which(data_ss$Date == '2007-02-02')[1], dim(data_ss)[1]+1), labels=c('Thu', 'Fri', 'Sat'))

if (CONFIG_DEV_PNG) {
  dev.off()
}
