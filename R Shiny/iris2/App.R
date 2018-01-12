library(datasets)
data(iris)
library(ggplot2)
library(shiny)
#R shiny project
ui <- fluidPage(
  tabsetPanel(
    tabPanel("Scatter Plot",
  selectInput(inputId = "var1", label = "select the X column", choices=colnames(iris)),
  selectInput(inputId = "var2", label = "select the Y column", choices=colnames(iris)),
  actionButton(inputId = "button1",label = "Scatterplot"),
  plotOutput("scatter")),
  
  tabPanel("Histogram",
    fluidRow(selectInput(inputId = "var3", label = "select the column", choices=colnames(iris)),
    plotOutput("hist")),
    fluidRow(
    verbatimTextOutput("stats")
  ))
 )
)

server <- function(input,output){
  data <- eventReactive(input$button1,{iris[,c(input$var1,input$var2)]})
  output$scatter <- renderPlot({
    plot(data(), main = "Scatter plot", xlim = c(-10,10), ylim = c(-10,10),col="Blue")
  })
 output$hist <- renderPlot({hist(iris[,input$var3])})
 output$stats <- renderPrint({summary(iris[,input$var3])})
 
}

shinyApp(ui = ui, server = server)

