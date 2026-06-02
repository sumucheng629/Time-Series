# Work Log

## 2026-05-25

- Rebuilt the repository with an independent Git history.
- Added a reproducible script sequence for data preparation, EDA, modelling,
  forecast assessment, and session metadata.
- Expanded the README so the repository explains its current stage and how to
  rerun the analysis.
- Added data notes and a project plan to separate source documentation from the
  final report.

## 2026-05-26

- Added a descriptive summary script for long-run features, annual changes, and
  association between the two selected series.
- Added a data dictionary for the analysis-ready table and generated summary
  outputs.
- Added model candidate notes to keep the modelling plan separate from the
  final report.
- Added a data validation script so the workflow checks the cleaned time series
  before descriptive summaries and modelling.

## 2026-05-27

- Added a stationarity screening script that writes differenced series and
  simple ACF1 summaries for levels, first differences, second differences, and
  log differences.
- Added a report development checklist and output index to prepare for the next
  writing stage without drafting final conclusions.
- Added a forecast design output table so the train/holdout split is explicit
  in the generated outputs.
- Added a candidate model registry output so the comparison set is documented
  before interpreting fit statistics.
- Added a model selection evidence output that combines forecast accuracy,
  residual checks, model registry labels, and fit statistics for later review.

## 2026-05-29

- Added transformation screening outputs to compare original-scale and log-scale
  behaviour before finalising modelling choices.

## 2026-05-31

- Ran the full R workflow successfully using an ASCII working path and package
  library path.
- Committed generated analysis tables and figures.
- Added a reproducibility note for the successful run.

## 2026-06-01

- Added a Windows PowerShell helper script for rerunning the R workflow with the
  configured R executable, package library path, and temporary directory.
- Added an output manifest step to index generated tables and figures after the
  workflow runs.
- Added a results review note to summarise what should be inspected before
  drafting the final model discussion.

## 2026-06-02

- Added required-output quality checks so the workflow fails if key generated
  tables or figures are missing or empty.
- Added a figure review checklist to plan which generated plots should support
  the main report versus the statistical appendix.

## Next Commit Ideas

- Run the workflow in RStudio and commit generated tables/figures if required.
- Review model diagnostics and record which candidates are plausible.
- Start a first report draft using the student's own interpretation.
