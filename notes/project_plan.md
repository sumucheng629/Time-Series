# Project Plan

## Aim

Develop a reproducible annual time series analysis of Singapore fertility and
birth data using methods from the course.

## Working Research Direction

The report should focus on how Singapore's fertility and live-birth series have
changed over time, and which course-based forecasting models give reasonable
short-term forecasts after diagnostic checking.

This wording is a working direction only. The final report should refine it
after the plots, diagnostics, and forecast accuracy tables have been reviewed.

## Planned Analysis Steps

1. Import the raw CSV and reshape it into tidy annual time series.
2. Plot each series on its original scale.
3. Check autocorrelation before and after first differencing.
4. Fit simple benchmarks, trend models, ARIMA, and ETS candidates.
5. Compare candidate models using residual checks and holdout accuracy.
6. Refit selected candidates to the full data.
7. Produce a concise final forecast and discuss uncertainty.
8. Put extra formulas, diagnostics, and rejected models in the appendix.

## Student Decisions Still Needed

- exact final research question
- final train/test split justification
- whether a transformed birth series is needed
- final model choice for each series
- which figures belong in the main report versus appendix
