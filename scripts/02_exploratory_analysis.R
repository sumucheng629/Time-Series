if (!exists("birth_fertility_ts")) {
  source("scripts/01_prepare_data.R")
}

history_plot <- birth_fertility_ts |>
  ggplot2::autoplot(Observed) +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y", ncol = 1) +
  ggplot2::labs(
    title = "Annual Singapore fertility and birth series",
    x = "Year",
    y = NULL
  )

ggplot2::ggsave(
  project_path("outputs", "figures", "annual_series_overview.png"),
  history_plot,
  width = 8,
  height = 6,
  dpi = 320
)

level_acf_plot <- birth_fertility_ts |>
  feasts::ACF(Observed, lag_max = 18) |>
  ggplot2::autoplot() +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y") +
  ggplot2::labs(title = "Autocorrelation in the original series")

ggplot2::ggsave(
  project_path("outputs", "figures", "level_acf.png"),
  level_acf_plot,
  width = 8,
  height = 4.8,
  dpi = 320
)

annual_changes <- birth_fertility_ts |>
  dplyr::group_by_key() |>
  dplyr::mutate(annual_change = difference(Observed)) |>
  dplyr::ungroup() |>
  dplyr::filter(!is.na(annual_change))

change_plot <- annual_changes |>
  ggplot2::ggplot(ggplot2::aes(x = Year, y = annual_change)) +
  ggplot2::geom_hline(yintercept = 0, linewidth = 0.35, colour = "grey55") +
  ggplot2::geom_col(fill = "#3b6ea8", alpha = 0.85) +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y", ncol = 1) +
  ggplot2::labs(
    title = "Year-to-year changes",
    x = "Year",
    y = "First difference"
  )

ggplot2::ggsave(
  project_path("outputs", "figures", "annual_first_differences.png"),
  change_plot,
  width = 8,
  height = 6,
  dpi = 320
)

change_acf_plot <- annual_changes |>
  feasts::ACF(annual_change, lag_max = 18) |>
  ggplot2::autoplot() +
  ggplot2::facet_wrap(ggplot2::vars(Measure), scales = "free_y") +
  ggplot2::labs(title = "Autocorrelation after first differencing")

ggplot2::ggsave(
  project_path("outputs", "figures", "first_difference_acf.png"),
  change_acf_plot,
  width = 8,
  height = 4.8,
  dpi = 320
)

readr::write_csv(
  tibble::as_tibble(annual_changes),
  project_path("outputs", "tables", "annual_first_differences.csv")
)
