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

windows()
par(mfrow=c(2,2))
with(DT,plot(datehour,Global_active_power,type="l",xlab="",ylab="Global active power"))
with(DT,plot(datehour,Voltage,type="l",xlab="datetime",ylab="Voltage"))

with(DT,plot(datehour,Sub_metering_1,xlab="",ylab="Energy sub metering",type="n"))
with(DT,lines(datehour,Sub_metering_1,col="black"))
with(DT,lines(datehour,Sub_metering_2,col="red"))
with(DT,lines(datehour,Sub_metering_3,col="blue"))
with(DT,legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6,bty="n"))

with(DT,plot(datehour,Global_reactive_power,type="l",xlab="datetime",ylab="Global reactive power"))

dev.copy(png,"./H1/plot4.png") #genera archivo png con la gráfica que se genera en la pantalla
dev.off()

