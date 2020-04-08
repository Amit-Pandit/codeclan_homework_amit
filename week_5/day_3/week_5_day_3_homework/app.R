library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinythemes)
ui <- fluidPage(
    theme = shinytheme("slate"),
    titlePanel(tags$b("Distribution of top 5 countries winning Olympic Medals ")),
    fluidRow(
        column(6,
            radioButtons("season",
                         tags$i("Summer or Winter Olympics?"),
                         choices = c("Summer", "Winter")
               )
            ),
        column(6,
            radioButtons("medal",
                         tags$i("Medals Won?"),
                         choices = c("Gold", "Silver", "Bronze")
            )
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Plot", plotOutput("medal_plot")),
                tabPanel("Website ", tags$a("Click Here to be diverted to the official Olympics Website", href = "https://www.olympic.org/")) 
    )
    )
)

)
server <- function(input, output) {
    output$medal_plot <- renderPlot({
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = team, y = count) +
            geom_col()
    })
}
shinyApp(ui = ui, server = server)
