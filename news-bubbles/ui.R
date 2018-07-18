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
library("highcharter")
library("magrittr")


# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    # Application title
    "News Bubble",
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

