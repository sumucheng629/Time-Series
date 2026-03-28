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
births <- birth_raw |>
  pivot_longer(
    cols = -DataSeries, 
    names_to = "Year_Raw", 
    values_to = "value",
    values_transform = list(value = as.numeric)
  ) |>
  mutate(
    # To address the errors found during data loading, I added these two lines for better data handling and optimization
    Year = as.integer(gsub("X", "", Year_Raw)),
    DataSeries = trimws(DataSeries)
  ) |>
  filter(
    Year >= 1960, Year <= 2024,
    DataSeries %in% c("Total Fertility Rate (TFR)", "Total Live-Births")
  ) |>
  as_tsibble(key = DataSeries, index = Year)

#Create a new tsibble for this data subset
tfr_data <- births |> filter(DataSeries == "Total Fertility Rate (TFR)")
tlb_data <- births |> filter(DataSeries == "Total Live-Births")

#For TFR
# Fit three types of trend models to compare their performance
# Use I() to treat arithmetic operators as identity functions within the formula
tfr_fit <- tfr_data |>
  model(
    linear = TSLM(value ~ trend()),
    quad   = TSLM(value ~ trend() + I(trend()^2)),
    cubic  = TSLM(value ~ trend() + I(trend()^2) + I(trend()^3))
  )

#View fit statistics
tidy(tfr_fit)
glance(tfr_fit) |> arrange(AICc)

#Extract fitted values and residuals for the cubic model
tfr_aug <- augment(tfr_fit) |> filter(.model == "cubic")

#White Noise check
tfr_aug |> autoplot(.resid) + labs(title = "Cubic Model Residuals -TFR")

#Perform Portmanteau tests to statistically verify if residuals are white noise
tfr_aug |> 
  features(.resid, portmanteau_tests)
tfr_aug |> features(.resid, portmanteau_tests)

#Check for remaining seasonality and stationarity
tfr_aug |> 
  ACF(.resid) |>autoplot() + labs(title = "Residuals ACF Plot - Cubic Model (TFR)")

# Visualizing the raw time series data for TFR to observe historical trends
tfr_data |> autoplot(value) + labs(title = "Singapore Total Fertility Rate (1960-2024)",)

#For TLB
#As same as TFR
tlb_fit <- tlb_data |>
  model(
    linear = TSLM(value ~ trend()),
    quad   = TSLM(value ~ trend() + I(trend()^2)),
    cubic  = TSLM(value ~ trend() + I(trend()^2) + I(trend()^3))
  )

#View fit statistics
glance(tlb_fit) |> arrange(AICc)

tlb_aug <- augment(tlb_fit) |> filter(.model == "cubic")

#White Noise check
tlb_aug |> autoplot(.resid) + labs(title = "Cubic Model Residuals - TLB")

#ACF
tlb_aug |> ACF(.resid) |> autoplot() + labs(title = "Residuals ACF Plot - TLB")

tlb_data |> autoplot(value) + labs(title = "Singapore Total Live-Births (1960-2024)",)

#Portmanteau test
tfr_test <- tfr_aug |> features(.resid, portmanteau_tests)
print(tfr_test)

tlb_test <- tlb_aug |> features(.resid, portmanteau_tests)
print(tlb_test)