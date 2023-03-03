## File containing functions producing first chart

## Libraries
library(dplyr)
library(ggplot2)

## Read in data set
dataset <- read.csv("data/covid-19-data-master/colleges/colleges.csv", 
                    stringsAsFactors = FALSE)

## Narrow down to desired data frame
colleges_cases <- function(data) {
  data %>%
    filter(cases > 0) %>%
    select(College = college, Cases = cases) %>%
    arrange(-Cases) %>%
    top_n(15, wt = Cases)
}

## Create and format chart
create_coll_table <- function(data) {
  ggplot(data = colleges_cases(data)) +
  geom_col(mapping = aes(x = Cases, y = reorder(College, Cases), fill = Cases)) +
  ylab("College") + 
  ggtitle("Top Colleges by Confirmed Cases")
}

## Call functions to create final table
final_chart <- create_coll_table(dataset)

