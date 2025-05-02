library(sqldf)


#read the subset data from 1/2/2007' to '2/2/2007
df <- read.csv.sql(
  file = "household_power_consumption.txt",
  sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')",
  sep = ";"
)

#convert to Date and Time format
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
df$Time <- as.POSIXct(strptime(paste(df$Date,df$Time), format = "%Y-%m-%d %H:%M:%S"))

png("plot3.png", width = 480, height = 480)
plot(df$Time,df$Sub_metering_1,ylab="Energy sub metering",xlab="Weekdays",col="black",type = "l"
     ,xaxt = "n")
lines(df$Time, df$Sub_metering_2, type = "l", col = "red")
lines(df$Time, df$Sub_metering_3, type = "l", col = "blue")


# Create daily ticks (one per day)
daily_ticks <- seq(from = min(df$Time), to = round(max(df$Time), unit = "day"), by = "1 day")


axis(1, at = daily_ticks, labels = format(daily_ticks, "%A"))

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 1,cex = 0.7)

dev.off()