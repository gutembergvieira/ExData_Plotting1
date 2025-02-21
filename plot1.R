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
  png('plot1.png', width=480, height=480)
}
par(mfrow=c(1,1)) 
hist(data_ss$Global_active_power, col='red', main='Global Active Power', 
     xlab='Global Active Power (kilowatts)')
if (CONFIG_DEV_PNG) {
  dev.off()
}
