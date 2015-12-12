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
    
    ## get x & y
    x <- strptime(paste(data$Date, data$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
    y <- data$Global_active_power
    
    ## Draw the histogram
    plot(x, y, ylab='Global Active Power (kilowatts)', xlab='', type='l')
    
    ## Save to png file
    dev.copy(png, file="plot2.png", height=480, width=480)
    dev.off()
}