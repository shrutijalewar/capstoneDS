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
      filter(str_detect(str_to_lower(title), str_to_lower(input$title))) %>%
      filter(str_detect(str_to_lower(description), str_to_lower(input$description))) %>%
      group_by(name) %>%
      summarise(titlePos = mean(titlePos), titleNeg = mean(titleNeg), titleNeut = mean(titleNeut),titleComp = mean(titleComp),
                descriptionPos = mean(descriptionPos), descriptionNeg = mean(descriptionNeg),
                descriptionNeut = mean(descriptionNeut), descriptionComp = mean(descriptionComp)) %>%
      
      arrange(name)
     
  })
  
  sentiment_count <- reactive({
    sentiment %>%
      filter(str_detect(str_to_lower(title), str_to_lower(input$title))) %>%
      filter(str_detect(str_to_lower(description), str_to_lower(input$description))) %>%
      count(name) %>% 
      arrange(name)
  })
  
  output$hTitle <- renderHighchart({
    
    hc <- highchart() %>%
      hc_add_series(data = sentiment_bar()$titleComp, 
                    type = "bar",
                    name = "Mean Sentiment Score",
                    showInLegend = FALSE) %>% 
      
      hc_title(text = "The Average Sentiment Score of Title",
               style = list(fontWeight = "bold")) %>% 
      hc_subtitle(text = "Difference in the sentiment across publications") %>% 
      hc_tooltip(valueDecimals = 2,
                 pointFormat = "Score: {point.y}") %>% 
      hc_xAxis(categories = sentiment_bar()$name,
               tickmarkPlacement = "on",
               opposite = FALSE) %>%
      hc_credits(enabled = TRUE, 
                 text = "Sources: News Api",
                 style = list(fontSize = "12px"))
    hc #%>% hc_add_theme(hc_theme_538())
  })
  
  output$hDescription <- renderHighchart({
    
    hc <- highchart() %>%
      hc_add_series(data = sentiment_bar()$descriptionComp, 
                    type = "bar",
                    name = "Mean Sentiment Score",
                    showInLegend = FALSE) %>% 
      
      hc_title(text = "The Average Sentiment Score of Description",
               style = list(fontWeight = "bold")) %>% 
      hc_subtitle(text = "Difference in the sentiment across publications") %>% 
      hc_tooltip(valueDecimals = 2,
                 pointFormat = "Score: {point.y}") %>% 
      hc_xAxis(categories = sentiment_bar()$name,
               tickmarkPlacement = "on",
               opposite = TRUE) %>%
      hc_credits(enabled = TRUE, 
                 text = "Sources: News Api",
                 style = list(fontSize = "12px")) 
    hc
  })
  
  output$hTreemap <- renderHighchart({
    
    hc <- highchart() %>%
      hc_add_series(
        data = sentiment_count()$n,
        name = "Number of Articles",
        type = "column",
        showInLegend = FALSE
          ) %>% 
      
      hc_title(text = "The Number of Articles",
               style = list(fontWeight = "bold")) %>% 
      hc_subtitle(text = "Number of Articles across Publications") %>% 
      hc_tooltip(valueDecimals = 0,
                 pointFormat = "#: {point.y}") %>% 
      hc_xAxis(categories = sentiment_bar()$name,
               tickmarkPlacement = "on",
               opposite = FALSE) %>%
      hc_credits(enabled = TRUE, 
                 text = "Sources: News Api",
                 style = list(fontSize = "12px")) 
    hc
  })
  
  output$mytable = DT::renderDataTable (DT::datatable ({
    sentiment_link <- sentiment %>% 
      filter(str_detect(str_to_lower(title), str_to_lower(input$title))) %>%
      filter(str_detect(str_to_lower(description), str_to_lower(input$description))) %>%
      mutate(urlToImage = paste0("<a href=",url," target='_blank'>","<img src=",urlToImage," height='104'></img></a>")) %>% 
      select(name,title, description, author,urlToImage)
  }, escape = FALSE))
  })
  
  
  
#})
