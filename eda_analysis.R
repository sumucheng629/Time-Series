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

#Create a new tsibble for this data subset
tfr_data <- births |> filter(DataSeries == "Total Fertility Rate (TFR)")
tlb_data <- births |> filter(DataSeries == "Total Live-Births")

## Fit three types of trend models to compare their performance
tfr_fit <- tfr_data |>
  model(
    linear = TSLM(value ~ trend()),
    quad   = TSLM(value ~ trend() + I(trend()^2)),
    cubic  = TSLM(value ~ trend() + I(trend()^2) + I(trend()^3))
  )