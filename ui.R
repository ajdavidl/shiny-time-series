library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(plotly)
library(DT)
library(lubridate)

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
    ),
    dateRangeInput("dateRange", "Range temporal:",
        start = as.Date("2019-01-01"),
        end = today(),
        min = as.Date("1980-01-01"),
        max = today(),
        separator = " para ",
        language = "pt-BR",
        format = "mm-yyyy"
    )
)

body <- dashboardBody(
    fluidRow(
        column(
            width = 5,
            box(
                title = "Itens:",
                selectInput(
                    "sercodigo", "Item desejado:",
                    c(
                        "IPCA" = "PRECOS12_IPCAG12",
                        "IPCA-15" = "PRECOS12_IPCA15G12",
                        "IPCA-EX1" = "BM12_IPCAEXCEX212",
                        "PIB" = "BM12_PIB12",
                        "IGP-DI" = "IGP12_IGPDIG12",
                        "IGP-M" = "IGP12_IGPMG12",
                        "INCC-DI" = "IGP12_INCCG12",
                        "IPA-DI" = "IGP12_IPADIG12",
                        "Taxa de juros - Selic" = "BM366_TJOVER366",
                        "Taxa de câmbio - compra" = "GM366_ERC366",
                        "Taxa de câmbio - venda" = "GM366_ERV366",
                        "Pessoas ocupadas" = "PNADC12_PO12",
                        "Pessoas desocupadas" = "PNADC12_PD12",
                        "Taxa de desocupação" = "PNADC12_TDESOC12",
                        "Taxa de participação" = "PNADC12_TPART12"
                    )
                )
            )
        )
    ),
    fluidRow(
        box(
            title = "Tabela", width = 4,
            withSpinner(dataTableOutput("datatable"))
        ),
        box(
            title = "Gráfico", width = 8,
            withSpinner(plotlyOutput("grafico"))
        )
    )
)

dashboardPage(header, sidebar, body)
