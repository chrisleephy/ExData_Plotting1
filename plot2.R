library(sqldf)
library(lubridate)

#read the subset data from 1/2/2007' to '2/2/2007
df <- read.csv.sql(
  file = "household_power_consumption.txt",
  sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')",
  sep = ";"
)

#convert to Date and Time format
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
df$Time <- as.POSIXct(strptime(paste(df$Date,df$Time), format = "%Y-%m-%d %H:%M:%S"))

png("plot2.png", width = 480, height = 480)
plot(df$Time,df$Global_active_power,ylab="Global active power (kilowatts)",xlab="Weekdays",col="black",type = "l"
     ,xaxt = "n")

# Create daily ticks (one per day)
daily_ticks <- seq(from = min(df$Time), to = round(max(df$Time), unit = "day"), by = "1 day")

# Add custom x-axis with day names
axis(1, at = daily_ticks, labels = format(daily_ticks, "%A"))

dev.off()
