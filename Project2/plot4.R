library(ggplot2)
library(dplyr)

setwd("C:/RPrograms/ExploritoryData/Project2")

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

# read csv data create datafram
NEI <- readRDS(file.path(tempdir(), "/myzip/summarySCC_PM25.rds"))
SCC <- readRDS(file.path(tempdir(), "/myzip/Source_Classification_Code.rds"))

mergeNEISCC <- merge(NEI, SCC, by="SCC")

tidyData <- dplyr::filter(mergeNEISCC, grepl("Coal", mergeNEISCC$Short.Name))

tidyData <- aggregate(tidyData$Emissions, by=list(tidyData$year), FUN=sum)

names(tidyData) <- c("year", "emissions")

plot(tidyData$year,tidyData$emissions
     , type='l'
     , xlab="Year"
     , ylab="Total Emissions (tons)"
     , main="Coal Related Emissions by Year")
dev.copy(png, 'plot4.png')

dev.off()