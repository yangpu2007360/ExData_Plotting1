library(dplyr)

# load the data
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';')

# Merge Data and Time variable
data <- mutate(data,Date.Time=paste(data$Date,data$Time))


# convert Date.Time as time data
data$Date.Time <- strptime(data$Date.Time,"%d/%m/%Y %T")

# filter the data and keep only data for 2007-02-01 and 2007-02-02
test<- subset(data, Date.Time >= "2007-02-01 00:00:00" & Date.Time <= "2007-02-03 00:00:00")

par(mfrow = c(2,2), mar=c(4,4,2,1), oma = c(0,0,2,0))

#plot1
with(test, plot(Date.Time, as.numeric(Global_active_power)/500, ylab = "Global Active Power(kilowatts)", xlab = " ", type="l", xaxt = 'n'))

axis(1, at = c(as.numeric(min(test$Date.Time)), as.numeric(median(test$Date.Time)), as.numeric(max(test$Date.Time))), 
     labels = c("Thu","Fri", "Sat"))

#plot2

with(test, plot(Date.Time, as.numeric(as.character(Voltage)), ylab = "Voltage", xlab = "datetime", type="l", xaxt = 'n'))

axis(1, at = c(as.numeric(min(test$Date.Time)), as.numeric(median(test$Date.Time)), as.numeric(max(test$Date.Time))), 
     labels = c("Thu","Fri", "Sat"))

#plot3

with(test, plot(Date.Time, Sub_metering_1, type = "n", xaxt = 'n', ylab = "Engergy Sub Metering", xlab = "")) 
with(test, points(Date.Time, Sub_metering_1, type = "l"))
with(test, points(Date.Time, Sub_metering_2, type = "l", col="red"))
with(test, points(Date.Time, Sub_metering_3, type = "l", col="blue"))

legend("topright", lty =1, cex = 0.3, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, at = c(as.numeric(min(test$Date.Time)), as.numeric(median(test$Date.Time)), as.numeric(max(test$Date.Time))), labels = c("Thu","Fri", "Sat"))

#plot4
with(test, plot(Date.Time, as.numeric(Global_reactive_power)/500, ylab = "Global_reactive_power", xlab = "datetime", type="l", xaxt = 'n'))
axis(1, at = c(as.numeric(min(test$Date.Time)), as.numeric(median(test$Date.Time)), as.numeric(max(test$Date.Time))), labels = c("Thu","Fri", "Sat"))
dev.copy(png, file = "plot4.png", width= 480, height=480)
dev.off()

