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
tidyData <- subset(mergeNEISCC, fips=="24510" & type=="ON-ROAD", c("Emissions", "year", "type"))
#tidyData <- dplyr::filter(mergeNEISCC, grepl("ON-ROAD", mergeNEISCC$type))
tidyData <- aggregate(tidyData$Emissions, by=list(tidyData$year), FUN=sum, rm.na=TRUE)

names(tidyData) <- c("year", "emissions")

plot(as.numeric(tidyData$year),as.numeric(tidyData$emissions)
     , type='l'
     , xlab="Year"
     , ylab="Total Emissions (tons)"
     , main="Motor Related Emissions by Year in Baltimore")


dev.copy(png, 'plot5.png')

dev.off()
