library(shiny)
library(quantmod)
library(devtools)
library(plotly)
library(ggplot2)
library(shinyapps)


shinyUI(pageWithSidebar(
        
        # Application title
        titlePanel("Stock Price Trend"),
        
        # Sidebar Panel
                sidebarPanel(
                        textInput("symbol", "Stock Symbol:", "AAPL"),
                        
                        dateRangeInput('dateRange',
                                       label = "Date Range",
                                       start = Sys.Date() - 5, end = Sys.Date(),
                                       min = Sys.Date() -730, max = Sys.Date(),
                                       separator = "-", format = "yyyy/mm/dd",
                                       startview = 'year', weekstart = 1
                        ),
                        hr(),
                        actionButton("goButton", "Go!"),
                        hr(),
                        hr(),
                        p("Documentation: ",a("Stock Trend App",href="stockTrendShinyApp.html"))
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                        
                        h4(textOutput("plotLabel"),align="center"),
                        #htmlOutput("stockPlot"),
                        plotOutput("stockPlot"),
                        h4(textOutput("percentChange"),align="center"),
                        htmlOutput("stockDf")
                        
                )
        
))