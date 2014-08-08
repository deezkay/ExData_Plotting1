# read data file
# assumes data file has been download and stored in working directory
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format date and filter to 2 days required
data$Date <- as.Date(data$Date, "%d/%m/%Y")
startdate <- as.Date("2007-02-01")
enddate <- as.Date("2007-02-02")
data2 <- subset(data, Date >= startdate & Date <= enddate, select=c(Date, Time, 
                                                                    Global_active_power))

# combine Date and Time and convert power to numeric
data2$DT <- paste(data2$Date, data2$Time, sep = " ")
data2$DT <- strptime(data2$DT, format="%Y-%m-%d %H:%M:%S")
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

# output line graph to png file
png("plot2.png", width = 480, height = 480, bg="darkgray")
plot(data2$DT, data2$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()
