# Table Review Checklist - 2026-06-03

This checklist records how the generated table outputs should be reviewed
before writing the report. It is not a final interpretation and should not be
copied into the submitted report.

## Data And Output Integrity

| Table | Review purpose |
| --- | --- |
| `outputs/tables/data_validation_checks.csv` | Confirm that the two expected measures are present, complete, consecutive, positive, and non-duplicated. |
| `outputs/tables/output_quality_checks.csv` | Confirm that the key tables and figures required for drafting exist and are non-empty. |
| `outputs/tables/output_manifest.csv` | Check which generated files are available before citing them in the report or appendix. |

## Exploratory Evidence

| Table | Review purpose |
| --- | --- |
| `outputs/tables/descriptive_features.csv` | Summarise the starting value, latest value, minimum, maximum, and average change for each series. |
| `outputs/tables/annual_change_features.csv` | Identify the years of largest annual increase and decrease before discussing sudden changes. |
| `outputs/tables/transformation_screen.csv` | Support the discussion of original scale versus log scale, especially for total live births. |
| `outputs/tables/stationarity_screen.csv` | Support the differencing discussion using level ACF1 and differenced ACF1 values. |

## Modelling Evidence

| Table | Review purpose |
| --- | --- |
| `outputs/tables/forecast_design.csv` | State the full sample, training sample, and holdout sample before reporting forecast accuracy. |
| `outputs/tables/candidate_model_registry.csv` | Explain what each candidate model is meant to test. |
| `outputs/tables/model_selection_evidence.csv` | Compare accuracy ranks, residual checks, and model roles together. |
| `outputs/tables/residual_ljung_box_tests.csv` | Check whether residual autocorrelation remains after modelling. |

## Guardrails

- Do not choose the final model from `best_holdout_models.csv` alone.
- If a model has the lowest RMSE but fails residual checks, state that tension
  explicitly before deciding whether to keep it.
- If original-scale and log-scale evidence conflict, explain the tradeoff rather
  than hiding one result.
- Keep large tables in the appendix unless the main report needs a specific
  row or summary.
