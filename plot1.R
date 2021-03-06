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

# Generate Plot 1
png("plot1.png", width=480, height=480, bg="transparent")
hist(power2d$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
