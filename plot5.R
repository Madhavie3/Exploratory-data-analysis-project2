setwd("/Users/VjMadz/Desktop/DataScience/ExpDataAnalysisweek4")
#Set working directory and read the data files#
if(!exists("EMI")){
  EMI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCCODE")){
  SCCODE <- readRDS("Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("EMISCCODE")){
  EMISCCODE <- merge(EMI, SCCODE, by="SCCODE")
}

library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in EMI
# searching for 'motor'gave a subset (non-cars)- please provide feedback if this is correct.
subsetEMI <- EMI[EMI$fips=="24510" & EMI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetEMI, sum)



png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()
