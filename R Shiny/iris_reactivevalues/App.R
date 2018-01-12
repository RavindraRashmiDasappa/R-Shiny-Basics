library(datasets)
data(iris)

library(shiny)
ui <- fluidPage(
  actionButton(inputId = "button1", label = "Scatterplot"),
  plotOutput("scatter")
)
server <- function(input, output){
  rv <- reactiveValues(data = iris[,c("Sepal.Length", "Sepal.Width")])
  observeEvent(input$button1, {rv$data <- iris[,c("Petal.Length", "Petal.Width")]})
  output$scatter <- renderPlot({plot(rv$data)})

  
}


shinyApp(ui = ui, server = server)


