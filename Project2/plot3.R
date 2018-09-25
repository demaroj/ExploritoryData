library(ggplot2)

setwd("C:/RPrograms/ExploritoryData/Project2")

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

# read csv data create datafram
NEI <- readRDS(file.path(tempdir(), "/myzip/summarySCC_PM25.rds"))
SCC <- readRDS(file.path(tempdir(), "/myzip/Source_Classification_Code.rds"))

pm25summaryin24510 <- subset(NEI, NEI$fips=='24510')
pm25summaryin24510a <- aggregate(as.numeric(as.character(NEI$Emissions)), by=list(NEI$type, NEI$year), FUN=sum, na.rm=TRUE)
names(pm25summaryin24510a) <- c("type", "year", "emissions")

qplot(pm25summaryin24510a$year, pm25summaryin24510a$emissions, pm25summaryin24510a, geom="line")

ggplot(pm25summaryin24510a, aes(pm25summaryin24510a$year, pm25summaryin24510a$emissions, type, color=type)) + geom_line() + ggtitle("Baltimore Emissions by Year by Emission Type") + xlab("Year") + ylab("Emission (tons)") + scale_fill_discrete("Types") + geom_point(size=2,shape=21,fill="black")

ggsave("plot3.png")
