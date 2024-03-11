library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(plotly)
library(DT)
library(lubridate)

header <- dashboardHeader(
  title = "Visualização de séries temporais",
  titleWidth = 450
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
  ),
  h3(" Menu"),
  sidebarMenu(
    id = "menuItens",
    menuItem("Ipeadata", tabName = "ipeadata", icon = icon("file")),
    menuItem("Sgs Bacen", tabName = "sgsbacen", icon = icon("file-archive"))
  )
)

body <- dashboardBody(
  tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 24px;
      }
    '))),
  tabItems(
    tabItem(
      tabName = "ipeadata",
      fluidRow(
        column(
          width = 5,
          box(
            title = "Itens do Ipeadata:",
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
                "Taxa de participação" = "PNADC12_TPART12",
                "Salário Mínimo" = "MTE12_SALMIN12",
                "Salário Mínimo Real" = "GAC12_SALMINRE12",
                "Embi" = "JPM366_EMBI366",
                "Ibovespa - fechamento" = "GM366_IBVSP366" # ,

                # "Ibovespa - fechamento - volatilidade" = "GM366_IBVSPV366"
              )
            )
          )
        )
      ),
      fluidRow(
        box(
          title = "Tabela", width = 4,
          withSpinner(dataTableOutput("datatableIpeadata"))
        ),
        box(
          title = "Gráfico", width = 8,
          withSpinner(plotlyOutput("graficoIpeadata"))
        )
      )
    ),
    tabItem(
      tabName = "sgsbacen",
      fluidRow(
        column(
          width = 5,
          box(
            title = "Itens do SGS:",
            selectInput(
              "sgscodigo", "item desejado:",
              list(
                "Câmbio" = "1",
                "Câmbio ocorrido" = "3698",
                "Preços" = c(
                  "IGPM" = "189",
                  "INPC" = "188",
                  "IPCA" = "433",
                  "IPCA 12 meses" = "13522",
                  "IPCA EX0" = "11427",
                  "IPCA Livres" = "11428",
                  "IPCA Alimentação e Bebidas" = "1644",
                  "IPCA Industriais" = "27863",
                  "IPCA Saúde" = "1641"
                ),
                "PIB variação anual" = "7326",
                "População (mil)" = "21774",
                "Selic Meta" = "432",
                "Selic Ocorrida" = "4189",
                "População na força de trabalho - PNADC" = "24378",
                "Pessoas Ocupadas - PNADC" = "24379",
                "Pessoas Desocupadas - PNADC" = "24380"
              )
            )
          )
        )
      ),
      fluidRow(
        box(
          title = "Tabela", width = 4,
          withSpinner(dataTableOutput("datatableSGS"))
        ),
        box(
          title = "Gráfico", width = 8,
          withSpinner(plotlyOutput("graficoSGS"))
        )
      )
    )
  )
)



dashboardPage(header, sidebar, body, skin="black")
