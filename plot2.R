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

# Combine date and time and change it to a datetime object
data_s$DateTime <- strptime(paste(data_s$Date, data_s$Time), "%d/%m/%Y %H:%M:%S")

# Convert other variables to numeric
data_s[,3:9] <- sapply(data_s[,3:9],as.numeric)

# Create plot 2
png("plot2.png")
plot(data_s$DateTime, data_s$Global_active_power, type ='l', xlab="", ylab="Global Active Power (kilowatts)")
dev.off()