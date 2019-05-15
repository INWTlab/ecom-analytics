library("ecomAnalytics")
library("shiny")
library("shinydashboard")

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
      tabPanel(
        "Shop Level Analytics", value = "tab1",
        fluidRow(shopLevelKpis()),
        fluidRow(
          shopLevelProductRanking(),
          shopLevelTimeAnalysis()
        ),
        fluidRow(
          shopLevelTrendAnalysis()
        )
      ),
      tabPanel(
        "Individual Level Analysis", value = "tab2",
        fluidRow(customerIdSelection()),
        fluidRow(iLevelKpis()),
        fluidRow(
          iLevelProductRanking(),
          iLevelTimeAnalysis()
        ),
        fluidRow(
          iLevelTrendAnalysis()
        )
      ),
      tabPanel("Raw Data", value = "tab3", dataTableOutput("rawDataOverview"))
    ))
  )
)
