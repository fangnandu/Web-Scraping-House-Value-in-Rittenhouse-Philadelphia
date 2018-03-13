
###########################################################################################################
####  Property Value Web Scraping and Visualization of Condominums in Rittenhouse Square, Philadelphia####
###########################################################################################################


# 1 environment set up
# 1.1 package load
devtools::install_github("ropensci/RSelenium")
library('RSelenium')
library('rvest')


# 1.2 Selenium set up (used for remote control the chrome)

# 1.2.1 *** RUN THIS SECTION ONLY IF YOU ARE USING SAUCE LABS ***
user <- "fangnan" # Your Sauce Labs Username
pass <- "bb565d29-7b6a-4e46-9d97-2c635833210a" # Your Sauce Labs access key

port <- 4444
ip <- paste0(user, ':', pass, "@ondemand.saucelabs.com")
rdBrowser <- "chrome"
version <- "33"
platform <- "Windows 10"
extraCapabilities <- list(name = "RSelenium", username = user
                          , accessKey = pass, tags = list("RSelenium-vignette", "OS/Browsers-vignette"))
remDr <- remoteDriver$new(remoteServerAddr = ip, port = port, browserName = rdBrowser
                          , version = version, platform = platform
                          , extraCapabilities = extraCapabilities)
#1.2.2  *** RUN THIS COMMAND ONLY IF YOU ARE USING A LOCAL SELENIUM SERVER ***
# Before starting, make sure Selenium is running: java -jar selenium-server-standalone-3.9.1.jar
remDr <- remoteDriver(browserName = "chrome")
# **********************************************************************
remDr$open()
remDr$navigate("http://property.phila.gov/")


#2 Web Scraping
# 2.1 Web Scraping process
condos <- read.csv("condos-rittenhouse.csv") 

myresults <- data.frame()

