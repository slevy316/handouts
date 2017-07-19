# Pulling in Data
species <- read.csv('data/species.csv', stringsAsFactors = FALSE)
animals <- read.csv("data/animals.csv", na.strings = '', stringsAsFactors = FALSE)

# User Interface
in1 <- selectInput(inputId = "pick_species",
                   label = 'Pick a species',
                   choices = unique(species[["id"]]))  # double [[]] very important. Common bug in shineys = wrong number of parantheses
out1 <- textOutput("species_id")                       ## beware default functions!! They can mess you up son.
tab <- tabPanel(title = "Species", in1, out1)
ui <- navbarPage(title = 'Portal Project', tab)

# Server
server <- function(input, output) {
  output[["species_id"]] <- renderText(input[['pick_species']])
}

# Create the Shiny App
shinyApp(ui = ui, server = server)
