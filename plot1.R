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

#########################################################
#Plot the histrogram of Global Active Power in KiloWatts#
#########################################################

par(mfrow=c(1,1))
hist(as.numeric(finalData$Global_active_power),col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

###############################################################
#Open a graphic device and copy the plot onto a file plot1.png#
###############################################################

# Open "PNG" device as per the requirement (480X480)
png(filename="plot1.png", width=480, height=480)

hist(as.numeric(finalData$Global_active_power),col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()