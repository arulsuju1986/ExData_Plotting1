############################################
#Getting and Staging Data onto local Drives#
############################################

# Download dataset if already not download
if (!file.exists("dataset.zip")){
  #  URL of Dataset
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  #  downloads the zipped file and renames it to something simple(dataset.zip)
  download.file(fileURL,destfile="dataset.zip",method="wget")
  #  Date stamp the data downloaded
  dateDownloaded<-date()
  #unzip the zipped file thats downloaded currently
  unzip("~/dataset.zip")
}

#########################################################
#Read the data onto R and convert into appropriate types#
#########################################################
#Unzip dataset.zip creates a file household_power_consumption.txt. 
readData<-read.table("./household_power_consumption.txt",sep=";",header=TRUE,colClasses="character")

#Convert the readData$Date column into real date type.
readData$Date<-as.Date(readData$Date,"%d/%m/%Y")


# This is for readData$Time col time that should also include date(1st col for appropriate conversion)
dateandtime<-paste(readData$Date,readData$Time)

#Convert it into real time-stamp (including date.
readData$Time<-strptime(dateandtime,format="%Y-%m-%d %H:%M:%S",tz="")

###########################################################################################################
#Filter the tidy data onto the final data frame consisting of filtered dates b/w "2007-02-01","2007-02-02"#
###########################################################################################################

#Find the subset between 2007-02-01 and 2007-02-02
finalData=subset(readData,readData$Date %in% as.Date(c("2007-02-01","2007-02-02")))


par(mfrow=c(2,2))
#####################################################################################
#Global Active Data (in KW) on the days "2007-02-01","2007-02-02"                   #
#####################################################################################
#c(1,1) Graph
with(finalData, plot(finalData$Time,finalData$Global_active_power,type="l",xlab=" ",ylab="Global Active Power"))

#####################################################################################
#Plot Voltage data on the days "2007-02-01","2007-02-02"              #
#####################################################################################
#c(1,2) Graph
with(finalData, plot(finalData$Time,finalData$Voltage,type="l",xlab="datetime",ylab="Voltage"))

############################################################################################
#Plot Sub_metering_1/Sub_metering_2 & Sub_metering_1 on days b/w "2007-02-01","2007-02-02" #
############################################################################################
#c(2,1) Graph
with(finalData, plot(finalData$Time,finalData$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(finalData, lines(finalData$Time,finalData$Sub_metering_2,col="Red",ylab="Energy sub metering"))
with(finalData, lines(finalData$Time,finalData$Sub_metering_3,col="Blue",ylab="Energy sub metering"))

#####################################################################################
#Global Reactive Power on the days b/w "2007-02-01","2007-02-02"                    #
#####################################################################################
#c(2,2) Graph
with(finalData, plot(finalData$Time,finalData$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))


################################################################################
#Open a graphic device and copy this plot onto a file plot2.png                #
################################################################################

# Open "PNG" device as per the requirement (480X480)
png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2))
#c(1,1) Graph
with(finalData, plot(finalData$Time,finalData$Global_active_power,type="l",xlab=" ",ylab="Global Active Power"))
#c(1,2) Graph
with(finalData, plot(finalData$Time,finalData$Voltage,type="l",xlab="datetime",ylab="Voltage"))
#c(2,1) Graph
with(finalData, plot(finalData$Time,finalData$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(finalData, lines(finalData$Time,finalData$Sub_metering_2,col="Red",ylab="Energy sub metering"))
with(finalData, lines(finalData$Time,finalData$Sub_metering_3,col="Blue",ylab="Energy sub metering"))
#c(2,2) Graph
with(finalData, plot(finalData$Time,finalData$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))

dev.off()