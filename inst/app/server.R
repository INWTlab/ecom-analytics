library("shiny")
library("ecomAnalytics")

function(input, output, session) {
  ### Input Data ###
  inputType <- reactive({
    input$inputType
  })

  getExampleData <- reactive({
    ecomData()
  })

  getDataUser <- reactive({
    req(input$file1)
    ecomData <- read.csv(input$file1$datapath,
                         header = input$header,
                         sep = input$sep)
    ecomData
  })

  getRawData <- reactive({
    if (inputType() == "Example Dataset") getExampleData()
    else getDataUser()
  })

  getData <- reactive({
    prepData(getRawData())
  })

  ### Shop Level Analytics ###
  getRevenueKpi <- reactive({
    calcRevenueShop(getData())
  })

  output$revenueKpi <- renderPrint({
    revenue <- getRevenueKpi()
    infoBox(title = "Total Revenue", revenue, icon = icon("dollar"),
            color = "black", width = 12)
  })

  getCustomersKpi <- reactive({
    calcCustomersShop(getData())
  })

  output$customersKpi <- renderPrint({
    customers <- getCustomersKpi()
    infoBox("Total Customers", customers, icon = icon("users"),
            color = "black", width = 12)
  })

  getNumProductsKpi <- reactive({
    calcNumProdsShop(getData())
  })

  output$numProductsKpi <- renderPrint({
    numProducts <- getNumProductsKpi()
    infoBox("Total Number of dif. Products", numProducts, icon = icon("cube"),
            color = "black", width = 12)
  })

  getTopProducts <- reactive({
    calcTopProductsShop(getData(), numProducts = input$numProducts,
                        dateSpan = input$productsSpanVar)
  })

  output$topProducts <- renderTable({
    getTopProducts()
  })

  getLowProducts <- reactive({
    calcLowProductsShop(getData(), numProducts = input$numProducts,
                        dateSpan = input$productsSpanVar)
  })

  output$lowProducts <- renderTable({
    getLowProducts()
  })

  output$trend <- renderPlot({
    trendDist(getData(), dateSpan = input$trendSpanVar,
              trendVar = input$trendVar)
  })

  output$time <- renderPlot({
    timeDist(getData(), timeVar = input$timeVar)
  })

  ### Individual Level Analysis ###
  outVar <- reactive({
    ecomData <- getData()
    sort(unique(as.character(ecomData$CustomerID)))
  })

  observe({
    updateSelectInput(session, "customerId", choices = outVar()) #data()$customerID #c(output$outVar)
  })

  getRevenueKpiI <- reactive({
    calcRevenueI(getData(), customerID = input$customerId)
  })

  output$revenueKpiI <- renderPrint({
    revenue <- getRevenueKpiI()
    infoBox(title = "Total Revenue", revenue, icon = icon("dollar"),
            color = "black", width = 12)
  })

  getQuantileKpiI <- reactive({
    calcQuantileI(getData(), customerID = input$customerId)
  })

  output$quantileKpiI <- renderPrint({
    quantile <- getQuantileKpiI()
    infoBox("Customer's Quantile (by Revenue)", paste0("Top ", quantile, "%"),
            icon = icon("tachometer"), color = "black", width = 12)
  })

  getNumProductsKpiI <- reactive({
    calcNumProdsI(getData(), customerID = input$customerId)
  })

  output$numProductsKpiI <- renderPrint({
    numProducts <- getNumProductsKpiI()
    infoBox("Total Number of dif. Products", numProducts, icon = icon("cube"),
            color = "black", width = 12)
  })

  getTopProductsI <- reactive({
    calcTopProductsI(getData(), customerID = input$customerId,
                     numProducts = input$numProductsI,
                     dateSpan = input$productsSpanVarI)
  })

  output$topProductsI <- renderTable({
    getTopProductsI()
  })

  getLowProductsI <- reactive({
    calcLowProductsI(getData(), customerID = input$customerId,
                     numProducts = input$numProducts,
                     dateSpan = input$productsSpanVarI)
  })

  output$lowProductsI <- renderTable({
    getLowProductsI()
  })

  output$trendI <- renderPlot({
    trendDistI(getData(), customerID = input$customerId,
               dateSpan = input$trendSpanVarI,
               trendVarI = input$trendVarI)
  })

  output$timeI <- renderPlot({
    timeDistI(getData(), customerID = input$customerId,
              timeVarI = input$timeVarI)
  })

  ### Raw Data ###
  output$rawDataOverview <- renderDataTable({
    DT::datatable(getData(),
                  options = list(scrollX = TRUE))
  })

  ### Observing Actions ###
  observeEvent(getData(), {
    updateTabsetPanel(session, "Reiter", selected = "tab3")
  })

  observe({
    showNotification("Switch to 'Example Data' on the menu of the sidebar to explore the dashboard
                     with already available data or upload your own data.
                      The expected upload format can be seen in the tab 'Raw Data' after loading example data.",
                     type = "warning", duration = 10)

    showNotification("Welcome to this sample dashboard!
                      Its main purpose is to offer a dynamic example for the associated blog article
                      'Best Practices: Entwicklung robuster Shiny Dashboards als R-Pakete'.",
                     type = "warning", duration = 5)
  })

}
