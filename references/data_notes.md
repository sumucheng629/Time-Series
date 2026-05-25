# Data Notes

## Source File

The analysis uses `data/raw/BirthsAndFertilityRatesAnnual.csv`.

The file is in wide format: each row is a demographic series and each year is a
separate column. The R workflow reshapes this into a long tsibble with one row
per measure and year.

## Series Used

The current workflow selects:

- `Total Fertility Rate (TFR)`
- `Total Live-Births`

Other age-specific fertility rows are kept in the raw file but are not used in
the main workflow at this stage.

## Cleaning Decisions

- Year columns are converted from character names into integer years.
- Values are parsed as numeric observations.
- Series names are trimmed before filtering.
- Missing or non-year columns are excluded from the modelling dataset.

## Points To Check Before Final Submission

- Confirm whether the latest year should be included in the final modelling
  window.
- Confirm the official data source wording required by the course.
- Check whether total live births should be modelled on the original scale or
  transformed scale before final model selection.
