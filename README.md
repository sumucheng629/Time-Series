# Singapore Birth And Fertility Time Series

This repository contains the working files for a time series assignment using
annual Singapore birth and fertility data. The project is currently in an early
analysis stage: the data workflow and modelling scripts have been set up, while
the written report still needs the student's own interpretation and final model
justification.

## Research Focus

The project uses two annual series from the raw data file:

- total fertility rate
- total live births

A suitable final report should connect these series to a clear question about
long-run demographic change and short-term forecasting. The current scripts are
designed to support that question by producing exploratory plots, residual
diagnostics, model comparison tables, and holdout forecast accuracy results.

## Current Stage

Completed so far:

- raw CSV placed under `data/raw/`
- reproducible R workflow split across numbered scripts
- data notes and a data dictionary added under `references/`
- data validation checks added before EDA and modelling
- descriptive summary tables included in the workflow
- transformation screening added for scale and log-scale decisions
- stationarity screening tables added for differencing decisions
- forecast evaluation design table added for the holdout split
- candidate model registry added for transparent model comparison
- model selection evidence table added for later manual review
- report drafting checklist and output index added for the next writing stage
- output folders prepared for generated figures and tables
- report and statistical appendix templates added
- basic candidate models included for comparison

Still to complete:

- run the workflow in RStudio after installing the required packages
- inspect the generated plots and tables
- choose the final model for each series using diagnostics and forecast accuracy
- write the report in the student's own words
- move extra technical details into the statistical appendix

## How To Run

Open `Time-Series.Rproj` in RStudio, set the working directory to the project
root if needed, then run:

```r
source("scripts/run_project.R")
```

On this Windows machine, the workflow can also be run from PowerShell:

```powershell
.\scripts\run_windows_workflow.ps1
```

Required R packages:

- dplyr
- tidyr
- tibble
- ggplot2
- tsibble
- fable
- feasts
- fabletools
- stringr

Generated plots are written to `outputs/figures/`. Generated CSV summaries are
written to `outputs/tables/`.

## Repository Structure

```text
data/raw/                  raw source data
notes/                     project plan and work log
outputs/figures/           generated plots
outputs/tables/            generated model and diagnostic tables
references/                data notes and source information
report/                    report and appendix templates
scripts/                   reproducible R workflow
```

## Script Order

```text
scripts/00_setup.R                 package checks and shared helpers
scripts/01_prepare_data.R          import, reshape, and save clean series
scripts/01_validate_data.R         validation checks for the clean series
scripts/02_descriptive_summary.R   summary features and annual change tables
scripts/02_transformation_checks.R scale and log-scale screening
scripts/02_stationarity_checks.R   differencing data and ACF1 screening
scripts/02_exploratory_analysis.R  time plots, first differences, and ACFs
scripts/03_model_comparison.R      candidate models and residual diagnostics
scripts/04_forecast_assessment.R   holdout accuracy and future forecasts
scripts/04_selection_evidence.R    combined evidence table for model review
scripts/05_session_info.R          reproducibility metadata
scripts/run_project.R              runs the full workflow
scripts/run_windows_workflow.ps1   PowerShell helper for this Windows setup
```

## Report Drafting

The files in `report/` are only templates. They should not be submitted as-is.
After running the scripts, the student should use the generated evidence to
write the analysis, explain model choices, and state the final conclusions.

The latest successful workflow run is documented in
`notes/run_2026-05-31.md`.
