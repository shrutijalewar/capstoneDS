setwd('/Users/ssharma/code/nss-ds/capstoneDS/')
library("jsonlite")
library("tidyverse")
library("dplyr")
library("magrittr")
library("ggplot2")
library("ggvis")
library("mclust")
library('beeswarm')
library("GGally")
#library("LDAvis")
library(readr)
install.packages("DT")
###### Reading Data######

all_news_sentiment <- read_csv("~/code/nss-ds/capstoneDS/news-bubbles/data/all_news_sentiment.csv")
View(all_news_sentiment)

news <-  read_csv('data/all_news.csv')
all_news_sentiment <- read_csv('data/all_news_sentiment.csv')
View(all_news_sentiment)
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
sentiment <- all_news_sentiment %>% 
  select(id, titleComp, descriptionComp) 
  
ggplot(all_news_sentiment, aes(titleComp, descriptionComp, color = id)) + geom_point()
####### beeswarm#######
beeswarm(descriptionComp ~ titleComp, data = all_news_sentiment, 
         log = TRUE, pch = 16, col = rainbow(8), corral = "omit",
         main = 'beeswarm')
#######
ggplot(sentiment, aes(title, description, color = id)) + geom_point()
#######gcorr######
ggcorr(sentiment)
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
 

