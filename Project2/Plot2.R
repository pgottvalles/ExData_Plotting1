
# Extracting data
NEI <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/Source_Classification_Code.rds")


# Subsetting data only for Blatimore County
dataset2<-subset(NEI,NEI$fips=="24510")

#Aggregating on Yearly Level
dataset2<-aggregate(dataset2$Emissions,list(year=dataset2$year),sum)

#Creating chart
png(filename="Exploratory_Data_Analysis/Project2/plot2.png",width=480,height=480)
barplot(t(as.matrix(dataset2)),
        names.arg=dataset2[,1],
        main="PM25 per Year for Baltimore",
        xlab="year",
        ylab="PM25")
dev.off()