
# Extracting data
NEI <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/Source_Classification_Code.rds")


#Aggregating on Year and scc(sourceid) level
dataset4<-aggregate(NEI$Emissions,list(year=NEI$year,scc=NEI$SCC),sum)

#Merging NEI and SCC dataframe
dataset4 <- merge(dataset4,SCC,by.x="scc",by.y="SCC")


#Subsetting data to sources related to Coal Combustion
dataset4<-dataset4[grep("Coal",dataset4$Short.Name),]
dataset4<-dataset4[grep("Comb",dataset4$Short.Name),]

#Aggregating on Yearly level
dataset4<-aggregate(dataset4$x,list(year=dataset4$year),sum)


#Creating chart
png(filename="Exploratory_Data_Analysis/Project2/plot4.png",width=480,height=480)
barplot(t(as.matrix(dataset4)),
        names.arg=dataset4[,1],
        main="Sum(PM25) for Coal combustion related source per Year",
        xlab="year",
        ylab="PM25")
dev.off()