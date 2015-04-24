
# Extracting data
NEI <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/Source_Classification_Code.rds")

#Subsetting data for Baltimore County
dataset5<-subset(NEI,NEI$fips=="24510")

#Aggregating on Year and Sourceid level
dataset5<-aggregate(dataset5$Emissions,list(year=dataset5$year,scc=dataset5$SCC),sum)

#Merging Emissions(dataset5) and source(scc) dataset
dataset5 <- merge(dataset5,SCC,by.x="scc",by.y="SCC")

#Subsetting data to sources related to motor vehicules
dataset5<-dataset5[grep("Mobile - ",dataset5$EI.Sector),]

#Aggregating on yearly level
dataset5<-aggregate(dataset5$x,list(year=dataset5$year),sum)

#Renaming the columns
colnames(dataset5)<-c("Year","PM2.5")


#Creating the chart
png(filename="Exploratory_Data_Analysis/Project2/plot5.png",width=480,height=480)
g<-ggplot(dataset5,aes(Year,PM2.5))
g+geom_line() + labs(title = "Sum(PM25) from Motor Vehicule per year for Baltimore")
dev.off()