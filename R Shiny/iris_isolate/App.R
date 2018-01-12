library(datasets)
data(iris)

library(shiny)
ui <- fluidPage(
  selectInput(inputId = "var1", label = "select the column", choices=colnames(iris)),
  textInput(inputId = "text1", label = "Enter the name for Histogram", value = "Histogram"),
  plotOutput("hist")
)
server <- function(input, output){
  output$hist <- renderPlot({hist(iris[,input$var1], main = isolate(input$text1))})

}


shinyApp(ui = ui, server = server)


