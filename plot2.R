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

# Generate Plot 2
png("plot2.png", width=480, height=480, bg="transparent")
with(power2d, {
    plot(Date_Time, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
    lines(Date_Time, Global_active_power)
})
dev.off()
