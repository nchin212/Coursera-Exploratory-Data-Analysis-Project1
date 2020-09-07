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

# Convert other variables to numeric
data_s[,3:9] <- sapply(data_s[,3:9],as.numeric)

# Create plot 1
png("plot1.png")
hist(data_s$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()
