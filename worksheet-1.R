## The Editor

vals <- (seq(1, 50))

vals <- seq(...,
            ...)

## Vectors

counts <- c(4, 3, 7, 5)

## Exercise 2

...

## Factors

education <- factor(c("college", "highschool", "college", "middle"),
             levels = c("middle", "highschool", "college"), ordered = TRUE)

education <- ...(c("college", "highschool", "college", "middle"),
                 levels = c("middle", "highschool", "college"),
                 ...)

## Data Frames

df <- data.frame(education, counts)

## Exercise 3


species <- factor(c("dog","cat","mouse"), 
                  levels = c("dog", "cat", "mouse", 
                             ordered = TRUE))
abund <- c(1, 5, 8)
data <- data.frame(species,abund)

## Load data into R

read.csv(file = "data/plots.csv", header = TRUE)

##header is a default argument

plots <- read.csv("data/plots.csv", header = TRUE)
animals <- read.csv("data/animals.csv")

str(animals)

## Exercise 4

animals <- read.csv("data/animals.csv", stringsAsFactors = FALSE, na.strings = "")
animals$sex <- factor(animals$sex)

str(animals)

## Names

names(df) <- c('ed','ct')

df["ct"]
## Subsetting ranges

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
weekdays <- days[2:6]

weekends <- days[c(1,7)]

## Exercise 5

weekdays <- days[c(-1,-7)]

?seq
MWF <- days[seq(from = 2, to = 6, by = 2)] 
MWF

## Exercise 6

df$ed[2:3]

## Base plotting

plot(animals$hindfoot_length,animals$weight)

## Histograms

hist(animals$weight)

## Boxplots

boxplot(log(weight)~year,data=animals)

## Anatomy of a function

first <- function(dat) {
  result <- dat[1, ]
  return(result)
}

first(counts)

## Flow control

if (...) {
    ...
} else {
    ...
}

first <- function(dat) {
    if (is.vector(dat)) {
        result <- dat[1]
    } else {
      result <- dat[1, ]
    }
  return (result)
}

first(df)

## Exercise 7

first <- function(dat) {
  if (is.vector(dat)) {
    result <- dat[1]
  } 
  else if (is.matrix(dat)){
    result <- dat[1,1]
    }
    else { 
     result <- dat[1, ]
  }
  return (result)
  }

m <- matrix(1:9,nrow=3,ncol=3)
first(m)

## Distributions and statistics

samp <- rnorm(n = 10)
samp


x <- rnorm(n= 100, mean = 25, sd = 7)
y <- rbinom(n = 100, size = 50, prob = .85)

plot(x,y)

t.test(x,y)

fit <- lm(y ~ x)
summary(fit)
str(fit)

## Exercise 8

plot(animals$hindfoot_length,animals$weight)

doggo<- lm(log(hindfoot_length)~log(weight),data = animals)
plot(doggo)
?lm


fib <- c(1,1)

for (i in seq(1,10)){
  fib[i+2] <-fib[i]+fib[i+1]
}

fib

##plots[plots$id = 4, ]

plots[plots$id = 4, ]

plots[plots$id == 4, ]


##plots[-1:4, ]

plots[-1:-4, ]

##plots[plots$id <= 5]

plots[plots$id <= 5, ]

##plots[plots$id == 4 | 6, ]

plots[plots$id == 4, ] 
plots[plots$id == 6, ]

size <- c(1:5)
year <- factor(c(2015,2015,2017,2016,2017))
          levels(2015,2016,2017)
prop <- rnorm(n=5)

data <- data.frame(size,year,prop)
data
summary(prop ~ size + year)
