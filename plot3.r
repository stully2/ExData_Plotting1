
# Collect original path settings and reassign working directory if needed
originalWD <- getwd()
# set to "" if you wish to keep main wd "/name" otherwise
workingpath <- "" 
setwd(paste(originalWD,workingpath,sep = ""))

mydata <- read.table("household_power_consumption.txt",header = TRUE,sep = ";"
, stringsAsFactors = FALSE)

mydata[mydata == "?"] <- NA
mydata$Time <- paste(mydata$Date,mydata$Time,sep = " ")
mydata$Date <- as.Date(mydata$Date,"%d/%m/%Y")
mydata$Time <- strptime(mydata$Time,"%d/%m/%Y %H:%M:%S")
mydata <- subset(mydata,mydata$Date>=as.Date("2/1/2007","%m/%d/%Y")
& mydata$Date<=as.Date("2/2/2007","%m/%d/%Y"))
for (i in 3:ncol(mydata)) {
mydata[,i] <- as.numeric(mydata[,i])
}
rm(i)
gc()

  
# plot03
     mycolors = c("black","red","blue")
     png(filename = "plot3.png",height =  480,width =  480)
          plot(mydata$Time,mydata$Sub_metering_1
               ,type = "n"
               ,col = mycolors
               , xlab = NA
               , ylab = "Energy sub metering"
          )
          for (i in 1:3) {
          points(mydata$Time,mydata[,6+i], col = mycolors[i],type = "l")
          }
          legend("topright",names(mydata)[7:9],lty=c(1,1),col = mycolors)
     dev.off()

if (getwd()!=originalWD) {
     setwd(originalWD)
}
     rm(list = c("mydata","originalWD","workingpath","i","mycolors"))
     gc()