if (!exists("birth_fertility_ts")) {
  source("scripts/01_prepare_data.R")
}

descriptive_features <- birth_fertility_ts |>
  tibble::as_tibble() |>
  dplyr::group_by(Measure) |>
  dplyr::summarise(
    first_year = min(Year),
    last_year = max(Year),
    observations = dplyr::n(),
    start_value = Observed[which.min(Year)],
    latest_value = Observed[which.max(Year)],
    minimum_value = min(Observed),
    minimum_year = Year[which.min(Observed)],
    maximum_value = max(Observed),
    maximum_year = Year[which.max(Observed)],
    mean_value = mean(Observed),
    sd_value = stats::sd(Observed),
    .groups = "drop"
  ) |>
  dplyr::mutate(
    net_change = latest_value - start_value,
    average_annual_change = net_change / (last_year - first_year)
  )

annual_change_features <- birth_fertility_ts |>
  tibble::as_tibble() |>
  dplyr::group_by(Measure) |>
  dplyr::arrange(Year, .by_group = TRUE) |>
  dplyr::mutate(annual_change = Observed - dplyr::lag(Observed)) |>
  dplyr::filter(!is.na(annual_change)) |>
  dplyr::summarise(
    largest_increase = max(annual_change),
    largest_increase_year = Year[which.max(annual_change)],
    largest_decrease = min(annual_change),
    largest_decrease_year = Year[which.min(annual_change)],
    mean_annual_change = mean(annual_change),
    sd_annual_change = stats::sd(annual_change),
    .groups = "drop"
  )

paired_series <- birth_fertility_ts |>
  tibble::as_tibble() |>
  tidyr::pivot_wider(
    names_from = Measure,
    values_from = Observed
  )

series_association <- tibble::tibble(
  comparison = "Total fertility rate and total live births",
  pearson_correlation = stats::cor(
    paired_series$`Total fertility rate`,
    paired_series$`Total live births`,
    use = "complete.obs"
  )
)

write_output_csv(
  descriptive_features,
  "outputs", "tables", "descriptive_features.csv"
)

write_output_csv(
  annual_change_features,
  "outputs", "tables", "annual_change_features.csv"
)

write_output_csv(
  series_association,
  "outputs", "tables", "series_association.csv"
)
