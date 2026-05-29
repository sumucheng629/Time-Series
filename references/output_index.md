# Output Index

This file records the expected outputs from `scripts/run_project.R`. The files
will be created after the workflow is run in RStudio.

## Tables

| Output | Script | Suggested use |
| --- | --- | --- |
| `clean_birth_fertility_series.csv` | `01_prepare_data.R` | Appendix or reproducibility check. |
| `series_summary.csv` | `01_prepare_data.R` | Data description. |
| `data_validation_checks.csv` | `01_validate_data.R` | Reproducibility and cleaning evidence. |
| `descriptive_features.csv` | `02_descriptive_summary.R` | EDA summary. |
| `annual_change_features.csv` | `02_descriptive_summary.R` | EDA summary or appendix. |
| `series_association.csv` | `02_descriptive_summary.R` | Optional context only. |
| `transformation_series.csv` | `02_transformation_checks.R` | Appendix support for scale decisions. |
| `transformation_screen.csv` | `02_transformation_checks.R` | Transformation discussion. |
| `transformation_recommendation_inputs.csv` | `02_transformation_checks.R` | Drafting aid for scale choice. |
| `differenced_series.csv` | `02_stationarity_checks.R` | Appendix support for differencing. |
| `stationarity_screen.csv` | `02_stationarity_checks.R` | Model selection support. |
| `forecast_design.csv` | `03_model_comparison.R` | Explain the train/holdout split. |
| `candidate_model_registry.csv` | `03_model_comparison.R` | Document candidate model roles. |
| `candidate_model_fit_statistics.csv` | `03_model_comparison.R` | Model comparison. |
| `candidate_model_terms.csv` | `03_model_comparison.R` | Appendix. |
| `residual_ljung_box_tests.csv` | `03_model_comparison.R` | Diagnostics. |
| `holdout_forecast_accuracy.csv` | `04_forecast_assessment.R` | Final model selection evidence. |
| `best_holdout_models.csv` | `04_forecast_assessment.R` | Drafting aid, not the only selection rule. |
| `model_selection_evidence.csv` | `04_selection_evidence.R` | Combined review table for model choice. |
| `session_info.txt` | `05_session_info.R` | Reproducibility note. |

## Figures

| Output | Script | Suggested use |
| --- | --- | --- |
| `annual_series_overview.png` | `02_exploratory_analysis.R` | Main report EDA. |
| `level_acf.png` | `02_exploratory_analysis.R` | Appendix or modelling motivation. |
| `annual_first_differences.png` | `02_exploratory_analysis.R` | Main report or appendix. |
| `first_difference_acf.png` | `02_exploratory_analysis.R` | Appendix or differencing discussion. |
| `scale_comparison.png` | `02_transformation_checks.R` | Transformation discussion. |
| `candidate_model_residuals.png` | `03_model_comparison.R` | Diagnostics. |
| `candidate_residual_acf.png` | `03_model_comparison.R` | Diagnostics or appendix. |
| `holdout_forecast_comparison.png` | `04_forecast_assessment.R` | Forecast evaluation. |
| `five_year_candidate_forecasts.png` | `04_forecast_assessment.R` | Final forecast discussion. |