for (i in 1:nrow(condos)){
  remDr$navigate("http://property.phila.gov/")
  addressbar <- remDr$findElement("css selector","#search-address")
  unitbar <- remDr$findElement("css selector","#search-unit")
  # ADD PAUSES USING Sys.sleep() SO THE PAGE HAS TIME TO LOAD
  Sys.sleep(6)
  
  addr = condos$address[i]
  toString(addr)
  
  unit = condos$unit[i]
  toString(unit)
  
  addressbar$sendKeysToElement(list(condos$address[i]))
  unitbar$sendKeysToElement(list(toString(condos$unit[i])))
  # showmore <- remDr$findElement("css selector", "body > button")
  # showmore$clickElement()
  unitbar$sendKeysToElement(list(key = 'enter'))
  
  Sys.sleep(5)
  
  dom = read_html(remDr$findElement("css selector", "html")$getElementAttribute("innerHTML")[[1]])
  #showmore <- remDr$findElement("css selector", "body > button")
  val<-html_nodes(dom, xpath = "//*[starts-with(@id, 'table-')]/tbody/tr[1]/td[2]/span") %>% html_text()
  #table-2482 > tbody > tr:nth-child(1) > td:nth-child(2) > span 
  val
  sqft<-html_nodes(dom, xpath = " //*[@id='maincontent']/div[3]/div[2]/div[2]/div[6]/div[2]/strong
                   ") %>% html_text()
  sqft  
  thisresult <- data.frame(addr,unit,val,sqft)
  myresults <- rbind(myresults,thisresult)
  
}

write.csv(myresults,"mynewreults.csv")
myresults<- read.csv("mynewreults.csv")
# 2.2 web scriping error explanation and solution:
#error numbers: 16
# (1)
# error 1 explanation: (Address not match:)
# error numbers :1
# error row number:136--the address was (1830 RITTENHOUSE SQ) should be changed to (1830-34 RITTENHOUSE SQ)
# Solution:
# Manually search and add to the myresults.csv
addr <- "1830 RITTENHOUSE SQ"#although the true address is "1830-34 RITTENHOUSE SQ"
addr136<- as.factor(addr136)
unit <- "12C"
val <- "$545600"
class(val136)
x<- 135
sqft <- "1125"
sqft136<- as.factor(sqft136)
data136 <- data.frame(x,addr, unit,val,sqft,stringsAsFactors=FALSE)
class(data136$sqft136)
class(myresults$unit)

install.packages("DataCombine")
library("DataCombine")
myresults[134,]$unit
as.character()
myresults <-InsertRow(myresults,data136,RowNum=135)
class(myresults$addr)
addr<- as.character(addr)
myresults$addr <- as.character(myresults$addr)
class
myresults[135,]$addr<- addr
myresults$sqft <- as.character(myresults$sqft)

myresults[135,]$sqft <- sqft136
write.csv(myresults,"mynewreults2.csv")



# (2)
# error 2 explanation: (No valuation history:)
# error numbers : 15
# num:514;518;521;523;528;530;531;534;536;545;551;553;558;567;568
# Solution:
# After Looked through the sales details and found the market value is hugely different from the sales.
# So we will abandon these 15 units data

# (3)
# error 3 explanation: (the history data start with 2017 instead of 2018)
# solution:
# reconstruction of the scripts and web script it again for these missing data
myresultsfalse<-myresults[508:551,]
for (i in 1:nrow(myresultsfalse)){
    
  remDr$navigate("http://property.phila.gov/")
  addressbar <- remDr$findElement("css selector","#search-address")
  unitbar <- remDr$findElement("css selector","#search-unit")
  # ADD PAUSES USING Sys.sleep() SO THE PAGE HAS TIME TO LOAD
  Sys.sleep(6)
  class(myresultsfalse$addr)
  unit = myresultsfalse$unit[i]

  addressbar$sendKeysToElement(list(toString(myresultsfalse$addr[i])))
  unitbar$sendKeysToElement(list(toString(myresultsfalse$unit[i])))
  # showmore <- remDr$findElement("css selector", "body > button")
  # showmore$clickElement()
  unitbar$sendKeysToElement(list(key = 'enter'))
  
  Sys.sleep(5)
  
  dom = read_html(remDr$findElement("css selector", "html")$getElementAttribute("innerHTML")[[1]])
  #showmore <- remDr$findElement("css selector", "body > button")
  val<-html_nodes(dom, xpath = "//*[starts-with(@id, 'table-')]/tbody/tr[2]/td[2]/span") %>% html_text()
  #table-2482 > tbody > tr:nth-child(1) > td:nth-child(2) > span 
  toString(val)
  as.character(val)
  class(val)
  sqft<-html_nodes(dom, xpath = " //*[@id='maincontent']/div[3]/div[2]/div[2]/div[6]/div[2]/strong
                   ") %>% html_text()
  sqft 
  as.character(myresults$val)
  myresults$val <- as.character(myresults$val)
    class(myresults$val)
   i<- as.numeric(i)
  myresults[507+i,]$val <- val
  myresults[507+i,]$sqft <-sqft

}

write.csv(myresults,"mynewresultsfinal.csv")

# 3 visualization preparation
#3.1 summarize the average price for each property

# when we import the data, be sure that the type of the col of value and sqft is numeric
myresults<-read_csv("mynewresultsfinal.csv",col_types = cols(val = col_number(), sqft = col_number()))
class(myresults$val)
class(myresults$sqft)


theplotdata<-myresults%>%
  group_by(addr)%>%
  summarise(num=n(), meanval=mean(val), meansqft = mean(sqft), average = meanval/meansqft)
write.csv(theplotdata,"theplotdata.csv")


# 3.2  geocoding the address
install.packages("googleway")
library("googleway")
library("sf")
theplotdata<-read.csv("theplotdata.csv")
class(theplotdata$addr)
theplotdata$addr<-as.character(theplotdata$addr)
class(theplotdata$addr)

theplotdata$lng<-NA
theplotdata$lat<-NA
theplotdata$formatted_address<-NA

theplotdata<-theplotdata[c(1:5,8,9),]
theplotgeocode$results$formatted_address

for (i in 1:nrow(theplotdata)){
  theplotgeocode <- google_geocode(address = theplotdata[i,]$addr,
                                   key= "AIzaSyCHhMGy9fw00qrJrCQ16LSsLlAqANfpZ6Y",
                                   simplify = TRUE, region = "us")
  theplotgeocode$results$formatted_address
  coord<-theplotgeocode$results$geometry$location
  coord
  theplotdata[i,]$lat<-coord$lat
  theplotdata[i,]$lng<-coord$lng
  theplotdata$formatted_address[i] <-theplotgeocode$results$formatted_address
}
#After runned this, there are several multi matches for these location, and we will select it manually
#The error number row is 6,7,10,11,12
#error cause: multi matches
#solution: identify the location muanlly 
#trick:add the ""RITTENHOUSE SQ"" to increase the accuracy of geocoding
theplotdata2<-read.csv("theplotdata.csv")
class(theplotdata2$addr)
theplotdata2$addr<-as.character(theplotdata2$addr)
class(theplotdata2$addr)

theplotdata2$lng<-NA
theplotdata2$lat<-NA
theplotdata2$formatted_address<-NA


theplotdataerror<-theplotdata2[c(6,7,10,11,12),]
class(theplotdata$addr)
for (i in 1:nrow(theplotdataerror)){
theplotgeocode <- google_geocode(address = paste(theplotdataerror[i,]$addr, "RITTENHOUSE SQ", sep=" "),
                                 key= "AIzaSyCHhMGy9fw00qrJrCQ16LSsLlAqANfpZ6Y",
                                 simplify = TRUE, region = "us")
theplotgeocode$results$formatted_address
coord<-theplotgeocode$results$geometry$location
coord
theplotdataerror[i,]$lat<-coord$lat[1]
theplotdataerror[i,]$lng<-coord$lng[1]
theplotdataerror$formatted_address[i] <-theplotgeocode$results$formatted_address
}

finalgeocode<-rbind(theplotdata,theplotdataerror)


# identify the irragular data
#(1)
# Address: 219 S 18TH ST RITTENHOUSE SQ 
# unit: PHG
# Number :1
# error:
# the address should be 219-29 S 18TH ST
# solution:
# using the excel to add this to the 219-29 S 18TH ST and recalculate the average price

# (2)
#address:1830-34 RITTENHOUSE SQ
## Number :1
# error:
# the address should be 1830 RITTENHOUSE SQ
# solution:
# using the excel to add this to the 1830 RITTENHOUSE SQ and recalculate the average price

write.csv(finalgeocode,"finalgeocode.csv")


# 4 data visualization
data2<-read.csv("finalgeocode_refined.csv")
coordsf <- st_as_sf(data2, coords = c("lng", "lat"),crs = 4326)
st_write(coordsf,"dp.shp")

library(maptools)
library(rgdal)
writeOGR(coordsf,td,"coordsf" ,driver="ESRI Shapefile")

library("ggplot2")
library("viridis")
library(ggmap)
library(tidyverse)
mapTheme <- function(base_size = 12) {
  theme(
    text = element_text( color = "black"),
    plot.title = element_text(size = 14,colour = "black"),
    plot.subtitle=element_text(face="italic"),
    plot.caption=element_text(hjust=0),
    axis.ticks = element_blank(),
    panel.background = element_blank(),axis.title = element_blank(),
    axis.text = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(colour = "black", fill=NA, size=2)
  )
}
library(corrplot)
library(caret) 
library(AppliedPredictiveModeling)
library(stargazer)
library(ggmap)
library(tidyverse)
library(sf)
library(FNN)

baseMap <- get_map(location = c(lon=-75.17168, lat=39.94841), 
                   source = "stamen", 
                   zoom = 17, scale = "auto"    ,               
                   maptype= 'toner')

ggmap(baseMap) + 
  geom_point(data = data2, 
             aes(x=lng, y=lat, color=factor(ntile(average,5))), 
             size = 8) + 
  labs(title="sqft value in RITTENHOUSE SQ, Pennsylvania") +
  scale_colour_manual(values = c("#ffffcc","#a1dab4","#41b6c4","#2c7fb8","#253494"),
                      labels=as.character(quantile(data2$average)),
                      name="Value Per Sqft\n (Quintile Breaks)") +
  mapTheme()


# join to the parcel 
bppoint <- st_read("dp.shp") %>%
  st_transform(4326)
selectedparcels <- st_read("selected2.shp") %>%
  st_transform(4326)
st_crs(bppoint) == st_crs(selectedparcels)
basemap<-basemap%>%
  st_transform(4326)

st_write(bppoint,"points.shp")
st_write(selectedparcels,"parcels.shp")

# use the 3-D to visualize it 
parcel<-st_read("finalbuildingparceldata.shp")
plot(parcel)
devtools::install_github("tidyverse/ggplot2")
library("ggplot2")
update.packages("ggplot2")
library("ggmap")
head(parcel)
ggplot+
  geom_sf(data = parcel,aes(fill = parcel$medianaver))  
  # labs(title="sqft value in RITTENHOUSE SQ, Pennsylvania") +
  # scale_colour_manual(values = c("#ffffcc","#a1dab4","#41b6c4","#2c7fb8","#253494"),
  #                     labels=as.character(quantile(parcel$medianaver)),
  #                     name="Value Per Sqft\n (Quintile Breaks)") +
  # mapTheme()


library(rgdal)
sfn<-readOGR("finalbuildingparceldata.shp")

proj4string(parcel) # describes data???s current coordinate reference system
# to change to correct projection:
parcel <- spTransform(parcel,
                       CRS("+proj=longlat +datum=WGS84")) 
parcel$id<-1
geom_polygon(aes(x = long, y = lat),
             data = parcel, color ="white", fill ="orangered4",
             alpha = .4, size = .2)


parcel$value<-parcel$medianaver
names(parcel)

sfn.f = sfn %>% fortify(region = 'PARCEL')
SFNeighbourhoods  = merge(sfn.f, parcel, by.x = 'id', by.y = 'PARCEL')%>% distinct()
postcodes = SFNeighbourhoods %>% select(id,medianaver,long,lat) %>% distinct()

class(sfn)
pallete5_colors <- c('#ffffd9',"#edf8b1","#7fcdbb", "#41b6c4",'#1d91c0','#081d58')


 ggplot(data = parcel, aes(x = long, y = lat, group = group)) + geom_path()
proj4string(baseMap)
ggmap(baseMap) + 
  geom_polygon(aes(x = long, y = lat, group=id,fill=medianaver),data = postcodes)+
  scale_fill_gradientn(colors = pallete5_colors)+       
   labs(title="Price Per Sqft in RITTENHOUSE SQ, Pennsylvania",fill="price per sqft",
        caption = " property.phila.gov Data") +
  mapTheme()
