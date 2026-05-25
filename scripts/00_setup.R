required_packages <- c(
  "readr",
  "dplyr",
  "tidyr",
  "tibble",
  "ggplot2",
  "tsibble",
  "fable",
  "feasts",
  "fabletools",
  "stringr"
)

missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing_packages) > 0) {
  stop(
    "Install missing packages before running the workflow: ",
    paste(missing_packages, collapse = ", "),
    call. = FALSE
  )
}

invisible(lapply(required_packages, library, character.only = TRUE))

project_path <- function(...) {
  file.path(getwd(), ...)
}

ensure_output_dir <- function(...) {
  dir.create(project_path(...), recursive = TRUE, showWarnings = FALSE)
}

ensure_output_dir("outputs", "figures")
ensure_output_dir("outputs", "tables")

theme_set(
  theme_minimal(base_size = 11) +
    theme(
      panel.grid.minor = element_blank(),
      plot.title.position = "plot",
      strip.text = element_text(face = "bold")
    )
)
