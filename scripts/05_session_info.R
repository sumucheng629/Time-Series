if (!exists("project_path")) {
  source("scripts/00_setup.R")
}

session_lines <- capture.output(sessionInfo())

write_output_lines(
  session_lines,
  "outputs", "tables", "session_info.txt"
)
