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

# graph, make sure mfrow is set to 1,1
if (CONFIG_DEV_PNG) {
  png('plot2.png', width=480, height=480)
}

par(mfrow=c(1,1)) 
plot(data_ss$Global_active_power, type='l', xaxt='n', xlab='', ylab='Global Active Power (kilowatts)')
axis(1, at=c(0, which(data_ss$Date == '2007-02-02')[1], dim(data_ss)[1]+1), labels=c('Thu', 'Fri', 'Sat'))

if (CONFIG_DEV_PNG) {
  dev.off()
}

