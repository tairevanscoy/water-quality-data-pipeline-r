# run_all.R
# Runs the full workflow

source("r_scripts/01_data_ingestion.R")
source("r_scripts/02_qc_validation.R")
source("r_scripts/03_summary_statistics.R")

cat("Pipeline completed successfully.\n")