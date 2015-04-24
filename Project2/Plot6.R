
# Extracting data
NEI <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("Exploratory_Data_Analysis/exdata_data_NEI_data/Source_Classification_Code.rds")

#Subsetting data for Baltimore and Los Angeles Counties
dataset6<-subset(NEI,NEI$fips %in% c("24510","06037"))

#Aggregating on Year,county_id and sourceid level
dataset6<-aggregate(dataset6$Emissions,
                    list(year=dataset6$year,
                         County_id=dataset6$fips,
                         scc=dataset6$SCC)
                    ,sum)

#Merging emission(dataset6) and source(scc) datasets
dataset6 <- merge(dataset6,SCC,by.x="scc",by.y="SCC")


#Subsetting data to sources related to motor vehicules
dataset6<-dataset6[grep("Mobile - ",dataset6$EI.Sector),]

#Aggregate on year and County Level
dataset6<-aggregate(dataset6$x,list(year=dataset6$year,County_id=dataset6$County_id),sum)

#Creating County dimension
dim_county<-t(as.matrix(rbind(c("Los Angeles","Baltimore"),unique(dataset6$County))))

#Merging aggregated data with county dimesnion
dataset6<-merge(dataset6,dim_county,by.x="County_id",by.y="County_id")

#subsetting data to keep County, Year, emission (getting rid if county_id)
dataset6<-dataset6[,c(4,2,3)]

#Renaming columns
colnames(dataset6)<-c("County","Year","PM2.5")

#Creating chart
library(ggplot2)
png(filename="Exploratory_Data_Analysis/Project2/plot6.png",width=480,height=480)
g<-ggplot(dataset6,aes(Year,PM2.5))
g+geom_line(aes(color=County)) + labs(title = "Sum(PM25) from Motor Vehicule per year - Baltimore vs Los Angeles")
dev.off()