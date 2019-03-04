#' UI Elements
#'
#' @param buttonWidth,sideBarWidth (numeric)
#'

### Side Bar Elements ###

#' @export
#' @rdname uiElements
box <- function(...){
  shinydashboard::box(...)
}


#' @export
#' @rdname uiElements
panelTitle <- function(sideBarWidth) {
  dashboardHeader(
    title = "Ecommerce Analytics",
    titleWidth = sideBarWidth
  )
}

#' @export
#' @rdname uiElements
panelSelectInput <- function(buttonWidth) {
  wellPanel(
    selectInput("inputType", "Select input type",
                choices = c("File", "Example Dataset"),
                selected = "File"),
    conditionalPanel(
      condition = "input.inputType == 'File'",
      fileInput(inputId = "file1", label = "File to be uploaded"),
      checkboxInput("header", "Header", TRUE),
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ",")
    ),
    conditionalPanel(
      condition = "input.inputType == 'Example Dataset'"
    )
    ,
    style = "color:black"
  )
}


### Shop Level Analytics Elements ###

#' @export
#' @rdname uiElements
shopLevelKpis <- function() {
  fluidRow(
    h4("Key Performance Indicators"),
    box(width =  12,
        infoBoxOutput("revenueKpi", width = 4),
        infoBoxOutput("customersKpi", width = 4),
        infoBoxOutput("numProductsKpi", width = 4)
    ))
}

#' @export
#' @rdname uiElements
shopLevelProductRanking <- function() {
  column(width = 6,
         h4("Product Ranking"),
         box(width = 4, wellPanel(
           selectInput("numProducts", label = "Top",
                       selected = 0, choices = c(3, 5, 10)),
           dateRangeInput("productsSpanVar", label = "Time Span",
                          start = "2011-01-01", end = "2011-12-31"))),
         box(width = 4, title = "Most Selling Products",
             tableOutput("topProducts")),
         box(width = 4, title = "Least Selling Products",
             tableOutput("lowProducts"))
  )
}

#' @export
#' @rdname uiElements
shopLevelTimeAnalysis <- function() {
  column(width = 6,
         h4("Time Analysis"),
         box(width = 4, wellPanel(
           selectInput("timeVar", label = "Time Axis", selected = "Month",
                       choices = c("Hour", "Weekday", "Month")))),
         box(width = 8, plotOutput("time"))
  )

}

#' @export
#' @rdname uiElements
shopLevelTrendAnalysis <- function() {
  column(width = 6,
         h4("Trend Analysis"),
         box(width = 4, wellPanel(
           selectInput("trendVar", label = "Variable",
                       selected = "Revenue", choices = c("Sales", "Quantity")),
           dateRangeInput("trendSpanVar", label = "Time Span",
                          start = "2011-01-01", end = "2011-12-31"))),
         box(width = 8, plotOutput("trend"))
  )
}


### Individual Level Analysis Elements ###
#' @export
#' @rdname uiElements
customerIdSelection <- function() {
  wellPanel(
    fluidRow(
      box(width = 12,
          selectInput("customerId", "Select Customer ID", choices = ""))
    ), style = "color:black" )

}

#' @export
#' @rdname uiElements
iLevelKpis <- function() {
  fluidRow(
    h4("Key Performance Indicators"),
    box(width =  12,
        infoBoxOutput("revenueKpiI", width = 4),
        infoBoxOutput("numProductsKpiI", width = 4),
        infoBoxOutput("quantileKpiI", width = 4)
    ))
}

#' @export
#' @rdname uiElements
iLevelProductRanking <- function() {
  column(width = 6,
         h4("Product Ranking"),
         box(width = 4, wellPanel(
           selectInput("numProductsI", label = "Top", selected = 5,
                       choices = c(3, 5, 10)),
           dateRangeInput("productsSpanVarI", label = "Time Span",
                          start = "2011-01-01", end = "2011-12-31"))),
         box(width = 4, title = "Most Bought Products",
             tableOutput("topProductsI")),
         box(width = 4, title = "Least Bought Products",
             tableOutput("lowProductsI"))
  )
}

#' @export
#' @rdname uiElements
iLevelTimeAnalysis <- function() {
  column(width = 6,
         h4("Time Analysis"),
         box(width = 3, wellPanel(
           selectInput("timeVarI", label = "Time Axis", selected = "Month",
                       choices = c("Hour", "Weekday", "Month")))),
         box(width = 9, plotOutput("timeI"))
  )
}

#' @export
#' @rdname uiElements
iLevelTrendAnalysis <- function() {
  column(width = 6,
         h4("Trend Analysis"),
         box(width = 4, wellPanel(
           selectInput("trendVarI", label = "Variable", selected = "Revenue",
                       choices = c("Sales", "Quantity")),
           dateRangeInput("trendSpanVarI", label = "Time Span",
                          start = "2011-01-01", end = "2011-12-01"))),
         box(width = 8, plotOutput("trendI"))
  )
}
