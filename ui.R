#
# Shine Web Ap Example

library(shiny)

# Define UI for application
shinyUI(fluidPage(
    titlePanel("Time to Retirement by Savings Rate"),
    fluidRow(
        column(3, wellPanel(
            sliderInput("savings_rate", "Savings Rate",
                        min = 5, max = 100, value = 50,
                        step = 5),
            p("Please select a planned retirement savings as a percentage of total income."),
            p("The resulting years to retirement is based on maintaining actual spending rate."),
            br(),
            p("Source: "),
            a("Networthify - When can I retire?", href="https://networthify.com/calculator/earlyretirement")
        )),
        column(6,
               plotOutput("plot1", width = 700, height = 400),
               verbatimTextOutput("text1"),
               verbatimTextOutput("text2")
        )
    )
))
