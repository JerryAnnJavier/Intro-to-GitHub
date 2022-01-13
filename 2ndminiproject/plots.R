#2
getwd()

#read the text file with the followig colclasses
info <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# change the format of the date
info$Date <- as.Date(info$Date, "%d/%m/%Y")

# Filter data set from Feb. 1, 2007 to Feb. 2, 2007
info <- subset(info,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove incomplete data
info <- info[complete.cases(info),]

# Combine Date and Time column
date_Time <- paste(info$Date, info$Time)

date_Time <- setNames(date_Time, "dateTime")

# Remove Date and Time column
info <- info[ ,!(names(info) %in% c("Date","Time"))]

# Add date_Time column
info <- cbind(date_Time, info)

# Format date_Time Column
info$dateTime <- as.POSIXct(date_Time)

#plot1

hist(info$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

#Plot 2
plot(info$Global_active_power~info$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#plot 3
with(info, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),cex =0.5, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(info, {
  plot(info$Global_active_power~info$dateTime, type="l", ylab="Global Active Power", xlab="")
  
  plot(Voltage ~ dateTime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ dateTime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ dateTime, col = 'Red')
  lines(Sub_metering_3 ~ dateTime, col = 'Blue')
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),cex = 0.3, 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power ~ dateTime, type = "l", 
       ylab = "Global_reactive_power", xlab = "datetime")
})
