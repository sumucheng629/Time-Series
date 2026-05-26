# Data Dictionary

This dictionary describes the analysis-ready data produced by
`scripts/01_prepare_data.R`.

## Analysis Table

The clean table is saved as `outputs/tables/clean_birth_fertility_series.csv`
when the workflow is run.

| Column | Type | Description |
| --- | --- | --- |
| `Measure` | character | Name of the selected demographic series. |
| `Year` | integer | Calendar year used as the time index. |
| `Observed` | numeric | Recorded value for the selected series in that year. |

## Measure Labels

| Clean label | Raw data row | Working interpretation |
| --- | --- | --- |
| `Total fertility rate` | `Total Fertility Rate (TFR)` | Average number of births per woman implied by age-specific fertility rates. |
| `Total live births` | `Total Live-Births` | Count of live births recorded in that calendar year. |

## Generated Summary Tables

| File | Purpose |
| --- | --- |
| `series_summary.csv` | Basic coverage check for each selected series. |
| `descriptive_features.csv` | First/latest values, minimums, maximums, and long-run changes. |
| `annual_change_features.csv` | Largest annual increases/decreases and variability of annual changes. |
| `series_association.csv` | Simple correlation between the two selected series. |

These tables support report drafting, but they do not determine the final model
choice by themselves.
