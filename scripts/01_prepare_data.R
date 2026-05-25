if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

target_rows <- c("Total Fertility Rate (TFR)", "Total Live-Births")

birth_fertility_raw <- readr::read_csv(
  project_path("data", "raw", "BirthsAndFertilityRatesAnnual.csv"),
  show_col_types = FALSE
)

birth_fertility_ts <- birth_fertility_raw |>
  dplyr::mutate(DataSeries = stringr::str_squish(DataSeries)) |>
  dplyr::filter(DataSeries %in% target_rows) |>
  tidyr::pivot_longer(
    cols = -DataSeries,
    names_to = "Year",
    values_to = "Observed"
  ) |>
  dplyr::mutate(
    Year = as.integer(Year),
    Observed = readr::parse_number(as.character(Observed)),
    Measure = dplyr::case_when(
      DataSeries == "Total Fertility Rate (TFR)" ~ "Total fertility rate",
      DataSeries == "Total Live-Births" ~ "Total live births",
      TRUE ~ DataSeries
    )
  ) |>
  dplyr::filter(!is.na(Year), !is.na(Observed)) |>
  dplyr::arrange(Measure, Year) |>
  dplyr::select(Measure, Year, Observed) |>
  tsibble::as_tsibble(key = Measure, index = Year)

series_summary <- birth_fertility_ts |>
  tibble::as_tibble() |>
  dplyr::group_by(Measure) |>
  dplyr::summarise(
    first_year = min(Year),
    last_year = max(Year),
    observations = dplyr::n(),
    first_observation = Observed[which.min(Year)],
    latest_observation = Observed[which.max(Year)],
    .groups = "drop"
  )

readr::write_csv(
  tibble::as_tibble(birth_fertility_ts),
  project_path("outputs", "tables", "clean_birth_fertility_series.csv")
)

readr::write_csv(
  series_summary,
  project_path("outputs", "tables", "series_summary.csv")
)
