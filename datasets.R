## Collection of data sets covering data viz use cases
## Standard sets saved in project that can be used to test different techniques



library(data.table)
library(rvest)
library(tidyverse)

## get table of data sets from web
target.url <- "https://vincentarelbundock.github.io/Rdatasets/datasets.html"
## read into web page xml doc
txml <- read_html(target.url)
## find the table identifier (xpath or css) and break out html nodes
tnode <- html_node(x=txml, '.dataframe')
## format as table (assuming table layout of html)
ttbl <- html_table(tnode)
write_csv(ttbl, "input/r-datasets.csv")
datasets.list <- read_csv("input/r-datasets.csv") 

## look at pkgs referred to
table(datasets.list$Package)


## filter as needed
ds.datasets <- datasets.list %>% filter(Package=='datasets')

head(nottem)
head(longley)

## Time Series ####
## annual, multiple numerical variables
df.econ <- longley
str(df.econ)
df.econ <- df.econ %>% select(Year, c(1:(ncol(longley)-1)))
rownames(df.econ) <- c(1:nrow(df.econ))
head(df.econ)
write_csv(df.econ, "input/econ.csv")

## Single categorical valiable, multiple numberical variables ####
df.cars <- mtcars
df.cars$car <- rownames(df.cars) 
rownames(df.cars) <- c(1:nrow(df.cars))
df.cars <- df.cars %>% select(car,c(1:(ncol(df.cars)-1)))

## SAVE
write_csv(df.cars, "input/cars.csv")
