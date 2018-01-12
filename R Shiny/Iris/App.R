library(datasets)
data(iris)

library(shiny)
#R shiny project
ui <- fluidPage(
         selectInput(inputId = "var1", label = "select the X column", choices=colnames(iris)),
         selectInput(inputId = "var2", label = "select the Y column", choices=colnames(iris)),
         plotOutput("scatter")
)

server <- function(input,output){
           output$scatter <- renderPlot({
                plot(iris[,input$var1],iris[,input$var2], main = "Scatter plot", xlim = c(-10,10), ylim = c(-10,10),col="Blue")
              })
  
}

shinyApp(ui = ui, server = server)

         