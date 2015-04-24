
# Extracting data
NEI <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/Source_Classification_Code.rds")


#Aggregating on Yearly level
dataset <- aggregate(NEI$Emissions,list(year=NEI$year),sum)



#Creating chart
png(filename="Exploratory_Data_Analysis/Project2/plot1.png",width=480,height=480)
barplot(t(as.matrix(dataset)),names.arg=dataset[,1],main="Total Sum of PM25 per Year",xlab="year",ylab="PM25")
dev.off()