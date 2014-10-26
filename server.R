library(shiny)
library(quantmod)
library(devtools)
library(plotly)
library(ggplot2)
library(shinyapps)

shinyServer(function(input, output) {
        
        output$stockPlot <- renderPlot({
                input$goButton
                
        isolate({
                stockDf <- getSymbols(input$symbol,src="yahoo",
                                      from = input$dateRange[1],
                                      to = input$dateRange[2],
                                      auto.assign = FALSE)
                
                quoteDf  <- data.frame(stockDf)
                quoteDf$date = as.Date(rownames(quoteDf))
                colnames(quoteDf)[4]  <- 'price'
                n <- nrow(quoteDf)
                percent  <- round((((quoteDf[n,4]-quoteDf[1,4])/quoteDf[1,4])*100),2)
                label <- "The percent change in stock value for the given date range is :"
                output$percentChange <- renderText(paste(label,percent,"%"))                
                plotLabel <- paste("Stock Price Plot for",toupper(input$symbol))
                output$plotLabel <- renderText(plotLabel)
                output$stockDf  <- renderTable(quoteDf)
                ggplot(data=quoteDf, aes(x=date, y=price)) + geom_line() + theme_bw()
                
#                 py <- plotly(username="sandykp", key="xn0sjcasgz") 
#                 res <- py$ggplotly(g, kwargs=list(filename="Stock Trend", 
#                                                        fileopt="overwrite", # Overwrite plot in Plotly's website
#                                                        auto_open=FALSE))
#                 tags$iframe(src=res$response$url,
#                             frameBorder="0",  # Some aesthetics
#                             height=400,
#                             width=650)
                
                
        })
                
                
        })
        

         
})