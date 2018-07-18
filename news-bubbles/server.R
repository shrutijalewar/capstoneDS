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
library("ggplot2")
library("ggvis")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$mytable = DT::renderDataTable (DT::datatable ({
    sentiment_link <- sentiment %>% mutate(urlToImage = paste0("<a href=",url,">","<img src=",urlToImage," height='104'></img></a>")) %>% 
      select(name,title, description, author,urlToImage)
  }, escape = FALSE))
  })
  
  
  
#})
