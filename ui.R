library(shiny)
library(plotly)
library(DT)

ui <- fluidPage(
    titlePanel("Times series visualization"),
    sidebarPanel(
        selectInput("NrDigits", "Número de casas decimais:",
            c(1, 2, 3, 4, 5),
            selected = 2,
            width = NULL
        )
    ),
    mainPanel(
        fluidRow(
            plotlyOutput("grafico"),
            dataTableOutput("datatable")
        )
    )
)
