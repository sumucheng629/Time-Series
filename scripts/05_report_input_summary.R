if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

validation_status <- if (exists("validation_checks")) {
  if (all(validation_checks$passed)) "all_validation_checks_passed" else "review_validation_failures"
} else {
  "validation_table_not_loaded"
}

output_status <- if (exists("output_quality_checks")) {
  if (all(output_quality_checks$check_passed)) "required_outputs_present" else "review_missing_outputs"
} else {
  "output_quality_table_not_loaded"
}

holdout_window <- if (exists("forecast_design")) {
  holdout_rows <- forecast_design |>
    dplyr::filter(sample == "holdout")

  paste(
    min(holdout_rows$first_year),
    max(holdout_rows$last_year),
    sep = "-"
  )
} else {
  "forecast_design_not_loaded"
}

top_accuracy_models <- if (exists("model_selection_evidence")) {
  model_selection_evidence |>
    dplyr::filter(rmse_rank == 1) |>
    dplyr::arrange(Measure) |>
    dplyr::mutate(summary = paste(Measure, .model, review_flag, sep = ": ")) |>
    dplyr::pull(summary) |>
    paste(collapse = " | ")
} else {
  "model_selection_evidence_not_loaded"
}

report_input_summary <- tibble::tibble(
  item = c(
    "data_validation",
    "required_outputs",
    "holdout_window",
    "top_accuracy_models",
    "drafting_warning"
  ),
  status = c(
    validation_status,
    output_status,
    holdout_window,
    top_accuracy_models,
    "use_as_planning_input_not_final_prose"
  )
)

write_output_csv(
  report_input_summary,
  "outputs", "tables", "report_input_summary.csv"
)
