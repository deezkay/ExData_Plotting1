# read data file
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format date and filter to 2 days required
data$Date <- as.Date(data$Date, "%d/%m/%Y")
startdate <- as.Date("2007-02-01")
enddate <- as.Date("2007-02-02")
data2 <- subset(data, Date >= startdate & Date <= enddate, 
                select=c(Date, Time, 
                         Sub_metering_1,
                         Sub_metering_2,
                         Sub_metering_3))

# combine Date and Time and convert power to numeric
data2$DT <- paste(data2$Date, data2$Time, sep = " ")
data2$DT <- strptime(data2$DT, format="%Y-%m-%d %H:%M:%S")
data2$Sub_metering_1 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_2 <- as.numeric(as.character(data2$Sub_metering_2))
data2$Sub_metering_3 <- as.numeric(as.character(data2$Sub_metering_3))

# output line graph to png file
png("plot3.png", width = 480, height = 480, bg="darkgray")
plot(data2$DT, data2$Sub_metering_1, col="black", 
     type="l", xlab="", ylab = "Energy sub metering")
points(data2$DT, data2$Sub_metering_2, col="red", type="l")
points(data2$DT, data2$Sub_metering_3, col="blue", type="l")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)
dev.off()

