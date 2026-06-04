if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

required_submission_files <- tibble::tribble(
  ~item_type, ~item, ~file, ~required_status, ~student_action,
  "workflow", "Main workflow runner", "scripts/run_project.R", "must_exist", "Rerun before final submission.",
  "workflow", "Windows workflow helper", "scripts/run_windows_workflow.ps1", "must_exist", "Use on this machine if RStudio is not used.",
  "workflow", "Package and helper setup", "scripts/00_setup.R", "must_exist", "Check package availability.",
  "data", "Raw source data", "data/raw/BirthsAndFertilityRatesAnnual.csv", "must_exist", "Confirm source name and variables in report.",
  "data", "Clean analysis table", "outputs/tables/clean_birth_fertility_series.csv", "must_exist", "Use for reproducibility reference.",
  "evidence", "Data validation checks", "outputs/tables/data_validation_checks.csv", "must_exist", "Summarise cleaning checks.",
  "evidence", "Series summary", "outputs/tables/series_summary.csv", "must_exist", "Report final years and variables.",
  "evidence", "Descriptive features", "outputs/tables/descriptive_features.csv", "must_exist", "Use for exploratory discussion.",
  "evidence", "Transformation screen", "outputs/tables/transformation_screen.csv", "must_exist", "Support scale discussion.",
  "evidence", "Stationarity screen", "outputs/tables/stationarity_screen.csv", "must_exist", "Support differencing discussion.",
  "evidence", "Candidate model registry", "outputs/tables/candidate_model_registry.csv", "must_exist", "Explain candidate model set.",
  "evidence", "Model fit statistics", "outputs/tables/candidate_model_fit_statistics.csv", "must_exist", "Compare fitted candidates.",
  "evidence", "Residual tests", "outputs/tables/residual_ljung_box_tests.csv", "must_exist", "Discuss diagnostic adequacy.",
  "evidence", "Holdout accuracy", "outputs/tables/holdout_forecast_accuracy.csv", "must_exist", "Justify selected models.",
  "evidence", "Combined selection evidence", "outputs/tables/model_selection_evidence.csv", "must_exist", "Balance accuracy and diagnostics.",
  "evidence", "Report input summary", "outputs/tables/report_input_summary.csv", "must_exist", "Use as final drafting guide.",
  "figure", "Annual series overview", "outputs/figures/annual_series_overview.png", "must_exist", "Use in EDA section.",
  "figure", "Scale comparison", "outputs/figures/scale_comparison.png", "must_exist", "Use in transformation discussion.",
  "figure", "Residual ACF figure", "outputs/figures/candidate_residual_acf.png", "must_exist", "Use in diagnostics section.",
  "figure", "Holdout forecast comparison", "outputs/figures/holdout_forecast_comparison.png", "must_exist", "Use in model evaluation.",
  "figure", "Five-year forecasts", "outputs/figures/five_year_candidate_forecasts.png", "must_exist", "Use in forecast discussion.",
  "report", "Main report template", "report/final_report_template.qmd", "must_exist", "Do not submit as-is; rewrite in student's own words.",
  "report", "Main report workbook", "report/final_report_workbook.qmd", "must_exist", "Use to assemble the final report evidence.",
  "report", "Statistical appendix template", "report/statistical_appendix_template.qmd", "must_exist", "Use for a concise appendix.",
  "report", "Statistical appendix workbook", "report/statistical_appendix_workbook.qmd", "must_exist", "Move detailed evidence here.",
  "notes", "Drafting evidence map", "report/report_drafting_map.md", "must_exist", "Check every final paragraph has evidence.",
  "notes", "Work log", "notes/work_log.md", "must_exist", "Keep development record current.",
  "references", "Output index", "references/output_index.md", "must_exist", "Check generated file purposes."
)

submission_readiness_checks <- required_submission_files |>
  dplyr::mutate(
    exists = file.exists(file),
    size_bytes = dplyr::if_else(exists, file.info(file)$size, NA_real_),
    non_empty = exists & size_bytes > 0,
    check_passed = exists & non_empty,
    readiness_status = dplyr::case_when(
      check_passed ~ "ready_for_review",
      !exists ~ "missing",
      !non_empty ~ "empty_file",
      TRUE ~ "needs_review"
    )
  )

readiness_summary <- submission_readiness_checks |>
  dplyr::count(item_type, readiness_status, name = "file_count") |>
  tidyr::complete(
    item_type,
    readiness_status = c("ready_for_review", "missing", "empty_file", "needs_review"),
    fill = list(file_count = 0)
  ) |>
  dplyr::arrange(item_type, readiness_status)

write_output_csv(
  submission_readiness_checks,
  "outputs", "tables", "submission_readiness_checks.csv"
)

write_output_csv(
  readiness_summary,
  "outputs", "tables", "submission_readiness_summary.csv"
)

if (any(!submission_readiness_checks$check_passed)) {
  failed_items <- submission_readiness_checks |>
    dplyr::filter(!check_passed) |>
    dplyr::pull(file)

  stop(
    "Submission readiness check failed for: ",
    paste(failed_items, collapse = ", "),
    call. = FALSE
  )
}
