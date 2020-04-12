library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)

ui <- fluidPage(

    titlePanel("Height and Arm Span Vs Age"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("age_meter",
                         "age",
                         choices = c(10,11,12,13,14,15,16,17,18),inline = TRUE)
                     ),
                  
            
            mainPanel(
                plotOutput("height_plot"),
                plotOutput("armspan_plot")
            )
    
    )
    
)
        
    server <- function(input, output) {
        output$height_plot <- renderPlot({
            students_big %>%
                filter(ageyears == input$age_meter) %>%
                ggplot() +
                aes(x = height) +
                geom_histogram()
        })
        
        output$armspan_plot <- renderPlot({
            students_big %>%
                filter(ageyears == input$age_meter) %>%
                ggplot() +
                aes(x = arm_span) +
                geom_histogram()
        })
}

shinyApp(ui = ui, server = server)