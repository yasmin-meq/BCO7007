library(tidyverse)
library(tidytext)

tweet <- read_csv("17_10_2021.csv")

class(tweet$created_at)
library(lubridate)

tweet <- tweet %>%
  mutate(timestamp=ymd_hms(created_at))

remove_reg <- "&amp;|&lt;|&gt;" # this going to remove all special char!

#remving special charecters 
tidy_tweets <- tweet %>% 
  filter(!str_detect(text, "^RT")) %>%
  mutate(text = str_remove_all(text, remove_reg))

#unnesting tweets
tidy_tweets<-tidy_tweets%>%
  filter(!word %in% stop_words$word, #remove stopwords
         !word %in% str_remove_all(stop_words$word, "'"),
         str_detect(word, "[a-z]")) #keep only character-words

#removing mentions
tidy_tweets$word<-
  gsub("@\\w+", "", tidy_tweets$word)
#removing urls
tidy_tweets$word<-
  gsub("https?://.+", "", tidy_tweets$word)

tidy_tweets$word <- gsub("\\d+\\w*\\d*", "", tidy_tweets$word)
tidy_tweets$word <- gsub("#\\w+", "", tidy_tweets$word)
tidy_tweets$word <- gsub("[^\x01-\x7F]", "", tidy_tweets$word)
tidy_tweets$word <- gsub("[[:punct:]]", " ", tidy_tweets$word)

#to check our code!
selected_tweets <- tidy_tweets %>% 
  select(timestamp,word,user_id)

bing <- get_sentiments("bing") #either negative and positive 
nrc <- get_sentiments("nrc") #emotion words

selected_tweets <- selected_tweets %>%
  inner_join(bing)

#how positive or negative are the people with movies
selected_tweets%>%
  count(sentiment, sort = TRUE)

selected_tweets%>%
  group_by(user_id)%>%
  count(sentiment, sort = TRUE)




#working with wordcloud
library(wordcloud)

selected_tweets%>%count(word) %>%
  with(wordcloud(word, n, max.words = 100))

