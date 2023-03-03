# Libraries
library(shiny)
library(dplyr)
library(lintr)
library(ggplot2)

# Summary Tab Definition
summary_tab <- tabPanel(
  "Project Summary",
  titlePanel("The Coronavirus Data Deep Dive"),
  p("With the explosion of the COVID-19 pandemic, it is vital to understand the severity of this outbreak and 
    it's effect on a variety of aspects. With it's impacts being felt worldwide and roughly 54 million cases confirmed, 
    an abundance of data surrounding the Coronavirus has been made available. We have decided to take a deep dive into the 
    data and explore things such as total cases and deaths, which areas a being impacted the most, and who is performing the 
    best in limiting cases. We are using datasets from John Hopkins University, The COVID Tracking Project, and the NY Times, 
    all of which summarize different pieces of data surrounding COVID-19."),
  em("Our primary objectives are to find the sum of deaths due to Covid, the College with most confirmed cases, as well how the
     deaths per day are increasing in each State"),
  img(src = "https://cosmosgroup.sgp1.cdn.digitaloceanspaces.com/thumbnail/lead/news/5391834_4530040_4966703_cover%20pic.png", width = 864, height = 576),
  align = "center"
)

# Search country data frame (Source working directory)
raw_deaths <- read.csv("data/archive/RAW_global_deaths.csv")
narrowed_deaths <- raw_deaths %>%
  select(Country.Region,
         X11.14.20)

# Search country sidebar panel
search_country_panel <- sidebarPanel(
  # Chosen Country
  helpText("Enter a Correctly-Cased Country Name"),
  textInput("search", label = "Country", value = ""),
  # page purpose
  h4("Chart Use & Purpose:"),
  p("The purpose of this chart is to explore the impact that COVID-19 has had on different Countries. Explore the starting chart to see how the
      deaths across the globe compare or type in a specific country to see that country's number of Coronavirus deaths.")
)

# Search country main chart element
plot_search_country <- mainPanel(
  plotOutput("search_plot")
)

# Search Country tab definition
# Define search Panel
search_country_tab <- tabPanel(
  "Search Total Country Deaths",
  titlePanel("Total Deaths In Different Countries (As of 11/14/20)"),
  
  # A `sidebarLayout()` that contains...
  sidebarLayout(
    # input sidebar element
    search_country_panel,
    # main chart element
    plot_search_country
    )
)

# Search state Dataframe
dataframe <- read.csv("data/all-states-history.csv", stringsAsFactors = FALSE)
dec <- dataframe %>%
  head(448) %>%
  mutate(real_date = as.Date(date)) %>%
  select(real_date, state, deathIncrease)

# Search State Sidebar Panel
panal <- sidebarPanel(
  helpText("Enter the US state abbreviation in caps."),
  textInput("search_state", label = "State Abbreviation", value = ""),
  h4("Chart Use & Purpose:"),
  p("The purpose of this chart is to explore the impact that COVID-19 has had on different States. Explore the starting chart to see how the
    rise in deaths across the US compare or type in a specific State abbreviation to see that state's number of Coronavirus deaths increase since
    just the start of December 2020.")
)

# Search main panel
main_search_state <- mainPanel(
  plotOutput("search_state")
)

# Search state tab definition
search_state_tab <- tabPanel(
  "Search State Death Increases",
  titlePanel("Death Increase of each States in December 2020"),
  sidebarLayout(
    panal,
    main_search_state
  )
)

# Colleges Side Panel
colleges_sidebar <- sidebarPanel(
  helpText("Choose a state to see College figures from that state"),
  selectInput(
    inputId = "selectState",
    label = h4("Choose State/Territory"),
    choices = list("Alabama" = "Alabama",
                   "Alaska" = "Alaska",
                   "American Samoa" = "American Samoa",
                   "Arizona" = "Arizona",
                   "Arkansas" = "Arkansas",
                   "California" = "California",
                   "Colorado" = "Colorado",
                   "Connecticut" = "Connecticut",
                   "Delaware" = "Delaware",
                   "Florida" = "Florida",
                   "Georgia" = "Georgia",
                   "Guam" = "Guam",
                   "Hawaii" = "Hawaii",
                   "Idaho" = "Idaho",
                   "Illinois" = "Illinois",
                   "Indiana" = "Indiana",
                   "Iowa" = "Iowa",
                   "Kansas" = "Kansas",
                   "Kentucky" = "Kentucky",
                   "Louisiana" = "Louisiana",
                   "Maine" = "Maine",
                   "Marshall Islands" = "Marshall Islands",
                   "Maryland" = "Maryland",
                   "Massachusetts" = "Massachusetts",
                   "Michigan" = "Michigan",
                   "Minnesota" = "Minnesota",
                   "Mississippi" = "Mississippi",
                   "Missouri" = "Missouri",
                   "Montana" = "Montana",
                   "Nebraska" = "Nebraska",
                   "Nevada" = "Nevada",
                   "New Hampshire" = "New Hampshire",
                   "New Jersey" = "New Jersey",
                   "New Mexico" = "New Mexico",
                   "New York" = "New York",
                   "North Carolina" = "North Carolina",
                   "North Dakota" = "North Dakota",
                   "Northern Mariana Islands" = "Northern Mariana Islands",
                   "Ohio" = "Ohio",
                   "Oklahoma" = "Oklahoma",
                   "Oregon" = "Oregon",
                   "Pennsylvania" = "Pennsylvania",
                   "Puerto Rico" = "Puerto Rico",
                   "Rhode Island" = "Rhode Island",
                   "South Carolina" = "South Carolina",
                   "South Dakota" = "South Dakota",
                   "Tennessee" = "Tennessee",
                   "Texas" = "Texas",
                   "Utah" = "Utah",
                   "Vermont" = "Vermont",
                   "Virgin Islands" = "Virgin Islands",
                   "Virginia" = "Virginia",
                   "Washington, D.C." = "Washington, D.C.",
                   "Washington" = "Washington",
                   "West Virginia" = "West Virginia",
                   "Wisconsin" = "Wisconsin",
                   "Wyoming" = "Wyoming")
    ),
  h4("Chart Use & Purpose:"),
  p("The purpose of this chart is to explore the impact that COVID-19 has had on the colleges within the US. Too often, the narrative that the younger
    generations are unaffected and sometimes immune from COVID-19 is dangerously spread. Use this chart to see how Coronavirus has made it's way within
    the colleges of America")
)

# Colleges main panel
colleges_main <- mainPanel(
  plotOutput("selectedState")
)

# Colleges tab definition
colleges_tab <- tabPanel(
  "COVID-19 in US Colleges",
  titlePanel("Top 10 Colleges in US States by Confirmed Cases"),
  sidebarLayout(
    colleges_sidebar,
    colleges_main
  )
)

# Takeaway Tab Definition
takeaway_tab <- tabPanel(
  "Major Takeaways",
  titlePanel("Our Findings"),
  p("1) When exploring these charts, as well as charts in previous projects, one country is clearly leading the pack in both cases and deaths. The 
    United States has seen an extremely quick spread of the Coronavirus and this has had a major impact on many aspects within the country."),
  p("2) Within the US, while the number of deaths did see a dip, the number of deaths is now back on the rise. This could be due to a variety of reasons
    such as lack of regulation and enforcement, false hope that the pandemic was over, and the inability for leaders to take charge and agree in curbing the
    spread of the virus"),
  p("3) While often times, it is said that younger generations shouldn't need to worry about the impacts of COVID-19, from these charts you can see that
    students can get the virus. Not only this, but once contracted they are likely to spread it to other friends and older family members."),
  img(src="https://image.cnbcfm.com/api/v1/image/106392012-1581694783947rts31810.jpg?v=1582031502", width = 864, height = 576),
  align = "center"
)

# UI element
ui <- navbarPage(
  "The COVID-19 Pandemic Exploration",
  summary_tab,
  search_country_tab,
  search_state_tab,
  colleges_tab,
  takeaway_tab
)
  