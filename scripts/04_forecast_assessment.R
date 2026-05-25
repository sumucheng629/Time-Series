if (!exists("candidate_fits")) {
  source("scripts/03_model_comparison.R")
}

holdout_forecasts <- candidate_fits |>
  fabletools::forecast(new_data = analysis_test)

forecast_accuracy <- fabletools::accuracy(holdout_forecasts, analysis_test) |>
  dplyr::arrange(Measure, RMSE)

best_holdout_models <- forecast_accuracy |>
  dplyr::group_by(Measure) |>
  dplyr::slice_min(RMSE, n = 1, with_ties = FALSE) |>
  dplyr::ungroup()

holdout_plot <- holdout_forecasts |>
  ggplot2::autoplot(analysis_train, level = 80) +
  ggplot2::autolayer(analysis_test, Observed, colour = "black", linewidth = 0.45) +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y", ncol = 1) +
  ggplot2::labs(
    title = "Holdout-period forecasts",
    x = "Year",
    y = NULL
  )

ggplot2::ggsave(
  project_path("outputs", "figures", "holdout_forecast_comparison.png"),
  holdout_plot,
  width = 9,
  height = 6.5,
  dpi = 320
)

final_candidate_fits <- birth_fertility_ts |>
  fabletools::model(
    naive = fable::NAIVE(Observed),
    drift = fable::RW(Observed ~ drift()),
    linear_trend = fable::TSLM(Observed ~ trend()),
    auto_arima = fable::ARIMA(Observed),
    ets = fable::ETS(Observed)
  )

five_year_forecasts <- final_candidate_fits |>
  fabletools::forecast(h = 5)

future_plot <- five_year_forecasts |>
  ggplot2::autoplot(birth_fertility_ts, level = c(80, 95)) +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y", ncol = 1) +
  ggplot2::labs(
    title = "Five-year forecasts from refitted candidate models",
    x = "Year",
    y = NULL
  )

ggplot2::ggsave(
  project_path("outputs", "figures", "five_year_candidate_forecasts.png"),
  future_plot,
  width = 9,
  height = 6.5,
  dpi = 320
)

readr::write_csv(
  forecast_accuracy,
  project_path("outputs", "tables", "holdout_forecast_accuracy.csv")
)

readr::write_csv(
  best_holdout_models,
  project_path("outputs", "tables", "best_holdout_models.csv")
)
