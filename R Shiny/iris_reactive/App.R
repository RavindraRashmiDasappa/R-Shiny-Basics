library(datasets)
data(iris)

library(shiny)
ui <- fluidPage(
  sidebarLayout(
  sidebarPanel(selectInput(inputId = "var1", label = "select the  column", choices=colnames(iris))),
  mainPanel(plotOutput("hist"),
  verbatimTextOutput("mean"),
  verbatimTextOutput("median")
       )
  )
)
server <- function(input, output){
       data <- reactive(iris[,input$var1])
       output$hist <- renderPlot({hist(data())})
       output$mean <- renderPrint({mean(data())})
       output$median <- renderPrint({median(data())})
      }
     

shinyApp(ui = ui, server = server)
  
  
