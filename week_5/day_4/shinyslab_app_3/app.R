library(ggplot2)
library(shiny)
library(CodeClanData)
library(dplyr)

ui <- fluidPage(
    sidebarLayout( 
        sidebarPanel(
            radioButtons("plot",
                         "Plot Types",
                         choices = c( "Bar", "Pie Chart","Stacked Bar")
                        )
                    ),
            
        mainPanel(    
            plotOutput("bar_chart","pie_chart","stacked_bar")
           
            )  
        )
    )

server <- function(input, output) {
    
    output$bar_chart <- renderPlot({
        students_big %>%
            ggplot() +
            geom_bar(aes(x = gender)) 
    })
    
    output$pie_chart <- renderPlot({
         students_big %>%
            ggplot() +
            geom_bar(aes(x = 1, fill = gender)) +
            coord_polar("y")
    })
    
    output$stacked_bar <- renderPlot({
        students_big %>%
            ggplot() +
            geom_bar(aes(x = 1, fill = gender))
    })
}

shinyApp(ui = ui, server = server)