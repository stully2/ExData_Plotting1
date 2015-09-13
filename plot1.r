
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

# plot01
     png(filename = "plot1.png",height =  480,width =  480)
     with(mydata
               ,hist(Global_active_power
               ,main = "Golbal Active Power"
               ,col = "red"
               , xlab = "Global Active Power (kilowatts)"
               )
          )
     dev.off()

if (getwd()!=originalWD) {
     setwd(originalWD)
}

     rm(list = c("mydata","originalWD","workingpath"))
     gc()
     