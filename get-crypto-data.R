
library(tidyverse)
library(lubridate)
library(quantmod)
library(PerformanceAnalytics)

## function to get price based on symbol and start date
price_data <- function(symbol, dt_start){
  symbol_price <- getSymbols(Symbols=symbol, auto.assign=FALSE)
  symbol_close <- paste0(symbol,".Close")
  curr_price <- symbol_price[paste0(dt_start,"/"),symbol_close]
  ## convert to data frames for combining
  curr_price_df <- as.data.frame(curr_price)
  curr_price_df$date <- date(row.names(curr_price_df))
  row.names(curr_price_df) <- seq(1:nrow(curr_price_df))
  ## rename cols to avoid errors
  new_names <- str_replace(names(curr_price_df), '-','_')
  new_names <- str_replace(new_names,"\\.Close","")
  names(curr_price_df) <- new_names
  return(list(symbol_price, curr_price, curr_price_df))
}

symbol <- 'BTC-CAD'
dt_start <- '2021-01-01'

prices <- price_data(symbol, dt_start)
cprice <- prices[[3]]

symbol <- 'ADA-CAD'
prices <- price_data(symbol, dt_start)
cprice2 <- prices[[3]]

## combine price tables into one
cprice_all <- full_join(cprice, cprice2, by='date')
## re-arrange cols to put date first for ease of use
cprice_all <- cprice_all %>% select(date, 1,3:ncol(cprice_all))

## save locally for use elsewhere
write_csv(cprice_all, 'input/btc-ada-price.csv')
