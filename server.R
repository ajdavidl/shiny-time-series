library(shiny)
library(shinydashboard)
library(plotly)
library(DT)
library(ggplot2)
library(dplyr)
library(lubridate)

source("config.R", encoding = "utf-8")
source("util.R", encoding = "utf-8")

shinyServer(function(input, output) {
  
  
  # leitura de dados --------------------------------------------------------
  
  datasetIpeadata <- reactive({
    valores <- ipeadatacache(input$sercodigo, "valores")
    
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
  
  datasetFilteredIpeadata <- reactive({
    df <- datasetIpeadata()
    df <- df %>%
      filter(DATA >= input$dateRange[1], DATA <= input$dateRange[2])
    return(df)
  })
  
  metadadosIpeadata <- reactive(({
    return(ipeadatacache(input$sercodigo, "metadados"))
  }))
  
  datasetSGS <- reactive({
    dados <- sgsbacencache(input$sgscodigo)
    datas <- c()
    valores <- c()
    for (i in seq_along(dados)) {
      datas <- c(datas, dados[[i]]$data)
      valores <- c(valores, as.numeric(dados[[i]]$valor))
    }
    
    df <- data.frame(datas = datas, valores = valores)
    df$datas <- as.Date(df$datas, format = "%d/%m/%Y")
    return(df)
  })
  
  datasetFilteredSGS <- reactive({
    df <- datasetSGS()
    df <- df %>%
      filter(datas >= input$dateRange[1], datas <= input$dateRange[2])
    
    return(df)
  })
  
  # gráficos ----------------------------------------------------------------
  
  
  output$graficoIpeadata <- renderPlotly({
    df <- datasetFilteredIpeadata()
    metadados_ <- metadadosIpeadata()
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
      labs(
        title = metadados_$value[[1]]$SERNOME,
        caption = metadados_$value[[1]]$FNTNOME
      ) +
      ylab(metadados_$value[[1]]$UNINOME) +
      xlab(metadados_$value[[1]]$PERNOME)
    plot <- ggplotly(p)
    return(plot)
  })
  
  output$graficoSGS <- renderPlotly({
    df <- datasetFilteredSGS()
    
    p <- ggplot(df, aes(x = datas, y = valores),
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
      ) 
    plot <- ggplotly(p)
    return(plot)
  })
  
  
  # data tables -------------------------------------------------------------
  
  output$datatableIpeadata <- renderDataTable({
    df <- datasetFilteredIpeadata()
    dt <- DT::datatable(df,
                        extensions = DT_extensions,
                        class = DT_Class,
                        escape = FALSE,
                        options = DT_Options
    )
    return(dt)
  })
  
  output$datatableSGS <- renderDataTable({
    df <- datasetFilteredSGS()
    dt <- DT::datatable(df,
                        extensions = DT_extensions,
                        class = DT_Class,
                        escape = FALSE,
                        options = DT_Options
    )
    return(dt)
  })
})
