# Load file into directory
if (!file.exists("household_power_consumption.txt")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,destfile = "./household_power_consumption.zip", method = "curl")
    
    zipF<- "./household_power_consumption.zip"
    unzip(zipF)
    file.remove(zipF)
}

# Read in the data and subset required dates
data <- read.table("household_power_consumption.txt", sep=";",header=TRUE, na.strings = "?")
data_s <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

# Combine date and time and convert it into a datetime object
data_s$DateTime <- strptime(paste(data_s$Date, data_s$Time), "%d/%m/%Y %H:%M:%S")

# Convert other variables to numeric
data_s[,3:9] <- sapply(data_s[,3:9],as.numeric)

# Create plot 4
png("plot4.png")
par(mfrow = c(2,2))
plot(data_s$DateTime, data_s$Global_active_power, type='l', xlab ="", ylab="Global Active Power")

plot(data_s$DateTime, data_s$Voltage, type ='l', xlab ="datetime", ylab="Voltage")

plot(data_s$DateTime, data_s$Sub_metering_1, col='black', type='l', xlab="", ylab="Energy sub metering")
lines(data_s$DateTime, data_s$Sub_metering_2, col='red')
lines(data_s$DateTime, data_s$Sub_metering_3, col='blue')
legend("topright" ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1), bty='n')

plot(data_s$DateTime, data_s$Global_reactive_power, type='l', xlab ="datetime", ylab="Global_reactive_power")
dev.off()

