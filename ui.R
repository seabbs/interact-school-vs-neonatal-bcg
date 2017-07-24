## Load packages
library(shiny)
library(shinydashboard)
library(shinyBS)
library(tidyverse)
library(rmarkdown)

sidebar <- dashboardSidebar(
  hr(),
  sidebarMenu(id = "tabs",
              menuItem("Model", tabName = "readme", icon=icon("line-chart")),
              menuItem("About", tabName = "readme", icon=icon("mortar-board")),
              menuItem("Code",  icon = icon("code"),
                       menuSubItem("Github", href = "https://github.com/seabbs/interact-school-vs-neonatal-bcg", icon = icon("github")),
                       menuSubItem("ui.R", tabName = "ui", icon = icon("angle-right")),
                       menuSubItem("server.R", tabName = "server", icon = icon("angle-right"))
              )
  ),
  hr(),
  helpText("Developed by ", a("Sam Abbott", href="http://samabbott.co.uk"), 
           style="padding-left:1em; padding-right:1em;position:absolute; bottom:1em; ")
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "readme",
            withMathJax(), 
            includeMarkdown("README.md")
    ),
    tabItem(tabName = "ui",
            box( width = NULL, status = "primary", solidHeader = TRUE, title="UI",
                 downloadButton('downloadData2', 'Download'),
                 br(),br(),
                 pre(includeText("ui.R"))
            )
    ),
    tabItem(tabName = "server",
            box( width = NULL, status = "primary", solidHeader = TRUE, title="Server",
                 downloadButton('downloadData3', 'Download'),
                 br(),br(),
                 pre(includeText("server.R"))
            )
    )
  )
)

dashboardPage(
  dashboardHeader(title = "School vs Neonatal"),
  sidebar,
  body,
  skin = "green"
)