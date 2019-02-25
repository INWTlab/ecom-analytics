library("ecomAnalytics")
library("shiny")
library("shinydashboard")
library('DT')
library('shinyjs')

buttonWidth <- 220
sideBarWidth <- 250

dashboardPage(
  skin = "blue",
  header = panelTitle(sideBarWidth),

  sidebar = dashboardSidebar(
    width = sideBarWidth,
    shinyjs::useShinyjs(),
    panelSelectInput(buttonWidth)
  ),
  body = dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "styleDefinitions.css"
      )),
    div(class = "span", tabsetPanel(
      id = "Reiter",
      tabPanel("Shop Level Analytics", value = "tab1",
               shopLevelKpis(),
               shopLevelProductRanking(),
               shopLevelTimeAnalysis(),
               shopLevelTrendAnalysis()
      ),
      tabPanel("Individual Level Analysis", value = "tab2",
               customerIdSelection(),
               iLevelKpis(),
               iLevelProductRanking(),
               iLevelTimeAnalysis(),
               iLevelTrendAnalysis()
      ),
      tabPanel("Raw Data", value = "tab3", dataTableOutput("rawDataOverview"))
    ))
  )
)
