## File containing functions producing table of summary info

## Libraries
library(dplyr)
library(lubridate)

## Read in data
dataset <- read.csv("data/national-history.csv", stringsAsFactors = FALSE)

## Create narrowed down data frame
death_case_table <- function(data) {
  data %>%
    mutate(month_year = format(as.Date(date), "%Y-%m")) %>%
    group_by(Month = month_year) %>%
    summarize(Deaths = sum(death, na.rm = TRUE))
}

final_table <- death_case_table(dataset)