# Libraries
library(dplyr)
library(shiny)

# Data
species <- read.csv('data/species.csv', stringsAsFactors = FALSE)
animals <- read.csv('data/animals.csv', na.strings = '', stringsAsFactors = FALSE)

# User Interface
in1 <- selectInput(inputId = 'pick_species',
                   label = 'Pick a species',
		   choices = unique(species[['id']]))
out1 <- textOutput('species_id')
out2 <- plotOutput("species_plot")
tab <- tabPanel('Species', in1, out1, out2)                       ## defines what the tabs will be
ui <- navbarPage(title = 'Portal Project', tab)                   ## defines nav bar

# Server
server <- function(input, output) {
  output[['species_id']] <- renderText(input[['pick_species']])
  output[['species_plot']] <- renderPlot(                         ## instructions for how to create output
    animals %>%
      filter(species_id==input[["pick_species"]]) %>%
      ggplot(aes(year, fill = "red")) +                           ## modify the fill, colour etc.
      geom_bar()
  )
}

# Create the Shiny App
shinyApp(ui = ui, server = server)



## Exercise 1: Change out1 to have an outputId of “species_name” 
#              and modify the renderText() function to print the 
#              genus and species above the plot, rather than the 
#              species ID. Hint: The function paste() with 
#              argument collapse = ' ' will convert a data frame 
#              row to a text string.


# Libraries
library(ggplot2)
library(dplyr)

# Data
species <- read.csv('data/species.csv', stringsAsFactors = FALSE)
animals <- read.csv('data/animals.csv', na.strings = '', stringsAsFactors = FALSE)

# User Interface
in1 <- selectInput('pick_species',
                   label = 'Pick a species',
                   choices = unique(species[['id']]))
out1 <- textOutput('species_name')
out2 <- plotOutput('species_plot')
tab <- tabPanel(title = 'Species',
                in1, out1, out2)
ui <- navbarPage(title = 'Portal Project', tab)

server <- function(input, output) {
  output[['species_name']] <- renderText(
    species %>%                                               ## filter tool here & pipeline allow to capture filters and create strings
      filter(id == input[['pick_species']]) %>%               ## gives the genus & species!
      select(genus, species) %>%
      paste(collapse = ' ')
  )
  output[['species_plot']] <- renderPlot(
    animals %>%
      filter(species_id == input[['pick_species']]) %>%
      ggplot(aes(year)) +
      geom_bar()
  )
}

# Create the Shiny App
shinyApp(ui = ui, server = server)
