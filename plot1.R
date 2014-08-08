# read data file
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# format date and filter to 2 days required
data$Date <- as.Date(data$Date, "%d/%m/%Y")
startdate <- as.Date("2007-02-01")
enddate <- as.Date("2007-02-02")
data2 <- subset(data, Date >= startdate & Date <= enddate, select=c(Date, Global_active_power))

# convert power value to numeric 
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

# output histogram to png file
png("plot1.png", width = 480, height = 480, bg="darkgray")
hist(data2$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
