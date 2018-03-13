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
#### 2.1 Web Sraping for the given condos In RittenHouse SQ, Philadelphia
This list of condos (address and unit #) are in the condos-rittenhouse.csv file.

#### 2.2 Web Scraping Error, Challenges and Solution, Explanation
##### error numbers: 16
###### (1)
error 1 explanation: (Address not match:)
error numbers :1
error row number:136--the address was (1830 RITTENHOUSE SQ) should be changed to (1830-34 RITTENHOUSE SQ)
Solution:
# Manually search and add to the myresults.csv






## final Visualization Map Deliverable
