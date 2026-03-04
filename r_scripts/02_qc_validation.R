# 02_qc_validation.R
# Example QC validation script

library(readr)
library(dplyr)

data <- read_csv("outputs/cleaned_water_quality_data.csv")

# QC checks
qc_results <- data %>%
  mutate(
    MissingValueFlag = ifelse(is.na(ResultValue), TRUE, FALSE),
    NegativeValueFlag = ifelse(ResultValue < 0, TRUE, FALSE)
  )

# Check for duplicate samples
duplicates <- data %>%
  group_by(StationID, SampleDate, Parameter) %>%
  filter(n() > 1)

# Print QC summary
cat("Total Records:", nrow(data), "\n")
cat("Missing Values:", sum(qc_results$MissingValueFlag), "\n")
cat("Negative Values:", sum(qc_results$NegativeValueFlag), "\n")
cat("Duplicate Records:", nrow(duplicates), "\n")

# Save QC output
write_csv(qc_results, "outputs/qc_results.csv")