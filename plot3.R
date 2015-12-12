## This is the file we need to download
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## This is the downloaded zip file
zipFile <- 'exdata-data-household_power_consumption.zip'

## This is the extracted data file
dataFile <- 'household_power_consumption.txt'

## Have we downloaded the file?
if (!file.exists(zipFile)) {
    download.file(url, destfile=zipFile)
}

## Have we extracted the file?
if (!file.exists(dataFile)) {
  unzip(zipFile, files=dataFile)
}

## Make sure we have the file
if (file.exists(dataFile)) {
  
    ## Read in the table
    allData <- read.table(dataFile, header=TRUE, sep=";",colClasses=c("character","character","double","double","double","double","double","double","double"),na.strings="?")

    ## Format Date
    allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")
    
    ## Subsetting the data
    data <- subset(allData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

    ## Don't need the big dataset anymore
    rm(allData)
    
    ## Set up data
    x <- strptime(paste(data$Date, data$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
    y1 <- data$Sub_metering_1
    y2 <- data$Sub_metering_2
    y3 <- data$Sub_metering_3
    
    ## Open png file
    png("plot3.png", width = 480, height = 480)
    
    ## Stops the legend being truncated
    par(mar=c(6, 4, 4, 2) + 0.1)
    
    ## Plot graph
    plot(x,y1, type="l", ylab="Energy sub metering", xlab="")
    lines(x,y2,col='Red')
    lines(x,y3,col='Blue')

    ## Add Legend
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    ## Save to png file
    dev.off()
}