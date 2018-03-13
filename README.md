# Web-Scraping-house-value-in-Rittenhouse-Philadelphia
Web Scraping and Visualize Market Value &amp; Area Data From property.phila.gov data
## Assignment Desciption
Calculate the price per square foot of condominiums overlooking Rittenhouse Square by scraping the Philadelphia Property Database. Then present this information visually on a map.

## Assignment Steps:
### 1 environment set up
#### - 1.1 package load
#### - 1.2 Selenium set up (two ways: local or SAUCE LABS)

 Selenium setup:

1. Install Java JDK, following these intructions for Windows or these instructions for OS X. You can download the latest Java JDK version here.
2. Download the latest version of the Selenium Standalone Server.
3. Download the latest version of Chromedriver. And if you do not already have it, install Chrome.
4. Take a deep breath. You're halfway there.
5. Open a command prompt (in Windows press Win+R then type "cmd", in OS X search for "terminal" in Spotlight) and view your PATH environment variable. Windows: echo %PATH% / Mac OS: echo $PATH.
6. Unpack the Chromedriver executable file to one of the folders listed in your PATH.
7. NEXT TIME, YOU CAN START AT THIS STEP To start the server, open the command line and go to the directory where the Selenium Standalone Server file is downloaded and run java -jar selenium-server-standalone-3.9.1.jar.

### 2 Web Scraping
#### - 2.1 Web Sraping for the given condos In RittenHouse SQ, Philadelphia
This list of condos (address and unit #) are in the condos-rittenhouse.csv file.

#### - 2.2 Web Scraping Error, Challenges and Solution, Explanation
##### error numbers: 16
###### (1) ERROR 1
- error 1 explanation: (Address not match:)
- error numbers :1
- error row number:136--the address was (1830 RITTENHOUSE SQ) should be changed to (1830-34 RITTENHOUSE SQ)
- Solution: **Manually search and add to the myresults.csv**


###### (2) ERROR 2
- error 2 explanation: (No valuation history:)
- error numbers : 15
- num:514;518;521;523;528;530;531;534;536;545;551;553;558;567;568
- Solution: After Looked through the sales details and found the market value is hugely different from the sales. So we will **abandon these 15 units data**

###### (3) ERROR 3
- error 3 explanation: (the history data start with 2017 instead of 2018)
- solution: **reconstruction of the scripts and web script it again for these missing data**


### 3 visualization preparation
#### - 3.1 summarize the average price per sqft for each property
#### - 3.2 Using Google API to geocoding the address
- [Google geocode](https://www.rdocumentation.org/packages/googleway/versions/2.2.0/topics/google_geocode "Google geocode")
- [geocode API](https://developers.google.com/maps/documentation/geocoding/get-api-key "geocode API")
- [Google API](https://developers.google.com/maps/documentation/geocoding/get-api-key
 "Google API")
#### - 3.3 Geocoding Error, Challenges and Solution, Explanation
##### error numbers: 5
######   ERROR 
- After runned this, there are several multi matches for these location, and we will select it manually
- The error number row is 6,7,10,11,12
- error cause: multi matches
- solution: identify the location muanlly 
- trick:add the ""RITTENHOUSE SQ"" to increase the accuracy of geocoding

#### - 3.4 Final Building CSV Error, Challenges and Solution, Explanation
##### error numbers: 2
###### identify the irragular data
###### (1)
- Address: 219 S 18TH ST RITTENHOUSE SQ 
- unit: PHG
- Number :1
- error:
- the address should be 219-29 S 18TH ST
- solution:
- using the excel to add this to the 219-29 S 18TH ST and recalculate the average price

###### (2)
- address:1830-34 RITTENHOUSE SQ
- Number :1
- error:
- the address should be 1830 RITTENHOUSE SQ
- solution:
- using the excel to add this to the 1830 RITTENHOUSE SQ and recalculate the average price



## final Visualization Map Deliverable
