library(dplyr)
library(tidyr)
library(ggplot2)
library(fable)
library(tsibble)
library(feasts)

#Read data
setwd("C:\\Users\\33169\\Desktop\\singapore birth-fertility EDA\\data")
birth_raw<-read.csv("BirthsAndFertilityRatesAnnual.csv")

#Reshape wide data to long format to meet tsibble requirements 
#Use values_transform to ensure consistent numeric type across all years
births<-birth_raw|>
  pivot_longer(
    cols=-DataSeries,
    names_to = "Year",
    values_to = "value",
    values_transform = list(value = as.numeric)
  )|>
  mutate(Year=as.integer(Year))|>
  filter(
    Year>=1960,Year<=2024,
    DataSeries %in% c("Total Fertility Rate","Total Live-Births")
  )|>
  as_tsibble(key = DataSeries,index = Year)

