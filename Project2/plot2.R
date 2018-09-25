setwd("C:/RPrograms/ExploritoryData/Project2")

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

# read csv data create datafram
NEI <- readRDS(file.path(tempdir(), "/myzip/summarySCC_PM25.rds"))
SCC <- readRDS(file.path(tempdir(), "/myzip/Source_Classification_Code.rds"))

pm25summaryin24510 <- subset(NEI, NEI$fips=='24510')
pm25summaryin24510 <- aggregate(pm25summaryin24510$Emissions, by=list(pm25summaryin24510$year), FUN=sum, na.rm=TRUE)
names(pm25summaryin24510) <- c("year", "emissions")

plot(pm25summaryin24510$year,pm25summaryin24510$emissions
     , type='l'
     , xlab="Year"
     , ylab="Total Emissions (tons)"
     , main="Total Emissions by Year for Baltimore City")


dev.copy(png, 'plot2.png')

dev.off()

