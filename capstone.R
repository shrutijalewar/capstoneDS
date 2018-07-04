setwd('/Users/ssharma/code/nss-ds/capstoneDS/')
library("jsonlite")
library("tidyverse")
library("dplyr")
library("magrittr")
library("ggplot2")
library("ggvis")

###### Reading Data######
news <-  read_csv('all_news.csv')
all_news_sentiment <- read_csv('all_news_sentiment.csv')
sentiment <- all_news_sentiment %>% 
  select(id, titleComp, descriptionComp) %>%
   group_by(id) %>% 
   summarise(title = mean(titleComp), description = mean(descriptionComp))
ggplot(sentiment, aes(id, title, fill = id)) + 
  geom_bar(stat="identity", position = "dodge")

sentiment <- all_news_sentiment %>% 
  select(id, titleComp, descriptionComp) %>%
  group_by(id) %>% 
  summarise(title = mean(titleComp), description = mean(descriptionComp))
ggplot(sentiment, aes(id, description, fill = id)) + 
  geom_bar(stat="identity", position = "dodge")
#####plot####
ggplot(sentiment, aes(id, title, fill = id)) + 
  geom_bar(stat="identity", position = "dodge")


##### what the hell ####


news_sentiment %>%
  ggvis( ~ descriptionComp, ~ titleComp, key := ~X1) %>% 
  layer_points(size := 50, size.hover := 200,
               fillOpacity := 0.4, fillOpacity.hover := 0.8,
               fill = ~factor(name)) %>% 
  # add_tooltip(b_tooltip,"hover") %>% 
  
  add_axis("x", title = "Title Comp", format = '####', title_offset = 50, properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 18))) %>%
  add_axis("y", title = "description comp", title_offset = 50, properties = axis_props(labels = list(fontSize = 15),title = list(fontSize = 18))) %>%
  add_legend("fill", title = "Sentiment Score", values = name , properties = legend_props(labels = list(fontSize = 15),title = list(fontSize = 15))) %>%
  scale_nominal("fill")
 
