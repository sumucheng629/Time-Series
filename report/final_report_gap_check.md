# Final Report Gap Check

Use this file after drafting the report. It is a compact audit list to make sure
the final submission is evidence-based and not just a collection of generated
outputs.

| Report section | Evidence to check | Common gap to fix |
| --- | --- | --- |
| Research question | `report/final_report_workbook.qmd` | Question is too broad or does not mention forecasting. |
| Data | `series_summary.csv`, `data_validation_checks.csv` | Years, units, or validation status are missing. |
| Exploratory analysis | `annual_series_overview.png`, `annual_first_differences.png` | The section describes the plot but does not interpret time-series behaviour. |
| Transformation and stationarity | `transformation_screen.csv`, `stationarity_screen.csv` | Scale or differencing choice is asserted without evidence. |
| Candidate models | `candidate_model_registry.csv`, `candidate_model_fit_statistics.csv` | Models are listed without explaining why they are plausible candidates. |
| Diagnostics | `residual_ljung_box_tests.csv`, `candidate_residual_acf.png` | Residual dependence is ignored when selecting a model. |
| Forecast evaluation | `holdout_forecast_accuracy.csv`, `model_selection_evidence.csv` | Lowest RMSE is selected mechanically without considering diagnostics. |
| Final forecasts | `five_year_candidate_forecasts.png` | Forecasts are stated too strongly without uncertainty or limitations. |
| Conclusion | Final selected evidence | Conclusion introduces claims not supported earlier in the report. |

## Final Review Questions

- Does every final model choice cite both an accuracy result and a diagnostic
  result?
- Are the two series discussed separately when their behaviour differs?
- Are limitations tied to annual data, sample size, and possible structural
  demographic change?
- Are appendix tables used for detail instead of overloading the main report?
- Have all workbook placeholders been removed from the final submission file?

