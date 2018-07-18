#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
setwd('/Users/ssharma/code/nss-ds/capstoneDS/news-bubbles/')
all_news_sentiment <- read_csv('data/all_news_sentiment.csv')
sentiment <- all_news_sentiment %>% 
  select(name,`Unnamed: 0`, title, description, author,	publishedAt, url,	urlToImage,	id, titlePos,	titleNeg,	titleNeut,	titleComp,	descriptionPos,	descriptionNeg,	descriptionNeut,
         descriptionComp) 
library(shiny)
library(DT)
library("tidyverse")
library("dplyr")
library("magrittr")
library("highcharter")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  sentiment_bar <- reactive({
    sentiment %>%
      #filter(between(year, input$year[1], input$year[2])) %>%
      #filter(date_of_month %in% c(6, 13, 20)) %>%
      #mutate(day = ifelse(date_of_month == 13, "thirteen", "not_thirteen")) %>%
      group_by(id) %>%
      filter(str_detect(str_to_lower(title), str_to_lower(input$title))) %>%
      filter(str_detect(str_to_lower(description), str_to_lower(input$description))) %>%
      summarise(titlePos = mean(titlePos), titleNeg = mean(titleNeg), titleNeut = mean(titleNeut),titleComp = mean(titleComp),
                                descriptionPos = mean(descriptionPos), descriptionNeg = mean(descriptionNeg),
                               descriptionNeut = mean(descriptionNeut), descriptionComp = mean(descriptionComp)) %>%
      arrange(id)
      #xvar = paste0('title', Comp)
  })
  
  output$hTitle <- renderHighchart({
    
    hc <- highchart() %>%
      hc_add_series(data = sentiment_bar()$titleComp, 
                    type = "bar",
                    name = "Mean Sentiment Score",
                    showInLegend = FALSE) %>% 
      
      hc_title(text = "The Aggregate Sentiment Score on Title",
               style = list(fontWeight = "bold")) %>% 
      hc_subtitle(text = "Difference in the sentiment across differnt publications") %>% 
      hc_tooltip(valueDecimals = 2,
                 pointFormat = "Score: {point.y}") %>% 
      hc_xAxis(categories = sentiment_bar()$id,
               tickmarkPlacement = "on",
               opposite = FALSE) %>%
      hc_credits(enabled = TRUE, 
                 text = "Sources: News Api",
                 style = list(fontSize = "10px"))
    hc #%>% hc_add_theme(hc_theme_538())
  })
  
  output$hDescription <- renderHighchart({
    
    hc <- highchart() %>%
      hc_add_series(data = sentiment_bar()$descriptionComp, 
                    type = "bar",
                    name = "Mean Sentiment Score",
                    showInLegend = FALSE) %>% 
      
      hc_title(text = "The Aggregate Sentiment Score on Description",
               style = list(fontWeight = "bold")) %>% 
      hc_subtitle(text = "Difference in the sentiment across differnt publications") %>% 
      hc_tooltip(valueDecimals = 2,
                 pointFormat = "Score: {point.y}") %>% 
      hc_xAxis(categories = sentiment_bar()$id,
               tickmarkPlacement = "on",
               opposite = TRUE) %>%
      hc_credits(enabled = TRUE, 
                 text = "Sources: News Api",
                 style = list(fontSize = "10px")) 
    hc
  })
  
  output$mytable = DT::renderDataTable (DT::datatable ({
    sentiment_link <- sentiment %>% mutate(urlToImage = paste0("<a href=",url,">","<img src=",urlToImage," height='104'></img></a>")) %>% 
      select(name,title, description, author,urlToImage)
  }, escape = FALSE))
  })
  
  
  
#})
