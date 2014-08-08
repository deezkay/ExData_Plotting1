# read data file
# assumes data file has been download and stored in working directory
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format date and filter to 2 days required
data$Date <- as.Date(data$Date, "%d/%m/%Y")
startdate <- as.Date("2007-02-01")
enddate <- as.Date("2007-02-02")
data2 <- subset(data, Date >= startdate & Date <= enddate, 
                select=c(Date, Time,
                         Global_active_power,
                         Global_reactive_power,
                         Voltage,
                         Sub_metering_1,
                         Sub_metering_2,
                         Sub_metering_3))

# combine Date and Time and convert values to numeric
data2$DT <- paste(data2$Date, data2$Time, sep = " ")
data2$DT <- strptime(data2$DT, format="%Y-%m-%d %H:%M:%S")
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
data2$Global_reactive_power <- as.numeric(as.character(data2$Global_reactive_power))
data2$Voltage <- as.numeric(as.character(data2$Voltage))
data2$Sub_metering_1 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_2 <- as.numeric(as.character(data2$Sub_metering_2))
data2$Sub_metering_3 <- as.numeric(as.character(data2$Sub_metering_3))

# output graphs to png file
png("plot4.png", width = 480, height = 480, bg="darkgray")

# output 4 graphs in 2x2 configuration
par(mfrow = c(2,2))

# output Global_active_power graph
plot(data2$DT, data2$Global_active_power, type="l", 
     xlab="", ylab = "Global Active Power")

# output Voltage graph
plot(data2$DT, data2$Voltage, type="l", 
     xlab="datetime", ylab = "Voltage")

# output Energy sub metering graph
plot(data2$DT, data2$Sub_metering_1, col="black", 
     type="l", xlab="", ylab = "Energy sub metering")
points(data2$DT, data2$Sub_metering_2, col="red", type="l")
points(data2$DT, data2$Sub_metering_3, col="blue", type="l")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1, bty = "n")

# output Global_reactive_power graph
plot(data2$DT, data2$Global_reactive_power, type="l", 
     xlab="datetime", ylab = "Global_reactive_power")

# close png file
dev.off()

