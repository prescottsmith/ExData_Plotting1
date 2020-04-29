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

#Create plot 3

png(filename = "plot3.png",width = 480,height = 480)

par(bg = "transparent")

with(datanew, plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="n"))
lines(datanew$datetime, datanew$Sub_metering_1)
lines(datanew$datetime, datanew$Sub_metering_2, col = "red")
lines(datanew$datetime, datanew$Sub_metering_3, col = "blue")

legend("topright",lty=c(1,1,1),col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()
