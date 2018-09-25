library(ggplot2)
library(dplyr)
library(reshape2)
setwd("C:/RPrograms/ExploritoryData/Project2")

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

# read csv data create datafram
NEI <- readRDS(file.path(tempdir(), "/myzip/summarySCC_PM25.rds"))
SCC <- readRDS(file.path(tempdir(), "/myzip/Source_Classification_Code.rds"))

mergeNEISCC <- merge(NEI, SCC, by="SCC")
tidyData <- subset(mergeNEISCC, (fips=="24510" | fips=="06037") & type=="ON-ROAD", c("Emissions", "year", "type", "fips"))

#tidyData <- aggregate(tidyData$Emissions, by=list(tidyData$year), FUN=sum, rm.na=TRUE)

names(tidyData) <- c("Emissions", "Year", "Type", "City")

plot6 <- aggregate(tidyData$Emissions, by=list(tidyData$Year, tidyData$City), FUN=sum, rm.na=TRUE)
names(plot6) <- c("Emissions", "Year", "City")

plot6 <- melt(plot6, id=c("Year", "City"), measure.vars=c("Emissions"))
plot6 <- dcast(plot6, City + Year ~ variable, sum)
names(plot6) <- c("Emissions", "City", "Year")
plot6 <- plot6[order(plot6$City, plot6$Year), ]
plot6[2:8,"Change"] <- diff(plot6$Emissions)

plot6[c(1,5),4] <- 0
plot6$City <- factor(plot6$City, levels=c("06037", "24510"), labels=c("Los Angeles", "Baltimore"))
ggplot(data=plot6, aes(x=Year, y=Change/100, group=City, color=City)) + geom_line() + geom_point( size=2, shape=8, fill="black") + xlab("Year") + ylab("Change in Emissions(tons)") + ggtitle("Motor Vehicle PM2.5 Emissions Changes")

dev.copy(png, 'plot6.png')


dev.off()
