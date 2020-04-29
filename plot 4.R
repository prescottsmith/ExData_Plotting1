#prepare data
setwd("~/Documents/Coursera Data Science JH/C4/W1/ExData_Plotting1")

library(lubridate)

path<-getwd()

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,file.path(path,"exdata_data_household_power_consumption.zip"))
unzip(zipfile = "exdata_data_household_power_consumption.zip")

data <- read.delim("household_power_consumption.txt", sep=";")

data$Time <- as.character(data$Time)
data$Date <- as.character(data$Date)
data$datetime <- dmy(data$Date)
data$datetime <- paste(data$datetime,data$Time)
data$datetime <- ymd_hms(data$datetime)

data$datetime <- as.POSIXlt(data$datetime)

data$Date <- dmy(data$Date)

data0201 <- subset(data, Date == "2007-02-01")
data0202 <- subset(data, Date == "2007-02-02")

datanew <- rbind(data0201, data0202)

datanew$Sub_metering_1 <- as.character(datanew$Sub_metering_1)
datanew$Sub_metering_1 <- as.numeric(datanew$Sub_metering_1)

datanew$Sub_metering_2 <- as.character(datanew$Sub_metering_2)
datanew$Sub_metering_2 <- as.numeric(datanew$Sub_metering_2)

datanew$Sub_metering_3 <- as.character(datanew$Sub_metering_3)
datanew$Sub_metering_3 <- as.numeric(datanew$Sub_metering_3)

datanew$Global_active_power <- as.character(datanew$Global_active_power)
datanew$Global_active_power <- as.numeric(datanew$Global_active_power)

datanew$Global_reactive_power <- as.character(datanew$Global_reactive_power)
datanew$Global_reactive_power <- as.numeric(datanew$Global_reactive_power)

datanew$Voltage <- as.character(datanew$Voltage)
datanew$Voltage <- as.numeric(datanew$Voltage)


#create plot 4

png(filename = "plot4.png",width = 480,height = 480)

par(mfrow = c(2,2))
par(mar = c(4,4,4,2))
par(bg = "transparent")
par(oma=c(1,0,0,0))


#1
with(datanew, plot(datetime, Global_active_power, ylab="Global Active Power", xlab="", type="n", cex.lab=.9, cex.axis=.9))
lines(datanew$datetime, datanew$Global_active_power)

#2
with(datanew, plot(datetime, Voltage, ylab="Voltage", xlab="datetime", type="n", cex.lab=1, cex.axis=1))
lines(datanew$datetime, datanew$Voltage)

#3
with(datanew, plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n", cex.lab=1, cex.axis=1))
lines(datanew$datetime, datanew$Sub_metering_1)
lines(datanew$datetime, datanew$Sub_metering_2, col = "red")
lines(datanew$datetime, datanew$Sub_metering_3, col = "blue")

legend("topright",lty=c(1,1,1),col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n",  cex=1)

#4
with(datanew, plot(datetime, Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="n", cex.lab=1, cex.axis=1))
lines(datanew$datetime, datanew$Global_reactive_power)


dev.off()

