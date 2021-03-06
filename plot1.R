
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

##Build needed variable for plot1
GAP<-ds$Global_active_power
GAP<-as.numeric(levels(GAP))[GAP]

#Build Plot
hist(GAP,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")


##Create PNG File
dev.copy(png, file ="plot1.png")
dev.off()

