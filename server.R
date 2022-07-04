library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(ggplot2)
library(dplyr)
library(rjson)
library(lubridate)

shinyServer(function(input, output) {
    dataset <- reactive({
        url <- "http://www.ipeadata.gov.br/api/odata4/Metadados('"
        sercodigo <- input$sercodigo
        url_metadado <- paste0(url, sercodigo, "')")
        url_valores <- paste0(url_metadado, "/Valores")

        metadados <- fromJSON(file = url_metadado)
        valores <- fromJSON(file = url_valores)

        df <- data.frame(
            X1 = valores$value[[1]]$VALDATA[1],
            X2 = valores$value[[1]]$VALVALOR[1],
            stringsAsFactors = FALSE
        )

        for (i in 2:length(valores$value)) {
            if (is.null(valores$value[[i]]$VALVALOR[1])) {
                valor <- NA
            } else {
                valor <- valores$value[[i]]$VALVALOR[1]
            }
            aux <- data.frame(
                X1 = valores$value[[i]]$VALDATA[1],
                X2 = valor,
                stringsAsFactors = FALSE
            )

            df <- rbind.data.frame(df, aux)
        }

        colnames(df) <- c("DATA", "DADOS")
        df$DATA <- as.Date(df$DATA, format = "%Y-%m-%d")
        df$DADOS <- round(df$DADOS, as.numeric(input$NrDigits))
        return(df)
    })

    datasetFiltered <- reactive({
        df <- dataset()
        df <- df %>%
            filter(DATA >= input$dateRange[1], DATA <= input$dateRange[2])
        return(df)
    })

    output$grafico <- renderPlotly({
        df <- datasetFiltered()
        p <- ggplot(df, aes(x = DATA, y = DADOS),
            size = 1.2,
        ) +
            geom_line() +
            theme(
                legend.title = element_blank(),
                panel.background = element_rect(fill = "whitesmoke"),
                axis.text.x = element_text(face = "bold", size = 12),
                axis.text.y = element_text(face = "bold", size = 12),
                axis.title.y = element_text(face = "bold"),
                axis.line = element_line(colour = "black")
            ) +
            ggtitle(" ") +
            ylab(" ") +
            xlab(" ")
        plot <- ggplotly(p)
        return(plot)
    })

    output$datatable <- renderDataTable({
        df <- datasetFiltered()
        dt <- DT::datatable(df)
        return(dt)
    })
})
