
library(shiny)
library(DT)
library("tidyverse")
library("dplyr")
library("highcharter")
library("magrittr")


# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    # Application title
    "News Bubble",
    
    tabPanel("Introduction",
             fluidRow(
               tags$h1("News Bubble"),
               column(2),
               
               column(8,
                      wellPanel(
                        tags$img(src="data/wordle", width = "100px", height = "100px") 
                      )
               ),
               column(2)
             ),#fluidRow
             fluidRow(
               column(12,
                      wellPanel(
                        span("One of the most enduring tools to measure Hollywood’s gender bias is a test originally promoted by cartoonist Alison Bechdel
                             in a 1985"), a("comic strip",href="http://alisonbechdel.blogspot.com/2005/08/rule.html",target="_blank"), span("from her"), a(" “Dykes To Watch Out For”", href="http://dykestowatchoutfor.com/", target="_blank"), 
                        span("series. Bechdel said that if a movie can satisfy three criteria — "),
                        tags$ol(tags$li("There are at least two named women in the picture. "),
                                tags$li("They have a conversation with each other at some point. "),
                                tags$li("That conversation isn’t about a male character. ")
                        ),
                        span("Then it passes “The Rule,” whereby female characters are allocated a bare minimum of depth."),
                        span("Using Bechdel scores data from "),a("bechdeltest.com,", href = "https://bechdeltest.com/", target="_blank"), a("Kaggle,",href="https://www.kaggle.com/rounakbanik/the-movies-dataset/data",target="_blank"),
                        a("imdb datasets,", href="http://www.imdb.com/interfaces/", target="_blank"), span(" and a "),a("gender-prediction package", href="https://cran.r-project.org/web/packages/gender/vignettes/predicting-gender.html", target="_blank"),
                        span(" and, I analyzed over 5000 films released from 1895 to 2017 to examine the relationship between the prominence of women in a film and the gender of film’s director, genre, 
                             ratings, budget and revenue.")
                        ))),
             ),#tabpanel
    tabPanel("Sentiment Analysis",
             fluidRow(
               column(4,
                      wellPanel(  
                        h4("Filter"),
                        
                        textInput('title', "Enter Title Text Here","")
                        ,
                        textInput('description', "Enter Description Text Here","")
                        ,
                        actionButton("submit","Submit")
                      )
               ),
               
               column(4,
                      
                      # Show a plot of the generated distribution
                      # mainPanel(
                      wellPanel(
                        fluidRow(
                          highchartOutput("hTitle", height = "500px")
                          )
                        )
                      ),
                column(4,
                       
                       # Show a plot of the generated distribution
                       # mainPanel(
                       wellPanel(
                         fluidRow(
                           highchartOutput("hDescription", height = "500px")
                         )
                       )
                    )
                    
             ),#fluidRow
             
               fluidRow(
                  column(4),
                  
                      column(8,
                             wellPanel(
                               highchartOutput("hTreemap", height = "500px")
                      )
                  )
             )
             
    ),#tabPanel
    tabPanel("LDA Topic Clustering",
             fluidRow(
               column(2,
                      selectInput("vis", "Clustering Criteria", c("Name + Title" = "data/vis10_nameTitle.html", "Title Only" = "data/vis10.html"),selected = 'Title Only')
               ),
               column(8,
                      mainPanel(
                        #plotOutput("distPlot"),
                        includeHTML("data/vis10_nameTitle.html")
                      )
               ),
               column(2)
             )
    ),
    tabPanel("Data Table",
             fluidPage(
               fluidRow(
                 column(12,
                        DT::dataTableOutput("mytable")
                 )
               )
             )
    )
  )#navbar
)#shiny

