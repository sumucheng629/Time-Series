if (!exists("birth_fertility_ts")) {
  source("scripts/01_prepare_data.R")
}

acf1_value <- function(x) {
  x <- stats::na.omit(x)
  if (length(x) < 3) {
    return(NA_real_)
  }
  as.numeric(stats::acf(x, lag.max = 1, plot = FALSE)$acf[2])
}

differenced_series <- birth_fertility_ts |>
  tibble::as_tibble() |>
  dplyr::group_by(Measure) |>
  dplyr::arrange(Year, .by_group = TRUE) |>
  dplyr::mutate(
    first_difference = Observed - dplyr::lag(Observed),
    second_difference = first_difference - dplyr::lag(first_difference),
    log_observed = log(Observed),
    log_difference = log_observed - dplyr::lag(log_observed)
  ) |>
  dplyr::ungroup()

stationarity_screen <- differenced_series |>
  dplyr::group_by(Measure) |>
  dplyr::summarise(
    observations = dplyr::n(),
    level_acf1 = acf1_value(Observed),
    first_difference_acf1 = acf1_value(first_difference),
    second_difference_acf1 = acf1_value(second_difference),
    log_difference_acf1 = acf1_value(log_difference),
    level_sd = stats::sd(Observed),
    first_difference_sd = stats::sd(first_difference, na.rm = TRUE),
    second_difference_sd = stats::sd(second_difference, na.rm = TRUE),
    log_difference_sd = stats::sd(log_difference, na.rm = TRUE),
    .groups = "drop"
  )

write_output_csv(
  differenced_series,
  "outputs", "tables", "differenced_series.csv"
)

write_output_csv(
  stationarity_screen,
  "outputs", "tables", "stationarity_screen.csv"
)
