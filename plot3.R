
##Extracting data into dataset
dataset<- read.table("Exploratory_Data_Analysis/household_power_consumption.txt",header=TRUE, sep=";")

##Create datetime variable
dataset[,1] <- as.Date(dataset[,1],"%d/%m/%Y")
dataset$datetime<-strptime(paste(dataset$Date,dataset$Time),"%Y-%m-%d %H:%M:%S")

##Restrict data to '2007-02-01' and '2007-02-02'
library(lubridate)
ds <- subset(dataset,year(dataset$datetime)==2007 & month(dataset$datetime)==2)
ds <- subset(ds,day(ds$datetime)==1 | day(ds$datetime)==2)

##Remove dataset to release memory
rm(dataset)

##Remove Non measured data
ds <- subset(ds,!Global_active_power=="?")

##Build needed variable for plot3
sm1 <- ds$Sub_metering_1
sm1<-as.numeric(levels(sm1))[sm1]

sm2 <- ds$Sub_metering_2
sm2<-as.numeric(levels(sm2))[sm2]

sm3 <- ds$Sub_metering_3

dt<-ds$datetime

#Build Plot
plot(dt,sm1,xlab="",ylab="Energy sub metering",type="n")
lines(dt,sm1)
lines(dt,sm2,col="red")
lines(dt,sm3,col="blue")
legend("topright",
       pch=95,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##Create PNG File
dev.copy(png, file ="plot3.png")
dev.off()



