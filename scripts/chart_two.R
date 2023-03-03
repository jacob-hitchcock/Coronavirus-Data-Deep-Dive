## File containing functions producing second chart
library("ggplot2")
library("tidyr")
library("dplyr")

CONVENIENT_global_deaths <- read.csv("data/archive/CONVENIENT_global_deaths.csv", header = T)

sum_df <- CONVENIENT_global_deaths[-c(1),]

sum1_df <- gather(sum_df, Country, Country.Region)

names(sum1_df) <- c("Country", "Deaths")

sum1_df$Deaths <- as.numeric(sum1_df$Deaths)

sum2_df <- sum1_df

sum2_df <- sum2_df %>% 
  group_by(Country) %>% 
  summarise_all(sum)

sum3_df <- top_n(sum2_df, 10, wt = Deaths)

sum3_df[3, 1] <- "France"

sum3_df[9, 1] <- "United.Kingdom"

countries_plot <- ggplot(data = sum3_df, aes(x = Country, y = Deaths)) + 
  geom_bar(stat = "identity") + ggtitle("Top Countries by Total Confirmed Cases")
