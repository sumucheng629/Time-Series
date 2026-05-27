# Model Candidate Notes

This note records the current modelling plan. It is a working document, not a
final model selection.

## Benchmark Models

- `NAIVE(Observed)` gives a simple last-observation benchmark.
- `RW(Observed ~ drift())` allows the level to continue with an average drift.

These models are useful because more complex methods should improve on at least
one simple baseline.

## Trend Model

- `TSLM(Observed ~ trend())` gives a deterministic linear trend benchmark.

This is included to check whether a simple long-run trend explains enough of
the annual movement. If residual autocorrelation remains strong, the final
report should explain why a pure trend model is limited.

## ARIMA Candidate

- `ARIMA(Observed)` lets the software select a course-based ARIMA structure.

The final report should still explain the selected orders, differencing, and
residual checks instead of treating automatic selection as a black box.

## ETS Candidate

- `ETS(Observed)` provides a state-space exponential smoothing alternative.

This is useful for annual demographic series where the level changes over time
but no seasonal pattern is expected.

## Selection Evidence To Use Later

- candidate model registry
- residual time plots
- residual ACF plots
- stationarity screening from levels and differenced series
- documented training and holdout periods
- Ljung-Box tests
- AICc and other fit summaries
- holdout RMSE, MAE, and MAPE
- whether the forecasts are substantively reasonable
