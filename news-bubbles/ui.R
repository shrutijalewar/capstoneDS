
library("shiny")
library("DT")
library("tidyverse")
library("dplyr")
library("highcharter")
library("magrittr")
library("irlba")



# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    # Application title
    "News Bubble",
    tabPanel("Introduction",
             fluidRow(
               column(4, img(width = 500, height = 600, src="wordle.png")),
               column(7,
                      #wellPanel(
                        shiny::h1("News Bubble"),
                      span("American life and media consumption has become extremely"), a("politically polar", 
                      href="https://www.washingtonpost.com/news/politics/wp/2017/11/13/how-polarization-and-splintered-media-are-fostering-a-world-of-doubt/?utm_term=.e4d2f0e8b55e", target="_blank"),
                      span("especially in recent times. According to a"), a("study by Pew Research Center", 
                      href="http://www.journalism.org/2014/10/21/political-polarization-media-habits/",target = '_blank'),
                      span("It’s not just about the public’s views on issues, but the way they use media (including social media) 
                          and talk about politics with other people. While the most consistent liberals and conservatives both 
                        tend to drive broader political discussion, they do so with news and analyses drawn from very different 
                        segments of the media landscape, inhabiting a bubble. A filter bubble is a state of intellectual 
                        isolation that can result from personalized searches and media habits. This is my attempt at analyzing 
                        and clustering news content from differnet news domains."),
                      shiny::h4("Data Question:", a("Github", href="https://github.com/shrutijalewar/capstoneDS", target="_blank")),
                        p("I wanted to explore how news articles clustered and how they scored on the sentiment score."),
                          tags$ul(
                            tags$li("Is there a pattern in the sentiment score based on its source/publication?"),
                            tags$li("How does the sentiment score change with different topics?"),
                            tags$li("Is there an obvious and discernible pattern?"),
                            tags$li("Do the new articles they cluster based on publication?"),
                            tags$li("Do they cluster based on content?")
                              ),
                      shiny::h4("Data Source:", a("NewsApi",href="https://newsapi.org/docs/endpoints/everything",target="_blank")),  
                             p("News articles for this study were collected from an NewsApi.It is a simple HTTP REST API for searching and retrieving live articles from all over the web.
                               You can search for articles with any combination of the following criteria: keyword or phrase, date published, source name, source domain name and language."),
                        p("You can sort the results that are nested JSON response, in the following orders:Date published, Relevancy to search keyword or Popularity of source.
                          For the purpose of this study I specifically searched for articles from the following sources: al-jazeera-english', 'bloomberg', 'breitbart-news', 'fox-news',
                          'msnbc', 'politico', 'reuters', 'the-american-conservative', 'the-hill','the-huffington-post', 'the-new-york-times', 'the-wall-street-journal',
                          'the-washington-post and sorted them based on their published date."),
                      shiny::h4("Sentiment Analysis:", a("VADER", href="https://github.com/cjhutto/vaderSentiment", target="_blank")),
                      p("For sentiment analysis I used an nltk package VADER, or the Valence Aware Dictionary and sEntiment Reasoner is a lexicon and rule-based sentiment analysis library 
                         The VADER sentiment lexicon is sensitive both the polarity and the intensity of sentiments expressed in social media contexts, and is also generally applicable 
                        to sentiment analysis in other domains."),
                      p("The compound score, which is used in this project is a 'normalized, weighted composite score'. It is computed by adding the valence scores of each word in the lexicon, 
                        that are adjusted according to the rules, and then are normalized to be between -1 (most extreme negative) and +1 (most extreme positive). 
                        This according to the authors is the most useful metric if you want a single unidimensional measure of sentiment for a given sentence. "
                        ),
               shiny::h4("Topic Clustering:", a("LDA", href="https://radimrehurek.com/gensim/models/ldamodel.html", target="_blank")),
               p("Latent Dirichlet allocation-LDA (not to be confused with Linear Discriminant Analysis) is a generative statistical 
                 model that allows sets of observations to be explained by unobserved groups that explain why some parts of the data are similar. 
                 This module allows both LDA model estimation from a training corpus and inference of topic distribution on new, unseen documents. 
                 The model can also be updated with new documents for online training."),
               p("In more detail, LDA represents documents as mixtures of topics that spit out words with certain probabilities. 
                  It assumes that documents are produced in the following fashion: when writing each document, you:"),
               tags$ul( 
                 tags$li("Decide on the number of words N the document will have (say, according to a Poisson distribution)."),
                 tags$li("Choose a topic mixture for the document (according to a Dirichlet distribution over a fixed set of K topics)")
                 ),#ul
               p("")
               ), #col 7
               column(1)
                 )#fluidRow
             ),#tabpanel
    tabPanel("Sentiment Analysis",
             fluidRow(
               column(4,
                      wellPanel(  
                        shiny::h4("Filter"),
                        textInput('title', "Enter Title Text Here",""),
                        textInput('description', "Enter Description Text Here",""),
                        actionButton("submit","Submit"),
                        shiny::h4("Looking for Suggestions? Try these:"),
                        tags$ul(
                          tags$li("North Korea"),
                          tags$li("China"),
                          tags$li("Migrants"),
                          tags$li("Trump"),
                          tags$li("White House"),
                          tags$li("World Cup"),
                          tags$li("Washington"),
                          tags$li("Supreme Court"),
                          tags$li("Texas"),
                          tags$li("Shooting")
                          
                        )
                      )
               ),
               
               column(4,
                      wellPanel(
                        fluidRow(
                          highchartOutput("hTitle", height = "400px")
                          )
                        )
                      ),
                column(4,
                       wellPanel(
                         fluidRow(
                           highchartOutput("hDescription", height = "400px")
                         )
                       )
                    )
                    
             ),#fluidRow
             
               fluidRow(
                  column(4),
                      column(8,
                             wellPanel(
                               highchartOutput("hTreemap", height = "300px")
                      )
                  )
             )
             
    ),#tabPanel
    tabPanel("Articles",
             fluidPage(
               fluidRow(
                 column(12,
                        DT::dataTableOutput("mytable")
                 )
               )
             )
    ),
    tabPanel("Topic Clustering",
             fluidRow(
               column(2,
                      a("Topic Clustering on title only", href="vis10.html", target="_blank")),
               column(8,
                      mainPanel(
                        includeHTML("www/vis10_nameTitle.html")#,
                        #includeHTML("data/vis10.html")
                      )
               ),
               column(2)
             )
    )
  )#navbar
)#shiny

