# Extraction of the data is tha same that the first plot
# Download data from the provided link by first checking if it has not been already downloaded

if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
  unzip("data.zip")
}

datos<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

lapply(datos, class)  


#Changinging Date and Time to appropriate format and class

datos$DateTime<-paste(datos$Date, datos$Time)


datos$DateTime[1:10]
class(datos$DateTime)

#Let's use strptime to change DateTime to its appropriate format

datos$DateTime<-strptime(datos$DateTime, "%d/%m/%Y %H:%M:%S")

# Since we are  working with dates 2007-02-01 and 2007-02-02, let's extract the 
# corresponding values

start<-which(datos$DateTime==strptime("2007-02-01", "%Y-%m-%d"))

end<-which(datos$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

datos2<-datos[start:end,] # datos2 covers the dates 2007-02-01 and 2007-02-02.

### plot 2

png(file="plot2.png", width=480, height=480)

plot(datos2$DateTime, as.numeric(as.character(datos2$Global_active_power)),
     type='l',ylab="Global Active Power (Kilowatts)", xlab="")

dev.off()
