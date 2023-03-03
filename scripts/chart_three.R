## File containing functions producing the third chart
library("ggplot2")
library("tidyr")
library("dplyr")

CONVENIENT_global_deaths <- read.csv("data/archive/CONVENIENT_global_deaths.csv", header = T)

sum_df <- CONVENIENT_global_deaths[-c(1),]

date_df <- sum_df[,c("Country.Region", "US", "Brazil", "India", "Mexico", "United.Kingdom.10")]

names(date_df) <- c("Date", "US", "Brazil", "India", "Mexico", "United.Kingdom")

date2_df <- date_df %>% gather(Date, Country)

date2_df$test <- rep(c(1:297), 5)

names(date2_df) <- c("Country", "Deaths", "Day")

third_plot <- ggplot(data = date2_df, aes(x = Day, y = Deaths, 
                                          group = Country, color = Country)) + geom_line() +
                                          ggtitle("Deaths Per Day")

