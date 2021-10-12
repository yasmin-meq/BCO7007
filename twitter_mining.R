# collecting tweets for assignment 1 & 3 

library(tidyverse)
library(rtweet)

data <- search_tweets(
  q= "movie",
  n=18000,
  include_rts = FALSE,
  lang = "en",
  retryonratelimit = TRUE
)

data <- data%>% flatten()
#why we did that? for instance, in hashtag variable, each word will be representing one hashtag
#before: c("BAFTA", "BritanniaAwards") || after: BAFTA BritanniaAwards


data %>% write_csv("12_10_2021.csv")
# change the name of the file every week with the date I collect the data in

#-------------------------------------------------------------------------------
#do it only once when I finish collecting all my data
# merging and opening all csv files (that will be collected every week)
files <- list.files(pattern = "\\.csv", full.names = TRUE) #read files with .csv
all_data <- map_df(files,~read.csv(x)) #open and merge 

#-------------------------------------------------------------------------------

#i may get duplicated data, so to keep only one entry of them:
final_data <- all_data %>% distinct()




