## Tidy data concept

counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(4, 4, 4),
  fox = c(3, 3, 3)
)

## Reshaping multiple columns in category/value pairs

library(tidyr)
counts_gather <- gather(counts_df,
                        key = "species",
                        value = "count",
                        wolf:fox)



counts_spread <- spread(counts_gather,
                        key = species,
                        value = count
                        )

## Exercise 1

?gather

counts_gather1 <- counts_gather[-8, ]

counts_spread1 <- spread(counts_gather1,
                        key = species,
                        value = count
                        )

## Read comma-separated-value (CSV) files

animals <- read.csv("data/animals.csv")

str(animals)

animals <- read.csv('data/animals.csv', na.strings = "")

library(dplyr)
library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), host = 'localhost', dbname = 'portal')
animals_db <- tbl(con,"animals")
animals <- collect(animals_db)
dbDisconnect(con)

## Subsetting and sorting

library(dplyr)
animals_1990_winter <- filter(animals,
                              year == 1990,
                              month %in% 1:3)

animals_1990_winter <- select(animals_1990_winter, -year)

sorted <- arrange(animals_1990_winter,
              desc(species_id), weight)

## Exercise 2

...

## Grouping and aggregation

animals_1990_winter_gb <- group_by(animals_1990_winter, species_id)

counts_1990_winter <- summarize(animals_1990_winter_gb, count = n())

## Exercise 3

animals_DM <- filter(animals, 
                     species_id == "DM")

animals_DM_Mo <- group_by(animals_DM, month)

DM_HF_We <- summarize(animals_DM_Mo, avg_wgt = mean(weight, na.rm = TRUE ),
                      avg_hf = mean(hindfoot_length, na.rm = TRUE)
                      )

## Pivot tables through aggregate and spread

animals_1990_winter_gb <- group_by(animals_1990_winter, ...)
counts_by_month <- ...(animals_1990_winter_gb, ...)
pivot <- ...

## Transformation of variables

prop_1990_winter <- mutate(counts_1990_winter,
                           prop = count/sum(count))

## Exercise 4

...

## Chainning with pipes

prop_1990_winter_piped <- animals %>%
  filter(year == 1990, month %in% 1:3)%>%
  select(-year) %>% # select all columns but year
  group_by(species_id) %>% # group by species_id
  summarize(count =n()) %>% # summarize with counts
  mutate(prop = count/sum(count)) # mutate into proportions

prop_1990_winter_piped
