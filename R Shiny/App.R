library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "num", label = "choose a number", value = 25, min = 1, max= 100),
  textInput(inputId = "title",label = "write title", value = "histogram"),
  plotOutput ("hist")
  
)

server <- function(input,output){
  
  output$hist = renderPlot({
                       hist(rnorm(input$num),main = isolate(input$title))
                  })
  
}

shinyApp(ui = ui,server = server)