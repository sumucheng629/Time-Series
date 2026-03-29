# Exploratory Data Analysis of Singapore Birth and Fertility Data

This repository contains the files and code for my EDA assignment on Singapore birth and fertility data.

The project mainly looks at two annual time series from 1960 to 2024:

- **Total Fertility Rate (TFR)**
- **Total Live-Births (TLB)**

The main purpose of the analysis is to explore how these two series behave over time and to identify possible forecasting models for the next stage of the project.

## Repository structure

- **data/**  
  raw data used in the analysis

- **scripts/**  
  main R code for the project

- **README.md**  
  project summary

- **singapore birth-fertility EDA.Rproj**  
  RStudio project file

## R packages used

The main packages used in this project are:

- **dplyr**
- **tidyr**
- **ggplot2**
- **fable**
- **tsibble**
- **feasts**

## Main things done in the analysis

This project includes:

- cleaning and reshaping the raw data
- plotting the original time series
- checking ACF and PACF plots
- first differencing
- fitting linear, quadratic, and cubic trend models
- checking residuals
- fitting an initial ARIMA(1,1,0) model for both TFR and TLB

## Note

Most of the plots were generated directly in R and used in the report, rather than being saved separately here.
