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

png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power,xlab="Global_active_power (kilowatts)",col="orange")
dev.off()