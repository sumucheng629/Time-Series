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
births <- birth_raw |>
  pivot_longer(
    cols = -DataSeries, 
    names_to = "Year_Raw", 
    values_to = "value",
    values_transform = list(value = as.numeric)
  ) |>
  mutate(
    #To address the errors found during data loading, I added these two lines for better data handling and optimization
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

#Visualizing the raw time series data for TFR to observe historical trends
tfr_data |> autoplot(value) + labs(title = "Singapore Total Fertility Rate (1960-2024)",)

#TLB
tlb_data |> autoplot(value) + labs(title = "Singapore Total Live-Births (1960-2024)",)

#Explore the raw time series data
tfr_data|> ACF(value) |> autoplot()
tfr_data|> PACF(value) |> autoplot()
tlb_data|> ACF(value) |> autoplot()
tlb_data|> PACF(value) |> autoplot()

#First Difference
tfr_diff <- tfr_data |>mutate(diff1 = difference(value))
tlb_diff <- tlb_data |>mutate(diff1 = difference(value))

#ACF / PACF after differencing
tfr_diff |>filter(!is.na(diff1)) |>ACF(diff1) |>autoplot() +labs(title = "ACF of differenced TFR")
tfr_diff |>filter(!is.na(diff1)) |>PACF(diff1) |>autoplot() +labs(title = "PACF of differenced TFR")

tlb_diff |>filter(!is.na(diff1)) |>ACF(diff1) |>autoplot() +labs(title = "ACF of differenced TLB")
tlb_diff |>filter(!is.na(diff1)) |>PACF(diff1) |>autoplot() +labs(title = "PACF of differenced TLB")

#For TFR
#Fit three types of trend models to compare their performance
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

#Portmanteau test
tfr_test <- tfr_aug |> features(.resid, portmanteau_tests)
print(tfr_test)

tlb_test <- tlb_aug |> features(.resid, portmanteau_tests)
print(tlb_test)

# Train: 1960-2012
# Test:  2013-2024
births_train <- births |> filter(Year <= 2012)
births_test  <- births |> filter(Year >= 2013, Year <= 2024)

tfr_train <- births_train |> filter(DataSeries == "Total Fertility Rate (TFR)")
tfr_test  <- births_test  |> filter(DataSeries == "Total Fertility Rate (TFR)")

tlb_train <- births_train |> filter(DataSeries == "Total Live-Births")
tlb_test  <- births_test  |> filter(DataSeries == "Total Live-Births")

#Fit an ARIMA(1,1,0) model to the TFR training data
tfr_model_arima <- tfr_train |>model(tfr_arima = ARIMA(value ~ pdq(1,1,0)))

#View the fitted coefficients
tidy(tfr_model_arima)

#Forecast over the full test period
tfr_fc <- tfr_model_arima |>forecast(new_data = tfr_test)

#Plotting
tfr_train |>
  autoplot(value) +
  autolayer(tfr_fc) +
  autolayer(tfr_test, value, colour = "black") +
  labs(
    title = "TFR Forecast using ARIMA(1,1,0)",
  )

#For as the same as TFR
#Fit an ARIMA(1,1,0) model
tlb_model_arima <- tlb_train |>model(tlb_arima = ARIMA(value ~ pdq(1,1,0)))

tidy(tlb_model_arima)

tlb_fc <- tlb_model_arima |>forecast(new_data = tlb_test)

tlb_train |>
  autoplot(value) +
  autolayer(tlb_fc) +
  autolayer(tlb_test, value, colour = "black") +
  labs(
    title = "TLB Forecast using ARIMA(1,1,0)",
  )
