if (!exists("birth_fertility_ts")) {
  source("scripts/01_prepare_data.R")
}

transformation_series <- birth_fertility_ts |>
  tibble::as_tibble() |>
  dplyr::arrange(Measure, Year) |>
  dplyr::group_by(Measure) |>
  dplyr::mutate(
    log_observed = log(Observed),
    scaled_observed = as.numeric(scale(Observed)),
    scaled_log_observed = as.numeric(scale(log_observed)),
    period_number = dplyr::ntile(Year, 3),
    period = dplyr::case_when(
      period_number == 1L ~ "early",
      period_number == 2L ~ "middle",
      TRUE ~ "recent"
    )
  ) |>
  dplyr::ungroup() |>
  dplyr::select(-period_number)

transformation_screen <- transformation_series |>
  dplyr::group_by(Measure, period) |>
  dplyr::summarise(
    first_year = min(Year),
    last_year = max(Year),
    observations = dplyr::n(),
    min_observed = min(Observed),
    mean_observed = mean(Observed),
    sd_observed = stats::sd(Observed),
    coefficient_of_variation = sd_observed / mean_observed,
    mean_log_observed = mean(log_observed),
    sd_log_observed = stats::sd(log_observed),
    .groups = "drop"
  )

transformation_recommendation_inputs <- transformation_screen |>
  dplyr::group_by(Measure) |>
  dplyr::summarise(
    all_positive = all(min_observed > 0),
    period_cv_range = max(coefficient_of_variation) - min(coefficient_of_variation),
    log_sd_range = max(sd_log_observed) - min(sd_log_observed),
    .groups = "drop"
  ) |>
  dplyr::mutate(
    log_scale_is_available = all_positive,
    transformation_note = dplyr::case_when(
      !log_scale_is_available ~ "Log scale is not available because non-positive values are present.",
      Measure == "Total live births" ~ "Log scale is available for this count series; compare diagnostics before finalising.",
      TRUE ~ "Original scale and log scale can both be inspected; choose using diagnostics."
    )
  )

scale_comparison_plot <- transformation_series |>
  dplyr::select(Measure, Year, scaled_observed, scaled_log_observed) |>
  tidyr::pivot_longer(
    cols = c(scaled_observed, scaled_log_observed),
    names_to = "Scale",
    values_to = "ScaledValue"
  ) |>
  dplyr::mutate(
    Scale = dplyr::recode(
      Scale,
      scaled_observed = "Original scale",
      scaled_log_observed = "Log scale"
    )
  ) |>
  ggplot2::ggplot(ggplot2::aes(x = Year, y = ScaledValue, colour = Scale)) +
  ggplot2::geom_line(linewidth = 0.55) +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y", ncol = 1) +
  ggplot2::labs(
    title = "Original-scale and log-scale standardised series",
    x = "Year",
    y = "Standardised value",
    colour = NULL
  )

ggplot2::ggsave(
  project_path("outputs", "figures", "scale_comparison.png"),
  scale_comparison_plot,
  width = 8,
  height = 6,
  dpi = 320
)

write_output_csv(
  transformation_series,
  "outputs", "tables", "transformation_series.csv"
)

write_output_csv(
  transformation_screen,
  "outputs", "tables", "transformation_screen.csv"
)

write_output_csv(
  transformation_recommendation_inputs,
  "outputs", "tables", "transformation_recommendation_inputs.csv"
)
