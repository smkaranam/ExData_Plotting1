# Exploratory Data Analysis Assignment 1
# Dataset from UC Irvine Machine Learning Repository
# Dataset name - Electtic Power Consumption
# Dataset download URL - https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Dataset Desctiption - Measurements of electric power consumption in one household with a one-minute 
#			sampling rate over a period of almost 4 years. Different electrical quantities 
#			and some sub-metering values are available.
# Descriptions of variables in the dataset ( as taken from website)
#	Date: Date in format dd/mm/yyyy
#	Time: time in format hh:mm:ss
#	Global_active_power: household global minute-averaged active power (in kilowatt)
#	Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#	Voltage: minute-averaged voltage (in volt)
#	Global_intensity: household global minute-averaged current intensity (in ampere)
#	Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an #	oven and a microwave (hot plates are not electric but gas powered).
#	Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, #	tumble-drier, a refrigerator and a light.
#	Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

#Objective - The goal is to examine how household energy usage varies over a 2-day period in February, 2007 by reproducing a series of four plots. 
#		The plots are to be produced as per the specific image requirements as per the assignment.


# DATA DOWNLOADING AND PROCESSING
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
power <- read.csv(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
dataframe <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
dataframe$Global_active_power <- as.numeric(as.character(dataframe$Global_active_power))
dataframe$Global_reactive_power <- as.numeric(as.character(dataframe$Global_reactive_power))
dataframe$Voltage <- as.numeric(as.character(dataframe$Voltage))
dataframe <- transform(dataframe, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
dataframe$Sub_metering_1 <- as.numeric(as.character(dataframe$Sub_metering_1))
dataframe$Sub_metering_2 <- as.numeric(as.character(dataframe$Sub_metering_2))
dataframe$Sub_metering_3 <- as.numeric(as.character(dataframe$Sub_metering_3))


# CREATE PLOT 4

plot4 <- function() {
        par(mfrow=c(2,2))
        
        ##PLOT 1
        plot(dataframe$timestamp,dataframe$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        ##PLOT 2
        plot(dataframe$timestamp,dataframe$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ##PLOT 3
        plot(dataframe$timestamp,dataframe$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(dataframe$timestamp,dataframe$Sub_metering_2,col="red")
        lines(dataframe$timestamp,dataframe$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        
        #PLOT 4
        plot(dataframe$timestamp,dataframe$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        #OUTPUT
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()

