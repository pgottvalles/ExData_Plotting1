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

##Build needed variable for plot4
GAP<-ds$Global_active_power
GAP<-as.numeric(levels(GAP))[GAP]

GRP<-ds$Global_reactive_power
GRP<-as.numeric(levels(GRP))[GRP]

Vltg<-ds$Voltage
Vltg<-as.numeric(levels(Vltg))[Vltg]

sm1 <- ds$Sub_metering_1
sm1<-as.numeric(levels(sm1))[sm1]

sm2 <- ds$Sub_metering_2
sm2<-as.numeric(levels(sm2))[sm2]

sm3 <- ds$Sub_metering_3

dt<-ds$datetime


#Build Plot
par(mfrow=c(2,2),mar=c(4,4,1,1))

##First Chart
plot(dt,GAP,xlab="",ylab="Global Active Power",type="n")
lines(dt,GAP)

##Second Chart
plot(dt,Vltg,xlab="datetime",ylab="Voltage",type="n")
lines(dt,Vltg)

##Third Chart
plot(dt,sm1,xlab="",ylab="Energy sub metering",type="n")
lines(dt,sm1)
lines(dt,sm2,col="red")
lines(dt,sm3,col="blue")
legend("topright",
       pch=95,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##Fourth Chart
plot(dt,GRP,xlab="datetime",ylab="Global_reactive_power",type="n")
lines(dt,GRP)



##Create PNG File
dev.copy(png, file ="plot4.png")
dev.off()