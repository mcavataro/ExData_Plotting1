#Needs lubridate library
library(lubridate)

#dowload the file necessary to the rest of the code
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip("./data/Dataset.zip")

#read in the data
pwr <- read.table("./household_power_consumption.txt",header = TRUE,sep=";")
pwr$DateTime <- paste(pwr$Date,pwr$Time)
pwr$DateTime <- dmy_hms(pwr$DateTime)
pwr$Date <- as.Date(pwr$Date,format="%d/%m/%Y")
pwr$Time <- strptime(pwr$Time,"%H:%M:%S")
pwr$Global_active_power <- as.numeric(as.character(pwr$Global_active_power))
pwr$Sub_metering_1 <- as.numeric(as.character(pwr$Sub_metering_1))
pwr$Sub_metering_2 <- as.numeric(as.character(pwr$Sub_metering_2))

#subset on the two days we want to focus on
focus <- subset(pwr,Date >= "2007-02-01" & Date <= "2007-02-02")# & Global_active_power != "?")

#open png device, create histogram, turn off png device
png(file="./plot3.png",width=480,height=480,units="px")
with(focus,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
with(focus,lines(DateTime,Sub_metering_1))
with(focus,lines(DateTime,Sub_metering_2,col="red"))
with(focus,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)
dev.off()

