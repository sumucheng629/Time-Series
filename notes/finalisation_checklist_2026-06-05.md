# Finalisation Checklist - 2026-06-05

This note records the remaining review work before the assignment is submitted.
The repository now contains the core workflow, generated evidence, report
workbooks, appendix workbook, and file-level readiness checks. The final report
still needs the student's own written interpretation.

## Evidence Already Prepared

- Clean annual birth and fertility series are generated in
  `outputs/tables/clean_birth_fertility_series.csv`.
- Data validation checks are generated in
  `outputs/tables/data_validation_checks.csv`.
- Exploratory summary tables and figures are generated under `outputs/`.
- Transformation and stationarity screens are generated for scale and
  differencing decisions.
- Candidate model registry, fit statistics, residual diagnostics, holdout
  accuracy, and combined selection evidence are generated.
- Main report and statistical appendix workbooks are available under `report/`.
- Submission readiness checks are generated in
  `outputs/tables/submission_readiness_checks.csv` and
  `outputs/tables/submission_readiness_summary.csv`.

## Final Student-Owned Decisions

- Write the research question in the student's own words.
- Decide how much emphasis to give total fertility rate versus total live
  births in the introduction.
- Choose the final model for each series by balancing holdout accuracy,
  diagnostics, and interpretability.
- Explain why any top-accuracy model is or is not selected.
- Select which figures belong in the main report and which belong in the
  appendix.
- Write the conclusion as a direct answer to the research question.
- Check that all claims in the final report are supported by a generated table,
  figure, or source note.

## Suggested Main Report Assembly Order

1. Open `report/final_report_workbook.qmd`.
2. Use `outputs/tables/report_input_summary.csv` to confirm the analysis is
   ready for drafting.
3. Fill the research question and data sections from `series_summary.csv` and
   `data_validation_checks.csv`.
4. Write exploratory observations from the overview, first-difference, and scale
   comparison figures.
5. Use `candidate_model_registry.csv` to describe the comparison set.
6. Use `model_selection_evidence.csv`, `holdout_forecast_accuracy.csv`, and
   `residual_ljung_box_tests.csv` to justify final model choices.
7. Move technical tables that interrupt the argument into
   `report/statistical_appendix_workbook.qmd`.
8. Finish with a concise conclusion and a limitations paragraph.

## Pre-Submission Checks

- Run `powershell -ExecutionPolicy Bypass -File .\scripts\run_windows_workflow.ps1`.
- Confirm `outputs/tables/submission_readiness_summary.csv` has no missing or
  empty files.
- Confirm the final report does not contain placeholder text from the
  workbooks.
- Confirm all figure captions and table references match the selected outputs.
- Confirm the final report and appendix use the student's own phrasing.

