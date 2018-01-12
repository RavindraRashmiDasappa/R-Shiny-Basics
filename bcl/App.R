bcl <- read.csv("/Users/rahmi/Desktop/KDD/R\ Shiny\ /bcl-data.csv", stringsAsFactors = FALSE)

library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
          titlePanel("BC Liquor Store prices"),
          img(src="the-liquor-company-beer-wine-and-liquor-85137531.jpg"),
          sidebarLayout(
            sidebarPanel(
              sliderInput(inputId = "priceInput",label = "Set the price min and max",value = c(20,35), min = 1, max = 100, pre = "$"),
              radioButtons("typeInput", "Product type",
                           sort(unique(bcl$Type)), selected = "WINE"),
              selectInput("countryInput", "Country",
                          sort(unique(bcl$Country)), selected = "CANADA"),
              checkboxInput(inputId = "sortpriceInput", label = "Sort Price?")
              
            )
            
          ,
          mainPanel(
            plotOutput("output1"),
            tableOutput("output2")
          )
        )
)
server <- function(input, output){

  output$output1 <- renderPlot({
       filtered <- bcl %>% 
                   filter(Price >= input$priceInput[1],
                          Price <= input$priceInput[2],
                          Type == input$typeInput,
                          Country == input$countryInput)
       ggplot(filtered,aes(Alcohol_Content))+ geom_histogram()
  
  })
  output$output2 <- renderTable({
    if(input$sortpriceInput){
        filtered <- bcl  %>% 
          filter(Price >= input$priceInput[1],
                 Price <= input$priceInput[2],
                 Type == input$typeInput,
                 Country == input$countryInput) %>%
        arrange(desc(Price))
    }
    else{
      filtered <- bcl  %>% 
        filter(Price >= input$priceInput[1],
               Price <= input$priceInput[2],
               Type == input$typeInput,
               Country == input$countryInput) %>%
        arrange(Price)
    }
  })
}

shinyApp(ui= ui, server = server)