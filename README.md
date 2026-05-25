# Singapore Birth And Fertility Time Series

This repository is a clean rebuild for an annual time series analysis of
Singapore birth and fertility data. It uses the raw CSV in `data/raw/` and
keeps all analysis code in `scripts/` so the work can be rerun from a fresh
clone.

The analysis focuses on two annual series:

- total fertility rate
- total live births

The scripts prepare the data, create exploratory plots, compare candidate
forecasting models, and save diagnostic tables for the report and statistical
appendix.

## Reproducibility

Run the project from the repository root:

```r
source("scripts/run_project.R")
```

Required R packages:

- readr
- dplyr
- tidyr
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
outputs/figures/           generated plots
outputs/tables/            generated model and diagnostic tables
report/                    report and appendix templates
scripts/                   reproducible R workflow
```

## Report Drafting

The files in `report/` are templates. They contain section prompts only; the
student should add their own interpretation, model justification, and final
discussion after running and checking the analysis.
