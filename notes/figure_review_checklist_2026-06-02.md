# Figure Review Checklist - 2026-06-02

This checklist records how the generated figures should be reviewed before the
main report and statistical appendix are drafted. It does not decide the final
model.

## Main EDA Candidates

| Figure | Review purpose |
| --- | --- |
| `outputs/figures/annual_series_overview.png` | Check long-run direction, turning points, and whether the two series should be discussed separately. |
| `outputs/figures/annual_first_differences.png` | Check whether annual changes show isolated shocks or persistent changes. |
| `outputs/figures/scale_comparison.png` | Compare original-scale and log-scale behaviour before deciding how to discuss total live births. |

## Diagnostics And Model Review

| Figure | Review purpose |
| --- | --- |
| `outputs/figures/level_acf.png` | Motivate why undifferenced levels may be highly persistent. |
| `outputs/figures/first_difference_acf.png` | Check whether first differencing reduces persistence. |
| `outputs/figures/candidate_model_residuals.png` | Inspect whether residuals look centred and stable across time. |
| `outputs/figures/candidate_residual_acf.png` | Check whether residual autocorrelation remains after modelling. |

## Forecast Review

| Figure | Review purpose |
| --- | --- |
| `outputs/figures/holdout_forecast_comparison.png` | Compare candidate forecasts against the 2016-2025 holdout observations. |
| `outputs/figures/five_year_candidate_forecasts.png` | Check whether future forecasts look plausible before using them in the report. |

## Placement Notes

- Keep the main report to a small number of figures that directly support the
  research question.
- Move detailed ACF and residual plots to the statistical appendix unless they
  are essential to the model-selection argument.
- Use the forecast figures together with `outputs/tables/model_selection_evidence.csv`;
  do not rely on plots alone.
