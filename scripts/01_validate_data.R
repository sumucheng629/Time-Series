if (!exists("birth_fertility_ts")) {
  source("scripts/01_prepare_data.R")
}

expected_measures <- c("Total fertility rate", "Total live births")

clean_table <- birth_fertility_ts |>
  tibble::as_tibble()

duplicate_keys <- clean_table |>
  dplyr::count(Measure, Year) |>
  dplyr::filter(n > 1)

year_gaps <- clean_table |>
  dplyr::arrange(Measure, Year) |>
  dplyr::group_by(Measure) |>
  dplyr::summarise(
    has_gap = any(diff(Year) != 1),
    .groups = "drop"
  )

validation_checks <- tibble::tibble(
  check = c(
    "expected_measures_present",
    "no_missing_values",
    "no_duplicate_measure_year_keys",
    "annual_years_are_consecutive",
    "positive_observations",
    "minimum_history_length"
  ),
  passed = c(
    setequal(unique(clean_table$Measure), expected_measures),
    !any(is.na(clean_table$Observed)),
    nrow(duplicate_keys) == 0,
    !any(year_gaps$has_gap),
    all(clean_table$Observed > 0),
    all(table(clean_table$Measure) >= 30)
  ),
  detail = c(
    paste(sort(unique(clean_table$Measure)), collapse = "; "),
    paste(sum(is.na(clean_table$Observed)), "missing observations"),
    paste(nrow(duplicate_keys), "duplicate keys"),
    paste(sum(year_gaps$has_gap), "series with non-consecutive years"),
    paste(sum(clean_table$Observed <= 0, na.rm = TRUE), "non-positive observations"),
    paste("minimum observations per measure:", min(table(clean_table$Measure)))
  )
)

readr::write_csv(
  validation_checks,
  project_path("outputs", "tables", "data_validation_checks.csv")
)

if (any(!validation_checks$passed)) {
  stop(
    "Data validation failed. See outputs/tables/data_validation_checks.csv.",
    call. = FALSE
  )
}
