## Getting started

library(dplyr)
library(ggplot2)
animals <- read.csv("data/animals.csv", na.strings = '') %>%
  filter(!is.na(species_id), !is.na(sex), !is.na(weight))

## Constructing layered graphics in ggplot

ggplot(data=animals,
       aes(x=species_id, y=weight)) +
  geom_point()
  

##ggplot2 is a Hadley/tidyverse package and means that it is very well documented

ggplot(data = animals,
       aes(x = species_id, y = weight)) +
  geom_boxplot()

ggplot(data = animals,
       aes(x = species_id, y = weight)) + ## aesthetic layer
  geom_boxplot() +              ## + is key
  geom_point(stat = "summary",  ## set no of options for stat, depends on geometry using
             fun.y = "mean",    ## function
             color = "red")     ##

ggplot(data = animals,
       aes(x = species_id, y = weight, color = species_id)) + ## addinging color here applies effect to whole thing
  geom_boxplot() +
  geom_point(stat = 'summary',
             fun.y = 'mean')

## Exercise 1: Using dplyr and ggplot show how the mean weight of 
##             individuals of the species DM changes over time, 
##            with males and females shown in different colors.
<<<<<<< HEAD


animals_DM <- filter(animals, species_id == "DM")

ggplot(data = animals_DM,
       aes(x = year, y = weight, color = sex)) +
  geom_line(stat = "summary",
             fun.y = "mean")
  


=======


animals_DM <- filter(animals, species_id == "DM")

ggplot(data = animals_DM,
       aes(x = year, y = weight, color = sex)) +
  geom_line(stat = "summary",
             fun.y = "mean")
  


>>>>>>> 63053cfb7e76e4fc6fa5906d8331e875a449b4e6
 ## Differentiating point type

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals, species_id == "DM")
ggplot(data=animals_dm,
       aes(x = year, y = weight)) +
  geom_point(aes(shape=sex),    ##aesthetic can be used in multiple places for more precision
             size = 3,          ## vary no. of sizes
             stat = 'summary',
             fun.y = 'mean')

  ## Adding a regression line

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals, species_id == "DM")
ggplot(data=animals_dm,
       aes(x = year, y = weight)) +
  geom_point(aes(shape=sex),    ##aesthetic can be used in multiple places for more precision
             size = 3,          ## vary no. of sizes
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(method="lm")     ## adding geom_smooth gives a line

 ## adding seperate regression layers

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals, species_id == "DM")
ggplot(data=animals_dm,
       aes(x = year, y = weight)) +
  geom_point(aes(shape=sex),    
             size = 3,          
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(aes(group=sex), method="lm") ## adding an aethetic allows to split by existing group

## adding colour to your chart

levels(animals$sex) <- c('Female', 'Male')
animals_dm <- filter(animals, species_id == "DM")
ggplot(data=animals_dm,
       aes(x = year, y = weight, color=sex)) + ##add the colour to first aesthetic to apply to whole thang
  geom_point(aes(shape=sex),    
             size = 3,         
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(aes(group=sex), method="lm")


# Storing and re-plotting

year_wgt <- ggplot(data = animals_dm,
                   aes(x = year,
                       y = weight,
                       color = sex)) +
  geom_point(aes(shape = sex),
             size = 3,
             stat = 'summary',
             fun.y = 'mean') +
  geom_smooth(method = 'lm')

##editing colour schemes

year_wgt +
  scale_color_manual(values=c("darkblue","orange"))
                     
year_wgt <- year_wgt +
  scale_color_manual(values = c("darkblue","green"))

year_wgt

## Exercise 2: Create a histogram, using a geom_histogram() layer, 
##             of the weights of individuals of species DM and divide 
##             the data by sex. Note that instead of using color in 
##             the aesthetic, you’ll use fill to distinguish the sexes. 
##             Also open the help with ?geom_histogram and determine 
##             how to explicitly set the bin width.
<<<<<<< HEAD

?geom_histogram


=======

?geom_histogram


>>>>>>> 63053cfb7e76e4fc6fa5906d8331e875a449b4e6
dist_dm <- ggplot(data = animals_dm,
                  aes(x = weight, fill = sex)) +
  geom_histogram(binwidth= 0.5)

dist_dm

## Axes, labels and themes

histo <- ggplot(data = animals_dm,
                aes(x = weight, fill = sex)) +
  geom_histogram(binwidth=0.75)

histo

## Axes & labels

histo <- histo +
  labs(title = 'Dipodomys merriami weight distribution',     ## labs=labels
       x = 'Weight (g)',
       y = 'Count') +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))

histo

## Themes

histo <- histo +
  theme_bw() +                                                ## adding in presets
  theme(legend.position = c(0.2, 0.5),                        ## tweaks using theme()
        plot.title = element_text(face = "bold", vjust = 2),  ## plot.title is editing not setting title
        axes.title.y =  element_text(size = 13, vjust = 1),
        axes.title.x = element_text(size = 13, vjust = 0))

histo

## Facets

animals_common <- filter(animals, species_id %in% c("DM", "DO", "PP"))
ggplot(data = animals_common,
       aes(x=weight)) +
  geom_histogram() +
  facet_wrap(~ species_id)
  labs(title = "Weight of most common species",
       x = "Count",
       y = "Weight (g)")

## More complex facets 
  
  ggplot(data = animals_common,
         aes(x = weight)) +
    geom_histogram(data = select(animals_common, -species_id),
                   alpha = 0.2) +
    geom_histogram() +
    facet_wrap( ~ species_id) +
    labs(title = "Weight of most common species",
         x = "Count",
         y = "Weight (g)")
  
ggplot(data = animals_common,
       aes(x = weight, ...)) +
  geom_histogram(...) +
  facet_wrap( ~ species_id) +
  labs(title = "Weight of most common species",
       x = "Count",
       y = "Weight (g)") +
  guides(fill = FALSE)		

## Exercise 3: facetgrid

ggplot(data = animals_common,
       aes(x=weight)) +
  geom_histogram() +
  facet_grid(sex ~ species_id) +
  labs(title = "Weight of species by sex",
         x = "Count",
         y = "Weight (g)")



