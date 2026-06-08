# Singapore Birth and Fertility Time Series Analysis

Statistical analysis of Singapore Total Live Births (TLB) and Total Fertility Rate (TFR)
from 1960 to 2024. Models are fitted on the 1960–2012 period and evaluated against
observed values from 2013 to 2024.

**Course:** MATH X313 — Time Series Analysis  
**Assignment:** Statistical Report (Part 1 EDA + Part 2 Final Report)  
**GitHub:** https://github.com/sumucheng629/Time-Series

## Research Question

How well can ARIMA and seasonal ARIMA models, fitted on Singapore annual TLB and TFR
data from 1960 to 2012, forecast the observed decline from 2013 to 2024? What do
long-run demographic patterns reveal about the structural drivers of Singapore's
fertility transition?

## Data

Source: [Singapore Department of Statistics](https://data.gov.sg/datasets?query=birth+and+fertility+rates&resultId=d_e39eeaeadb571c0d0725ef1eec48d166)

- Total Live Births (TLB): annual counts, 1960–2024
- Total Fertility Rate (TFR): annual rates, 1960–2024
- Raw CSV stored under `data/raw/`

## Analysis Workflow

The full analysis runs in a sequence of numbered R scripts:

```text
scripts/00_setup.R                 package checks and shared helpers
scripts/01_prepare_data.R          import, reshape, and save clean series
scripts/01_validate_data.R         validation checks on the clean series
scripts/02_descriptive_summary.R   summary features and annual change tables
scripts/02_transformation_checks.R log-scale screening for each series
scripts/02_stationarity_checks.R   ADF/KPSS tests and differencing decisions
scripts/02_exploratory_analysis.R  time plots, ACFs, and seasonal diagnostics
scripts/03_model_comparison.R      ARIMA and SARIMA candidates, residual diagnostics
scripts/04_forecast_assessment.R   holdout accuracy and point forecasts to 2030
scripts/04_selection_evidence.R    combined evidence table for model selection
scripts/05_output_manifest.R       index of generated outputs
scripts/05_output_quality_checks.R required output presence checks
scripts/05_report_input_summary.R  evidence summary for report writing
scripts/05_session_info.R          reproducibility metadata
scripts/06_submission_readiness.R  final file-level readiness checks
scripts/run_project.R              runs the full workflow in order
scripts/run_windows_workflow.ps1   PowerShell runner for Windows
```

## How To Run

Open `Time-Series.Rproj` in RStudio and run:

```r
source("scripts/run_project.R")
```

Or from PowerShell on Windows:

```powershell
.\scripts\run_windows_workflow.ps1
```

Required R packages: `dplyr`, `tidyr`, `tibble`, `ggplot2`, `tsibble`, `fable`,
`feasts`, `fabletools`, `stringr`

Generated figures → `outputs/figures/`  
Generated tables → `outputs/tables/`

## Models

Both TLB and TFR series are analysed on their original and log scales. Candidate models
include:

- ARIMA models identified from ACF/PACF after first differencing
- Seasonal ARIMA (SARIMA) models informed by seasonal subseries plots and literature
  on 12-year zodiac-cycle patterns in Singapore birth data
- Models are compared on AIC, residual white-noise tests (Ljung–Box), and
  holdout RMSE/MAE over 2013–2024

Final model selection is documented in `outputs/tables/model_selection_evidence.csv`
and justified in the report.

## Repository Structure

```text
data/raw/                  raw source data
notes/                     project plan, model notes, and work log
outputs/figures/           generated plots
outputs/tables/            generated model and diagnostic tables
references/                data notes and source documentation
report/                    report and statistical appendix
scripts/                   reproducible R analysis workflow
```

## Report

The final report and statistical appendix are in `report/`:

- `report/final_report.pdf` — main report (Abstract through References)
- `report/statistical_appendix.pdf` — technical appendix with model mathematics,
  diagnostics, and reproducibility details
- `report/final_report.qmd` — Quarto source for the main report
- `report/statistical_appendix.qmd` — Quarto source for the appendix
