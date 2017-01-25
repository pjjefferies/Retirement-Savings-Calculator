#
# Server logic of a Shiny web application
#

library(shiny)

retirement = data.frame(
    rate=c(seq.int(from=5, to=100, by=5)),
    WYears=c(65.76, 51.35, 42.83, 36.72, 31.93, 27.98, 24.6, 21.64,
             19.01, 16.62, 14.43, 12.42, 10.54, 8.79, 7.14, 5.57,
             4.08,  2.66,  1.3,   0))
barColor=c("Black", "Black","Black","Black","Black","Black","Black",
           "Black", "Black", "Blue", "Black","Black","Black","Black",
           "Black","Black", "Black","Black","Black","Black")
barColor = as.character(barColor)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    newdata <- reactive({
        barColor <- rep("Black", 20)
        if(input$savings_rate < 50) {
            barColor[as.integer(input$savings_rate / 5)] <- "Red"
        } else if(input$savings_rate < 80) {
            barColor[as.integer(input$savings_rate / 5)] <- "Blue"
        } else {
            barColor[as.integer(input$savings_rate / 5)] <- "Green"
        }
        
        return(barColor)
    })

    output$plot1 <- renderPlot({
        barplot(retirement$WYears,
                names.arg=retirement$rate,
                col=newdata(),
                main="Years to Reirement Based on Percent of Income Savings Rate",
                xlab="Savings Rate (Percent of Income",
                ylab="Years To Retirement")
    })
  
    output$text1 <- renderText({
        if(input$savings_rate < 50) {
            paste(input$savings_rate, "% is not enough. Please try harder.", sep="")
        } else {
            if(input$savings_rate < 85) {
                paste(input$savings_rate, "% is a good savings rate.", sep="")
            } else {
                paste(input$savings_rate, "% is a great savings rate. Nice Job!", sep="")
            }
        }
    })
    output$text2 <- renderText({
        paste("You can retire in", retirement$WYears[as.integer(input$savings_rate/5)], "years")
    })
    
})
