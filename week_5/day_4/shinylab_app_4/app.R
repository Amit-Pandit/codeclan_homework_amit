library(ggplot2)
library(shiny)
library(CodeClanData)
library(dplyr)

ui <- fluidPage(
    
    titlePanel("Comparing Importance of Internet Access vd. Reducing Pollution"),
    fluidRow(
        column(4,
            sidebarLayout(
            sidebarPanel(
            selectInput("gender",
                        "Gender",
                        choices = c("Male", "Female"),
                        selected = "Male"
            ),
            
            selectInput("region",
                        "Region",
                        choices = unique(students_big$region),
                        selected = "Home Counties"
            ),
            
            actionButton("update", "Generate Plots and Tables"),
            ),
            
        
    tabPanel("Plots",
        column(4,
               plotOutput("histogram1")
        ),
        column(4,
               plotOutput("histogram2")
        )
    ),
    tabPanel("Data","table_output")
        
    ),
    
    mainPanel(
        plotOutput("histogram1", "histogram2"),
        tableOutput("table_output")
            )
    
        )
    )
)
server <- function(input, output) {
    students_filtered <- eventReactive(input$update,{
        
        students_big %>%
            filter(gender == input$gender) %>%
            filter(region == input$region)
    })
    output$histogram1 <- renderPlot({
        ggplot(students_filtered()) +
            aes(x = importance_internet_access) +
            geom_histogram(gender = input$gender)
    })
    output$histogram2 <- renderPlot({
        ggplot(students_filtered()) +
            aes(x = importance_reducing_pollution) +
            geom_histogram(region = input$region)
    })
    
    output$table_output <- renderTable({
        students_big %>%
            filter(region == input$region)  %>%
            filter(gender == input$gender) %>%
            filter(importance_internet_access == input$importance_internet_access) %>%
            filter(importance_reducing_pollution == input$importance_reducing_pollution)
    })
}  

shinyApp(ui = ui, server = server)    