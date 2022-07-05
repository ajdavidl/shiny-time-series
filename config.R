# DATATABLE CONFIGURATION

buttons <- list(
    list(
        extend = "copy",
        text = '<i class="fa fa-files-o">&nbsp;&nbsp;Copiar</i>',
        titleAttr = "Copiar",
        className = "btn btn-secondary"
    ),
    list(
        extend = "excel",
        text = '<i class="fa fa-file-excel-o">&nbsp;&nbsp;Excel</i>',
        titleAttr = "Excel",
        className = "btn btn-secondary"
    ),
    list(
        extend = "csv",
        text = '<i class="fa fa-file-text-o">&nbsp;&nbsp;CSV</i>',
        titleAttr = "CSV",
        className = "btn btn-secondary"
    ),
    list(
        extend = "pdf",
        text = '<i class="fa fa-file-pdf-o">&nbsp;&nbsp;PDF</i>',
        titleAttr = "PDF",
        className = "btn btn-secondary"
    )
)

DT_extensions <- "Buttons"
DT_Class <- "compact row-border hover stripe"
DT_Options <- list(
    lengthChange = FALSE,
    pageLength = 50,
    lengthMenu = list(c(20, 40, 60, 80, 100, -1), c("20", "40", "60", "80", "100", "Tudo")),
    searching = FALSE,
    ordering = FALSE,
    dom = "Btp",
    buttons = buttons,
    scrollX = TRUE,
    scrollY = TRUE,
    columnDefs = list(list(className = "dt-center", targets = "_all")) # ,
    # language = list(url = 'Portuguese_Brasil.json')
)
