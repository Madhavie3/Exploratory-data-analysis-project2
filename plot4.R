setwd("/Users/VjMadz/Desktop/DataScience/ExpDataAnalysisweek4")
#Set working directory and read the data files#
if(!exists("EMI")){
  EMI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCCODE")){
  SCCODE <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets 
if(!exists("EMISCCODE")){
  EMISCCODE <- merge(EMI, SCCODE, by="SCCODE")
}

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# fetch all EMIxSCCODE records with Short.Name (SCCODE) Coal
coalMatches  <- grepl("coal", EMISCCODE$Short.Name, ignore.case=TRUE)
subsetEMISCCODE <- EMISCCODE[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetEMISCCODE, sum)



png("plot4.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()
