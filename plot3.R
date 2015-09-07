#This script provides the code to create plot 3 of the first course project of 
#Exploratory Data Analysis

#Clear workspace
rm(list=ls())

#Set working directory correctly
setwd("~/Data Science/Expl Data Analysis/")

#Import only the first column of the data to find out at which row the relevant data starts
classes = c("character", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL")
data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = classes)

#Find rows which contain the relevant data
to_use <- (data$Date == "1/2/2007" | data$Date == "2/2/2007")

#Specify the starting row and number of rows which contain the relevant data
begin_row <- head(which(to_use), 1)
nof_rows <- length(which(to_use))

#Specify the classes of each column
classes = c("character", "character", "numeric", "numeric", "numeric", 
            "numeric", "numeric", "numeric", "numeric")

#Read in the data and provide the correct column names
data<-read.csv("household_power_consumption.txt", sep = ";",skip = begin_row-1, 
            nrows = nof_rows, colClasses = classes,na.strings = "?")
names(data) <- names(read.csv("household_power_consumption.txt", sep = ";",
                             nrows = 1))

#Convert the date and time to a single string for plotting
date_time <- paste(data$Date, data$Time)
date_time <- strptime(date_time, format = "%d/%m/%Y %H:%M:%S")

#Create the png file
png(file = "plot3.png", width = 480, height = 480)

#Create different colored lines with correct axis title and legend
plot(date_time, data$Sub_metering_1, xlab = "", 
        ylab = "Energy sub metering", type = "n")

lines(date_time, data$Sub_metering_1, col = "black")

lines(date_time, data$Sub_metering_2, col = "red")

lines(date_time, data$Sub_metering_3, col = "blue")
legend("topright",lty=c(1,1), col = c("black", "red", "blue"),
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close the PNG device
dev.off()
