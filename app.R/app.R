

library(shiny)
library(tidyverse)
library(googlesheets4)
library(bslib)

df <- read_sheet("https://docs.google.com/spreadsheets/d/1bV5oIjOFwZYxEFU9NvOksjaCMsO1-4OXFUBMSmKrah4/edit#gid=0",
                 col_types = "icDiii") |> 
  drop_na() |> 
  mutate(volume = repetitions*weight)
  


# Define UI for application
ui <- page_sidebar(
  title = "Fitness Dashboard",
  sidebar = sidebar(
    title = "Filters",
    selectInput(
      "technique", "Which lifting technique do you want to visualize?",
      sort(unique(df$technique)),
      multiple = TRUE),
    dateRangeInput("dates", "Which dates do you want to visualize?",
                   start = "2022-03-07",
                   end = "2023-10-06")),
  card(
    card_header("Are there changes in weight lifted over time?"),
    plotOutput("plot")
  )
)

# Define server logic 
server <- function(input, output) {

  selected <- reactive(
    df |> 
      filter(date >= input$dates[1] & date <= input$dates[2]) |> 
      filter(technique %in% input$technique)
  )
  
  output$plot <- renderPlot(
    
    ggplot(selected(),
                        aes(x = date, y = weight, color = technique)) +
    geom_point() +
    theme_bw() +
    geom_line() +
    facet_wrap(~ set)
  )
}

# Run the application 
shinyApp(ui, server)
