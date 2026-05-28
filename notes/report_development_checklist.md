# Report Development Checklist

This checklist is for planning the report after the R workflow has been run.
It is not a completed report and should be filled in using the student's own
interpretation.

## Main Report

- State a clear research question linked to annual Singapore fertility and live
  births.
- Describe the data source, time span, and two selected measures.
- Include only the most important EDA figures.
- Explain whether each series appears persistent, trending, or differenced
  before modelling.
- Compare candidate models using both diagnostics and forecast accuracy.
- State the selected final model for each series.
- Interpret forecast uncertainty carefully.
- End with a concise answer to the research question.

## Statistical Appendix

- Include model equations or notation for the main candidate model classes.
- Include extra ACF, residual, and stationarity plots if they are not in the
  main report.
- Include fit statistics and forecast accuracy tables.
- Explain why non-selected models were not used as final models.
- Record reproducibility information from `session_info.txt`.

## Evidence To Review Before Writing

- `outputs/tables/data_validation_checks.csv`
- `outputs/tables/descriptive_features.csv`
- `outputs/tables/stationarity_screen.csv`
- `outputs/tables/candidate_model_fit_statistics.csv`
- `outputs/tables/residual_ljung_box_tests.csv`
- `outputs/tables/holdout_forecast_accuracy.csv`
- `outputs/tables/model_selection_evidence.csv`
- figures in `outputs/figures/`

## Writing Rules

- Do not paste raw code into the main report unless the assignment explicitly
  asks for it.
- Do not claim a model is adequate unless residual checks support that claim.
- Do not choose the final model using one metric only.
- Keep exploratory comments separate from final model conclusions.
