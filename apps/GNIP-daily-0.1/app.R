
# This is the RStudio sample code, with the GNIP data instead of "Old Faithful" sample data. 

# Libraries
library(shiny)
library(rsconnect)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("GNIP Histograms"),

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
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- waters.app$O18 
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = '#66CCEE', border = 'white',
             xlab = expression(paste(delta^{18}, "O (‰ VSMOW)")),
             main = NULL)
    })
}

# Load and clean data 
waters.all <- read.csv("GNIP-daily_2010-2020.csv")
waters.app <- waters.all %>% drop_na(O18)

# Run the application 
shinyApp(ui = ui, server = server)
