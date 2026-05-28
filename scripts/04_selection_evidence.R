if (!exists("forecast_accuracy")) {
  source("scripts/04_forecast_assessment.R")
}

residual_diagnostics <- residual_ljung_box |>
  tibble::as_tibble()

if ("lb_stat" %in% names(residual_diagnostics)) {
  residual_diagnostics <- residual_diagnostics |>
    dplyr::rename(ljung_box_statistic = lb_stat)
}

if ("lb_pvalue" %in% names(residual_diagnostics)) {
  residual_diagnostics <- residual_diagnostics |>
    dplyr::rename(ljung_box_p_value = lb_pvalue)
}

if (!"ljung_box_statistic" %in% names(residual_diagnostics)) {
  residual_diagnostics$ljung_box_statistic <- NA_real_
}

if (!"ljung_box_p_value" %in% names(residual_diagnostics)) {
  residual_diagnostics$ljung_box_p_value <- NA_real_
}

fit_columns <- c("Measure", ".model", "AIC", "AICc", "BIC")

fit_evidence <- fit_statistics |>
  tibble::as_tibble() |>
  dplyr::select(dplyr::any_of(fit_columns))

model_selection_evidence <- forecast_accuracy |>
  tibble::as_tibble() |>
  dplyr::left_join(
    candidate_model_registry,
    by = c(".model" = "model")
  ) |>
  dplyr::left_join(
    fit_evidence,
    by = c("Measure", ".model")
  ) |>
  dplyr::left_join(
    residual_diagnostics |>
      dplyr::select(
        Measure,
        .model,
        ljung_box_statistic,
        ljung_box_p_value
      ),
    by = c("Measure", ".model")
  ) |>
  dplyr::group_by(Measure) |>
  dplyr::mutate(
    rmse_rank = dplyr::min_rank(RMSE),
    mae_rank = dplyr::min_rank(MAE),
    residual_pass_ljung_box_0_05 = ljung_box_p_value > 0.05,
    review_flag = dplyr::case_when(
      rmse_rank == 1 & residual_pass_ljung_box_0_05 ~ "accuracy_and_residuals",
      rmse_rank == 1 ~ "accuracy_only",
      rmse_rank <= 2 ~ "secondary_candidate",
      TRUE ~ "lower_priority"
    )
  ) |>
  dplyr::ungroup() |>
  dplyr::arrange(Measure, rmse_rank, mae_rank)

readr::write_csv(
  model_selection_evidence,
  project_path("outputs", "tables", "model_selection_evidence.csv")
)
