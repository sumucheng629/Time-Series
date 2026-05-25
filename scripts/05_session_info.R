if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

session_lines <- capture.output(sessionInfo())

readr::write_lines(
  session_lines,
  project_path("outputs", "tables", "session_info.txt")
)
