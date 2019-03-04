Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")
options(shiny.maxRequestSize = 60 * 1024 ^ 2)
library("shiny")
library("DT")
library("ecomAnalytics")
library("ggplot2")
library("lubridate")
library("dplyr")

sessionInfo()

if (!interactive()) sink(stderr(), type = "output")
shinyServer(function(input, output, session) {


### Input Data ###
  inputType <- reactive({
    input$inputType
  })

  getExampleData <- reactive({
    ecomData <- read.csv("../../data/ecomData.csv")
    ecomData
  })

  getRawData <- reactive({
    req(input$file1)
    ecomData <- read.csv(input$file1$datapath,
                         header = input$header,
                         sep = input$sep)
    ecomData
  })

  getData <- reactive({
    if (inputType() == "Example Dataset") ecomData <- getExampleData()
    else ecomData <- getRawData()
    #data transformations
    ecomData <- prepData(ecomData)
    ecomData
  })


### Shop Level Analytics ###

  getRevenueKpi <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      revenue <- calcRevenueShop(ecomData)
    } else {
      revenue <- "0"
    }
  })

  output$revenueKpi <- renderPrint({
    revenue <- getRevenueKpi()
    infoBox(title = "Total Revenue", revenue, icon = icon("dollar"),
            color = "black", width = 12)
  })

  getCustomersKpi <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      customers <- calcCustomersShop(ecomData)
    } else {
      customers <- "0"
    }
  })

  output$customersKpi <- renderPrint({
    customers <- getCustomersKpi()
    infoBox("Total Customers", customers, icon = icon("users"),
            color = "black", width = 12)
  })

  getNumProductsKpi <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      numProducts <- calcNumProdsShop(ecomData)
    } else {
      numProducts <- "0"
    }
  })

  output$numProductsKpi <- renderPrint({
    numProducts <- getNumProductsKpi()
    infoBox("Total Number of dif. Products", numProducts, icon = icon("cube"),
            color = "black", width = 12)
  })

  getTopProducts <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      top <- calcTopProductsShop(ecomData, numProducts = input$numProducts,
                                 dateSpan = input$productsSpanVar)
    } else {
      top <- emptyProdTable()
    }
    top
  })

  output$topProducts <- renderTable({
    getTopProducts()
  })

  getLowProducts <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      low <- calcLowProductsShop(ecomData, numProducts = input$numProducts,
                                 dateSpan = input$productsSpanVar)
    } else {
      low <- emptyProdTable()
    }
    low
  })

  output$lowProducts <- renderTable({
    getLowProducts()
  })

  getTrend <- reactive({
    ecomData <- getData()
    plot <- trendDist(ecomData, dateSpan = input$trendSpanVar,
                      trendVar = input$trendVar)
    plot
  })

  output$trend <- renderPlot({
    getTrend()
  })

  getTimeAnalysis <- reactive({
    ecomData <- getData()
    plot <- timeDist(ecomData, timeVar = input$timeVar)
    plot
})

  output$time <- renderPlot({
    getTimeAnalysis()
  })


### Individual Level Analysis ###

  getRevenueKpiI <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      revenue <- calcRevenueI(ecomData, customerID = input$customerId)
    } else {
      revenue <- "0"
    }
  })

  output$revenueKpiI <- renderPrint({
    revenue <- getRevenueKpiI()
    infoBox(title = "Total Revenue", revenue, icon = icon("dollar"),
            color = "black", width = 12)
  })

  getQuantileKpiI <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
     revenue <- calcQuantileI(ecomData, customerID = input$customerId)
    } else {
      "0"
    }
  })

  output$quantileKpiI <- renderPrint({
    quantile <- getQuantileKpiI()
    infoBox("Customer's Quantile (by Revenue)", paste0("Top ", quantile, "%"),
            icon = icon("tachometer"), color = "black", width = 12)
  })

  getNumProductsKpiI <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      numProducts <- calcNumProdsI(ecomData, customerID = input$customerId)
    } else {
      numProducts <- "0"
    }
  })

  output$numProductsKpiI <- renderPrint({
    numProducts <- getNumProductsKpiI()
    infoBox("Total Number of dif. Products", numProducts, icon = icon("cube"),
            color = "black", width = 12)
  })

  getTopProductsI <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      top <- calcTopProductsI(ecomData, customerID = input$customerId,
                              numProducts = input$numProductsI,
                              dateSpan = input$productsSpanVarI)
    } else {
      top <- emptyProdTable()
    }
    top
  })

  output$topProductsI <- renderTable({
    getTopProductsI()
  })

  getLowProductsI <- reactive({
    if (inputType() != "File" | !is.null(input$file1)){
      ecomData <- getData()
      low <- calcLowProductsI(ecomData, customerID = input$customerId,
                              numProducts = input$numProducts,
                              dateSpan = input$productsSpanVarI)
    } else {
      low <- emptyProdTable()
    }
    low
  })

  output$lowProductsI <- renderTable({
    getLowProductsI()
  })

  getTrendI <- reactive({
    ecomData <- getData()
    plot <- trendDistI(ecomData, customerID = input$customerId,
                       dateSpan = input$trendSpanVarI,
                       trendVarI = input$trendVarI)
    plot
  })

  output$trendI <- renderPlot({
    getTrendI()
  })

  getTimeAnalysisI <- reactive({
    ecomData <- getData()
    plot <- timeDistI(ecomData, customerID = input$customerId,
                      timeVarI = input$timeVarI)
    plot

    })

  output$timeI <- renderPlot({
    getTimeAnalysisI()

  })


  ### Raw Data ###
  output$rawDataOverview <- renderDataTable({
    if (inputType() == "File" && is.null(input$file1)){
      DT::datatable(data.frame(emptyTable = 0))
    }
    else {
      ecomData <- getData()
      DT::datatable(head(ecomData, n = 1000),
                    options = list(scrollX = TRUE))
    }
  })


 ### Observing Actions ###
  observe({
    if (inputType() == "File" && !is.null(input$file1))
      updateTabsetPanel(session, "Reiter", selected = "tab3")
  })

  observe({
    if (inputType() == "Example Dataset")
      updateTabsetPanel(session, "Reiter", selected = "tab3")
  })


  observe({
    showNotification("Switch to 'Example Data' on the menu of the sidebar to explore the dashboard
                     with already available data or upload your own data.
                      The expected upload format can be seen in the tab 'Raw Data' after loading example data.",
                     type = "warning", duration = 300)

    showNotification("Welcome to this sample dashboard!
                      Its main purpose is to offer a dynamic example for the associated blog article
                      'Best Practices: Entwicklung robuster Shiny Dashboards als R-Pakete'.",
                      type = "warning", duration = 200)
  })

  outVar <- reactive({
    ecomData <- getData()
    sort(unique(as.character(ecomData$CustomerID)))
  })

  observe({
    if (input$Reiter == "tab2") {
      updateSelectInput(session, "customerId", choices = outVar()) #data()$customerID #c(output$outVar)
    }
  })

})
