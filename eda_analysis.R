library(dplyr)
library(tidyr)
library(ggplot2)
library(fable)
library(tsibble)
library(feasts)

#read data
setwd("C:\\Users\\33169\\Desktop\\singapore birth-fertility EDA\\data")
birth_raw<-read.csv("BirthsAndFertilityRatesAnnual.csv")

#
births<-birth_raw|>
  pivot_longer(
    cols=-DataSeries,
    names_to = "Year",
    values_to = "value",
  )|>
  mutate(Year=as.integer(Year))|>
  