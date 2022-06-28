library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

header <- dashboardHeader(
    title = "Times series visualization",
    titleWidth = 300
)

sidebar <- dashboardSidebar(
    width = 380,
    selectInput("NrDigits", "Número de casas decimais:",
        c(1, 2, 3, 4, 5),
        selected = 2,
        width = NULL
    )
)

body <- dashboardBody(
    fluidRow(
        box(
            title = "Tabela", width = 4,
            dataTableOutput("datatable")
        ),
        box(
            title = "Gráfico", width = 8,
            plotlyOutput("grafico")
        )
    )
)

dashboardPage(header, sidebar, body)
