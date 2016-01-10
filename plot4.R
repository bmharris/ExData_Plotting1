## This file contains the script for building plot 1

#load the lubridate package to allow for easy manipulation of dates and times
library(lubridate)  

#download and unzip data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "project_data.zip")
unzip("project_data.zip")

#Read data into a data frame and create a date_time field
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
data$date_time <- dmy_hms(paste(data$Date, data$Time))

#Subset the data for the two days used in the graphs, and do some basic cleaning
#Specifically changes the fields in the subset to numeric instead of factor
project_data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
project_data$Global_active_power <- as.numeric(as.character(project_data$Global_active_power))
project_data$Sub_metering_1 <- as.numeric(as.character(project_data$Sub_metering_1))
project_data$Sub_metering_2 <- as.numeric(as.character(project_data$Sub_metering_2))
project_data$Sub_metering_3 <- as.numeric(as.character(project_data$Sub_metering_3))
project_data$Voltage <- as.numeric(as.character(project_data$Voltage))
project_data$Global_reactive_power <- as.numeric(as.character(project_data$Global_reactive_power))

# build plot 4
png("plot4.png", w = 480, h = 480)
par(mfrow = c(2,2))
with(project_data, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
with(project_data, plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
with(project_data, plot(date_time,Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = ""))
with(project_data, lines(date_time,Sub_metering_2, type = "l", col = "red" ))
with(project_data, lines(date_time,Sub_metering_3, type = "l", col = "blue" ))
legend("topright", border = "white", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
with(project_data, plot(date_time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = ""))
dev.off()