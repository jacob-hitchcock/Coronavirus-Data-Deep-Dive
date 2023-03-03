## Libraries
library(dplyr)
library(ggplot2)
library(lintr)

# Data
data <- read.csv("data/covid-19-data-master/colleges/colleges.csv")

#Removes values with N/A and removes unnecessary columns
colleges_df <- data[complete.cases(data), -c(1,3,5,8)]

# Function for search country plot
search_country <- function(data, search = "", xvar = "Country.Region", yvar = "X11.14.20") {
  data <- data %>%
    filter(grepl(search, Country.Region))
  if (search == "") {
    p <- ggplot(
      data = data,
      mapping = aes_string(x = xvar, y = yvar, fill = yvar)
    ) + 
      geom_col() +
      theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      guides(fill=guide_legend(title="Deaths")) +
      xlab("Country") +
      ylab("Total Deaths")
    return(p)
  } else {
    q <- ggplot(
      data = data,
      mapping = aes_string(x = xvar, y = yvar)
    ) + 
      geom_col(fill = "#5c82bf") +
      xlab("Country") +
      ylab("Total Deaths")
    return(q)
  }
}

# Function for search state plot
search_state <- function(data, search = "", xvar = "real_date", yvar = "deathIncrease"){
  data <- data %>%
    filter(grepl(search, state))
  p <- ggplot(
    data = data,
    mapping = aes_string(x = xvar, y = yvar)
  ) +
  geom_point() +
  geom_smooth(se = FALSE) +
  xlab("Date") +
  ylab("Death increase")
  return(p)
}

# Define server function
server <- function(input, output) {
  output$search_plot <- renderPlot({
    return(search_country(narrowed_deaths, input$search))
  })
  output$search_state <- renderPlot({
    return(search_state(dec, input$search_state))
  })
  output$selectedState <- renderPlot({
    #Only chooses top 10 colleges by cases
    stateColleges_df <- top_n(colleges_df[colleges_df$state == input$selectState, ], 10, wt = cases)
    
    stateColleges_plot <- ggplot(data = stateColleges_df, aes(x = reorder(college, cases), y = cases, fill = college)) + 
      geom_bar(stat = "identity") + ggtitle("Top 10 Colleges With Most Covid-19 Cases in Selected State/Territory") + coord_flip() +
      geom_text(aes(label = cases, hjust = -0.05), color = "black", size = 4.3) +
      xlab("Colleges") + ylab("Total Cases") +
      theme_minimal(base_size = 15)
    
    return(stateColleges_plot + guides(fill = F))
  })
}
