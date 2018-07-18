#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library("tidyverse")
library("dplyr")
library("magrittr")
library("ggplot2")
library("ggvis")

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    # Application title
    "News Bubble",
    tabPanel("LDA Topic Clustering",
             fluidRow(
               column(2,
                      selectInput("vis", "Clustering Criteria", c("Publication Name + Title" = "data/vis10_nameTitle.html", "Title Only" = "data/vis10.html"),selected = 'Title Only')
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
    tabPanel("Sentiment Analysis",
             fluidRow(
               column(3,
                      wellPanel(  
                        h4("Filter"),
                        # Sidebar with a slider input for number of bins 
                        # sidebarLayout(
                        # sidebarPanel(
                        sliderInput("year", "Year Released", 1890, 2018, value = c(1950, 2014), sep = ''),
                        sliderInput("averageRating", "IMDB Rating", 1, 10, value = c(4, 9)),
                        sliderInput("revenue", "Revenue in USD",0, 2000000000, value = c(0,1500000000)),
                        sliderInput("budget", "Budget in USD",0, 300000000, value = c(0,200000000)),
                        selectInput("gender", "Gender of Director", c("All", "male", "female"),selected = 'All'),
                        selectInput("genres", "Genre (a movie can have multiple genres)",
                                    c("All", "Action", "Adventure", "Animation", "Biography", "Comedy",
                                      "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
                                      "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
                                      "Short", "Sport", "Thriller", "War", "Western"),selected = 'All')
                      ),
                      wellPanel(
                        h4("Select Your Axis")
                       # selectInput("xvar", "X-axis variable", axis_vars, selected = "year"),
                       # selectInput("yvar", "Y-axis variable", axis_vars, selected = "averageRating")
                      )
               ),
               
               column(9,
                      
                      # Show a plot of the generated distribution
                      # mainPanel(
                      wellPanel(
                        fluidRow(
                          
                          )
                        )
                       # ggvisOutput("plot")
                      
                      
               )#col9
             )#fluidRow
    ),#tabPanel
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

