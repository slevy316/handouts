## lm

animals <- read.csv('data/animals.csv', stringsAsFactors = FALSE, na.strings = '')
fit <- lm(                                   ##fit is now a fitted model, can see this with summary()
  formula = log(weight) ~ hindfoot_length,
  data = animals)

## Exercise 1: regress hindfoot_length against weight and species_id. Does it
##             appear that the DM have inordinately large feet for their weight?

library(dplyr)
animals_dm <- filter(animals, species_id == "DM")

fit <- lm(
  formula = hindfoot_length ~ weight + species_id,
  data = animals
)

## NOTE: In this eg R has read each *unique character strings* into *new factors*

summary(fit)

## glm

## Exercise 2: compare lm & glm (linear model vs. general linear model)

fit    <- lm ( log(weight) ~ species_id, data = animals)
glmfit <- glm( log(weight) ~ species_id, data = animals) ## default stat family is gaussian. Would have to specify family to change this

summary(fit)
summary(glmfit)

#logistical regression

animals$sex <- factor(animals$sex)
fit_new <- glm(sex ~ hindfoot_length,
           family = binomial,                            ## specifying the family  
           data = animals)

summary(fit_new)


## lme4 (linear mixed models - extends to model to allow descriotions of "random effects")


# if not done yet make sure to do: install.packages('lme4')

library(lme4)
fit <- lmer(log(weight) ~ (1 | species_id) + hindfoot_length,
            data = animals)

## Exercise 4: Adjust the formula log(weight) ~ hindfoot_length to fit a
##             “random intercepts” model, grouping by a different categorical 
##             variable (i.e. not species_id) in the animals data frame.


fit <- lmer(log(weight) ~ species_id, data = animals,
            data = animals)

## RStan

library(dplyr)
library(rstan)
stanimals <- animals %>%
  select(weight, species_id, hindfoot_length) %>%
  na.omit() %>%
  mutate(log_weight = log(weight),
         species_idx = as.integer(factor(species_id))) %>%
  select(-weight, -species_id)
stanimals <- c(
  N = nrow(stanimals),
  M = max(stanimals$species_idx),
  as.list(stanimals))

samp <- stan(file = 'worksheet-6.stan',
             data = stanimals,
             iter = 1000, chains = 3)
saveRDS(samp, 'stanimals.RDS')