

library(shiny)
library(tidyverse)
library(googlesheets4)

df <- read_sheet("https://docs.google.com/spreadsheets/d/1bV5oIjOFwZYxEFU9NvOksjaCMsO1-4OXFUBMSmKrah4/edit#gid=0",
                 col_types = "icDiii") |> 
  drop_na() |> 
  mutate(volume = repetitions*weight)
  






# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  
  # ggplot(df |> 
  #            drop_na() |>  
  #            mutate(volume = repetitions*weight) |>  
  #            ggplot(aes(x = date, y = volume, color = technique)) +
  #            geom_point() +
  #            geom_line() +
  #            theme_bw() +
  #            facet_wrap(~ set))
  
    
}

# Run the application 
shinyApp(ui = ui, server = server)
