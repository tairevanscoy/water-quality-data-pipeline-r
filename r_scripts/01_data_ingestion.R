# 01_data_ingestion.R
# Example data ingestion script for environmental monitoring data

library(readr)
library(dplyr)

# Read sample dataset
data <- read_csv("example_data/water_quality_sample.csv")

# Standardize column names
data_clean <- data %>%
  rename(
    StationID = station_id,
    SampleDate = sample_date,
    Parameter = parameter,
    ResultValue = result_value,
    Units = units
  )

# Convert SampleDate to proper datetime
data_clean <- data_clean %>%
  mutate(SampleDate = as.POSIXct(SampleDate))

# Preview cleaned data
print(head(data_clean))

# Save cleaned dataset
write_csv(data_clean, "outputs/cleaned_water_quality_data.csv")
