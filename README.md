# Singapore Birth and Fertility EDA

This repository contains my exploratory data analysis (EDA) for the Singapore birth and fertility time series assignment.

## Data
The dataset contains annual observations from 1960 to 2024.
In this project, I focus on:
- Total Live-Births (TLB)
- Total Fertility Rate (TFR)

## Purpose
The purpose of this project is to explore the temporal features of these two series, including:
- trend
- autocorrelation
- stationarity
- possible trend models

This EDA will also help motivate later forecasting models.

## Project structure
- `data/` : raw dataset
- `scripts/` : R scripts used for cleaning, EDA, and modelling
- `figures/` : plots generated from the analysis
- `report/` : LaTeX report files

## Software and packages
The analysis is conducted in R using packages such as:
- tsibble
- feasts
- fable
- ggplot2
- dplyr
- tidyr
- readr

## Reproducibility
All results in the report can be reproduced by running the R scripts in the `scripts/` folder.
