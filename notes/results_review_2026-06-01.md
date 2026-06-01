# Results Review Notes - 2026-06-01

This note records checks made after rerunning the workflow. It is intended to
guide later report drafting and should not be treated as the final model
selection.

## Output Coverage

The generated `outputs/tables/output_manifest.csv` lists 30 generated output
files plus the header row. The current workflow produces both table outputs and
figure outputs, including EDA plots, ACF plots, candidate-model residual plots,
holdout forecast plots, and future forecast plots.

## Data Validation

The validation table indicates that the two expected measures are present,
there are no missing observations, there are no duplicate measure-year keys,
the annual years are consecutive, all observations are positive, and each
series has 66 observations.

## Transformation And Stationarity Checks

The transformation screening table indicates that log scale is available for
both selected series because all observations are positive. For total live
births, the note flags log scale as worth comparing before finalising the
model. The stationarity screen shows high level ACF1 for both series and lower
ACF1 after differencing or log differencing, so the report should discuss why
differencing or transformed differences are considered.

## Model Evidence To Inspect

The model-selection evidence table ranks candidate models by holdout RMSE and
MAE, while also recording Ljung-Box residual checks. The table should be used
as a review aid only. A final model choice still needs a written justification
that combines forecast accuracy, residual diagnostics, parsimony, and whether
the forecasts are substantively reasonable.

## Items To Check Before Report Drafting

- Inspect `candidate_model_residuals.png` and `candidate_residual_acf.png`
  before accepting any model.
- Compare `holdout_forecast_comparison.png` with the accuracy table.
- Decide whether total live births should be discussed on original scale,
  log scale, or both.
- Keep the main report focused on the most important evidence and move extra
  diagnostics into the statistical appendix.
