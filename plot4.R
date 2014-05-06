# Read in full table, treating the Date and Time columns as character strings
power <- read.table("household_power_consumption.txt",
                    header=TRUE,
                    sep=";",
                    na.strings="?",
                    colClasses=c("character", "character", "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

# Convert the Date string into an R date object (note switch of month and day)
power$Date_Obj <- as.Date(power$Date, "%d/%m/%Y")

# Select the two day sample before doing other transformations and graphing
power2d <- power[power$Date_Obj == "2007-02-01" | power$Date_Obj == "2007-02-02",]

# Create a DateTime column that orders all of the readings for the two day sample
power2d$Date_Time <- strptime(paste(power2d$Date, power2d$Time), "%d/%m/%Y %H:%M:%S")

# Generate Plot 4
png("plot4.png", width=480, height=480, bg="transparent")
par(mfrow=c(2, 2))
with(power2d, {
   # 1
   plot(Date_Time, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
   lines(Date_Time, Global_active_power)
   # 2
   plot(Date_Time, Voltage, type="n", ylab="Voltage", xlab="datetime")
   lines(Date_Time, Voltage)
   # 3
   plot(Date_Time, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
   lines(Date_Time, Sub_metering_1, col="black")
   lines(Date_Time, Sub_metering_2, col="red")
   lines(Date_Time, Sub_metering_3, col="blue")
   legend("topright", lty=1, bty="n",
          c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          col=c("black", "red", "blue")) 
   # 4
   plot(Date_Time, Global_reactive_power, type="n", xlab="datetime")
   lines(Date_Time, Global_reactive_power)
})
dev.off()

