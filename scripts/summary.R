##World Confirmed Cases

globalconfirmed <- read.csv("data/archive/CONVENIENT_global_confirmed_cases.csv", stringsAsFactors = FALSE)

library("dplyr")
##Summary Information

#This summary will calculate some of the data from John Hopkins University over COVID 19

#Confirmed cases in the United States
USc <- select(globalconfirmed, US)
ConfirmedUS <- sum(USc,na.rm = TRUE)

#Confirmed cases in Vanuatu
Van <- select(globalconfirmed, Vanuatu)
confirmvan <- sum(Van, na.rm = TRUE)

#There are a total of 13383319 confirmed cases in the United States as of Dec, 2020
#Where are there is only a single confirmed case in Vanuatu as of Dec 2020.

#How many days does this dataframe cover?
days <- nrow(globalconfirmed)

#The dataframe from Johns Hopkin covers a total of 313 days since the Jan 23, 2020.


##Mean number of confirmed cases in the Unite States
Mean <- select(globalconfirmed, US)
USMean <- colMeans(Mean,na.rm = TRUE) 

##The mean number of cases in the U.S is 42895 in regard to the dates and cases recorded in the dataframe.





##World Deaths

globaldeath <- read.csv("data/archive/CONVENIENT_global_deaths.csv", stringsAsFactors = FALSE)

##What was the most lives lost in Brazil on a daily scale?

Braz <- globaldeath$Brazil
maxBraz <- max(Braz,na.rm = TRUE)

## The data frame shows that Brazil lost over 1703 lives in a day at its peak.


##Conclusion, the data from John Hopkin University shows that through the 313 days of recording,
##The nation with most cases is the United States with 13,383,319 confirmed cases.
##The nation with the least cases is Vanutau, with a single case.
##The mean number of cases with respect to the dates of this data set in the U.S is 42,895 cases.
##Brazil lost 1703 lives on a single day at 9/24/2020, marking their highest daily deaths.




