# 03_summary_statistics.R
# Example summary statistics generation

library(readr)
library(dplyr)

data <- read_csv("outputs/qc_results.csv")

summary_stats <- data %>%
  group_by(StationID, Parameter) %>%
  summarize(
    SampleCount = n(),
    MeanValue = mean(ResultValue, na.rm = TRUE),
    MinValue = min(ResultValue, na.rm = TRUE),
    MaxValue = max(ResultValue, na.rm = TRUE)
  )

print(summary_stats)

# Save summary output
write_csv(summary_stats, "outputs/summary_statistics.csv")