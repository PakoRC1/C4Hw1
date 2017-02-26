library(data.table)
if(!file.exists("H1"))
{
  dir.create("H1")
}

if(!file.exists("./H1/data.zip"))
{
  fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile="./H1/data.zip")
  dateDownloaded<-date() #"Sun Feb 26 13:21:31 2017"
}

data<-unz("./H1/data.zip", "household_power_consumption.txt")
data2<-data.table(read.table(data,sep=";",header=TRUE, na.strings="?",stringsAsFactors = F))
DT<-data2[data2$Date == "1/2/2007" | data2$Date == "2/2/2007"]
DT[,datehour:=strptime(paste(DT$Date,DT$Time),"%d/%m/%Y %H:%M:%S")]

with(DT,hist(Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
)
dev.copy(png,"./H1/plot1.png") #genera archivo png con la gráfica que se genera en la pantalla
dev.off()
