library(shiny)

# Setting a User Interface
ui <- navbarPage(title = 'Hello, Shiny World!')

# Setting a Server
server <- function(input, output){}

# Create the Shiny App
shinyApp(ui = ui,
         server = server)


