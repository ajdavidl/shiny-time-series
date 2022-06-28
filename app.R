library(shiny)
library(shinydashboard)

shiny::runApp(port = 3838, host = "0.0.0.0")

# Run in terminal
# $ R -e "shiny::runApp('.', port = 3838)"
