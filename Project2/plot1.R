setwd("C:/RPrograms/ExploritoryData/Project2")

zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(zipfile, tf <- tempfile(fileext = ".zip"))
unzip(tf, exdir = td <- file.path(tempdir(), "myzip"))

# read csv data create datafram
NEI <- readRDS(file.path(tempdir(), "/myzip/summarySCC_PM25.rds"))
SCC <- readRDS(file.path(tempdir(), "/myzip/Source_Classification_Code.rds"))

pm25summary <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum, na.rm=TRUE)
names(pm25summary) <- c("year", "emissions")
plot(pm25summary$year,pm25summary$emissions
     , type='l'
     , xlab="Year"
     , ylab="Total Emissions (tons)"
     , main="Total Emissions by Year")
dev.copy(png, 'plot1.png')
dev.off()
