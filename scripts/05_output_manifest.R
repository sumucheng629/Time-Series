if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

output_files <- list.files(
  project_path("outputs"),
  recursive = TRUE,
  full.names = TRUE,
  all.files = FALSE
)

output_files <- output_files[file.info(output_files)$isdir == FALSE]

output_manifest <- tibble::tibble(
  file = gsub("\\\\", "/", output_files),
  output_type = dplyr::case_when(
    grepl("^outputs/figures/", file) ~ "figure",
    grepl("^outputs/tables/", file) ~ "table",
    TRUE ~ "other"
  ),
  extension = tools::file_ext(file),
  size_bytes = file.info(output_files)$size,
  modified_time = format(file.info(output_files)$mtime, "%Y-%m-%d %H:%M:%S")
) |>
  dplyr::arrange(output_type, file)

write_output_csv(
  output_manifest,
  "outputs", "tables", "output_manifest.csv"
)
