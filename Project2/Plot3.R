
# Extracting data
NEI <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/summarySCC_PM25.rds")
# SCC <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/Source_Classification_Code.rds")

# Subsetting data only for Baltimore County
dataset3<-subset(NEI,NEI$fips=="24510")


#Aggregating data on Year and Type level
dataset3<-aggregate(dataset3$Emissions,list(year=dataset3$year,type=dataset3$type),sum)

#setting Type as factor
dataset3<-transform(dataset3,Type=factor(type))

#renaming columns (after aggregation)
colnames(dataset3)<-c("year","Type","PM2.5")

#Creating chart
library(ggplot2)

png(filename="Exploratory_Data_Analysis/Project2/plot3.png",width=480,height=480)
g<-ggplot(dataset3,aes(year,PM2.5))
g+geom_line(aes(color=type)) + labs(title = "Baltimore PM2.5 per type over type over the years")
dev.off()