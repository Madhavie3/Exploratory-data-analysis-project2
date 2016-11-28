setwd("/Users/VjMadz/Desktop/DataScience/ExpDataAnalysisweek4")
#Set working directory and read the data files#
if(!exists("EMI")){
  EMI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCCODE")){
  SCCODE <- readRDS("./data/Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Used the base plotting system to make a plot answering this question.

subsetEMI  <- EMI[EMI$fips=="24510", ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetEMI, sum)

png('plot2.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.off()

