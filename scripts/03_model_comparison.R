if (!exists("birth_fertility_ts")) {
  source("scripts/01_prepare_data.R")
}

latest_year <- max(birth_fertility_ts$Year)
holdout_start <- latest_year - 9L

analysis_train <- birth_fertility_ts |>
  dplyr::filter(Year < holdout_start)

analysis_test <- birth_fertility_ts |>
  dplyr::filter(Year >= holdout_start)

candidate_fits <- analysis_train |>
  fabletools::model(
    naive = fable::NAIVE(Observed),
    drift = fable::RW(Observed ~ drift()),
    linear_trend = fable::TSLM(Observed ~ trend()),
    auto_arima = fable::ARIMA(Observed),
    ets = fable::ETS(Observed)
  )

fit_statistics <- fabletools::glance(candidate_fits)

model_terms <- tryCatch(
  fabletools::tidy(candidate_fits),
  error = function(error) {
    tibble::tibble(note = conditionMessage(error))
  }
)

model_residuals <- fabletools::augment(candidate_fits)

residual_ljung_box <- model_residuals |>
  feasts::features(.innov, feasts::ljung_box, lag = 10, dof = 0)

residual_time_plot <- model_residuals |>
  ggplot2::ggplot(ggplot2::aes(x = Year, y = .innov)) +
  ggplot2::geom_hline(yintercept = 0, linewidth = 0.35, colour = "grey55") +
  ggplot2::geom_line(colour = "#9b4d1f", linewidth = 0.45) +
  ggplot2::facet_grid(Measure ~ .model, scales = "free_y") +
  ggplot2::labs(
    title = "One-step residuals from candidate models",
    x = "Year",
    y = "Innovation"
  )

ggplot2::ggsave(
  project_path("outputs", "figures", "candidate_model_residuals.png"),
  residual_time_plot,
  width = 11,
  height = 6.5,
  dpi = 320
)

residual_acf_plot <- model_residuals |>
  feasts::ACF(.innov, lag_max = 14) |>
  ggplot2::autoplot() +
  ggplot2::facet_grid(Measure ~ .model) +
  ggplot2::labs(title = "Residual autocorrelation by model")

ggplot2::ggsave(
  project_path("outputs", "figures", "candidate_residual_acf.png"),
  residual_acf_plot,
  width = 11,
  height = 6.5,
  dpi = 320
)

readr::write_csv(
  fit_statistics,
  project_path("outputs", "tables", "candidate_model_fit_statistics.csv")
)

readr::write_csv(
  model_terms,
  project_path("outputs", "tables", "candidate_model_terms.csv")
)

readr::write_csv(
  residual_ljung_box,
  project_path("outputs", "tables", "residual_ljung_box_tests.csv")
)
