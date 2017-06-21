library(dplyr)
# load the data.
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ';')

# merge date and time column.
data <- mutate(data,Date.Time=paste(data$Date,data$Time))

# select only the needed columns. 
data <- select(data,Date.Time,Global_active_power)

# convert the Date.Time variable to time data.

data$Date.Time <- strptime(data$Date.Time,"%d/%m/%Y %T")

# select date: 2007-02-01 and 2007-02-02
test<- subset(data, Date.Time >= "2007-02-01 00:00:00" & Date.Time <= "2007-02-03 00:00:00")

# make the plot
plot(test$Date.Time, as.numeric(test$Global_active_power)/500, ylab = "Global Active Power(kilowatts)", xlab = " ", type="l", xaxt = 'n')


# my plot shows the Chinese characters the week names in xaixs, so I renamed them. 
axis(1, at = c(as.numeric(min(test$Date.Time)), as.numeric(median(test$Date.Time)), as.numeric(max(test$Date.Time))), labels = c("Thu","Fri", "Sat"))

# save the plot as png file. 
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()