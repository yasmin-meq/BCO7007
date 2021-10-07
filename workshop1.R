install.packages("tidyverse")
install.packages("tidymodels")
install.packages("tidytext")
install.packages("rtweet")

library(tidyverse)
library(tidymodels)
library(tidytext)
library(rtweet)

my_tweets <- search_tweets(
  q="chocolate", 
  n=100
)

lindt <- lookup_users("Lindt")