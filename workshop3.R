install.packages("janeaustenr")

library(tidyverse)
library(tidytext)
library(janeaustenr)

books <- austen_books() #the text is totly unstructured and we need to tidy it up

data_2_tokens <- books %>% unnest_tokens(word,text) #look at the text column and split it to words (tokens)

#let's see the most popular word in each book
book_word <- data_2_tokens%>%
  count(book, word, sort = TRUE)

total_word <- book_word %>%
  group_by(book)%>%
  summarize(total = sum(n))%>%
  arrange(desc(total))

book_word <- left_join(book_word,total_word)









