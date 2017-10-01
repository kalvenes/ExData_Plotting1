## This script will replicate plot1.png in the first project assignment in the
## Exploratory Data Analysis course.
##
## Model data come from the UCI Machine Learning repository. A complete
## description of the model data can be found at the UCI website:
##
## https://archive.ics.uci.edu/ml/datasets/individual+household+electric+power+consumption
##
##
## The data for this project were downloaded from the course repository at:
##
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##
## The data were unzipped and stored in the root directory of the project Git
## repository. The R script assumes that the data will reside there and the
## plot created will be stored there as well.
##
## The following is the variable description copied from the UCI site:
##
## 1.date: Date in format dd/mm/yyyy 
## 2.time: time in format hh:mm:ss 
## 3.global_active_power: household global minute-averaged active power
##   (in kilowatt) 
## 4.global_reactive_power: household global minute-averaged reactive power
##   (in kilowatt) 
## 5.voltage: minute-averaged voltage (in volt) 
## 6.global_intensity: household global minute-averaged current intensity
##   (in ampere) 
## 7.sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy).
##   It corresponds to the kitchen, containing mainly a dishwasher, an oven and
##   a microwave (hot plates are not electric but gas powered). 
## 8.sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy).
##   It corresponds to the laundry room, containing a washing-machine, a
##   tumble-drier, a refrigerator and a light. 
## 9.sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy).
##   It corresponds to an electric water-heater and an air-conditioner.
##
## Read libraries for data manipulation

library(dplyr)
library(tidyr)

work <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";",
                 colClasses = "character")

## Pull together Date and Time data and replace Date with POSIXlt date and
## time (borrowed from stackoverflow.com):
## https://stackoverflow.com/questions/24105984/combining-date-and-time-into-a-date-column-for-plotting
##
## Then drop Time column

work$Date <- with(work, as.POSIXlt(paste(Date, Time),
                                      format="%d/%m/%Y %H:%M:%S"))
work <- subset(work, select = -Time)

## Next, get rid of observations from all dates except 2007-02-01 to 2007-02-02

powerFeb <- subset(work, as.Date(Date) == "2007-02-01" |
                         as.Date(Date) == "2007-02-02")

## Drop all other data

rm (work)

## Open graphics device of type PNG: 480 by 480 pixels, white background

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

## Create line graph of sub-metering for the entire date range, using
## black, red,and blue lines and labeling y-axis only, leaving the title blank,
## and providing a legend in the top right corner

plot(powerFeb$Date, type = "l",
     as.numeric(powerFeb$Sub_metering_1), col = "black",
     main = "", xlab = "", ylab = "Energy sub metering")
lines(powerFeb$Date,
     as.numeric(powerFeb$Sub_metering_2), col = "red")
lines(powerFeb$Date,
      as.numeric(powerFeb$Sub_metering_3), col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c('black','red','blue'))

dev.off()