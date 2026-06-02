if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

required_outputs <- c(
  "outputs/tables/data_validation_checks.csv",
  "outputs/tables/forecast_design.csv",
  "outputs/tables/holdout_forecast_accuracy.csv",
  "outputs/tables/model_selection_evidence.csv",
  "outputs/tables/output_manifest.csv",
  "outputs/figures/annual_series_overview.png",
  "outputs/figures/candidate_residual_acf.png",
  "outputs/figures/holdout_forecast_comparison.png",
  "outputs/figures/five_year_candidate_forecasts.png"
)

output_quality_checks <- tibble::tibble(
  file = required_outputs,
  exists = file.exists(required_outputs),
  size_bytes = ifelse(exists, file.info(required_outputs)$size, NA_real_),
  non_empty = exists & size_bytes > 0,
  check_passed = exists & non_empty
)

write_output_csv(
  output_quality_checks,
  "outputs", "tables", "output_quality_checks.csv"
)

if (any(!output_quality_checks$check_passed)) {
  stop(
    "One or more required workflow outputs are missing or empty.",
    call. = FALSE
  )
}
