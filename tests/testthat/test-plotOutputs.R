library(testthat)

context("testing plot outputs")

expectTrue <- function(x) {
  testthat::expect_true(x)
}


test_that("Time Plot Outputs for Shop Level Analytics are correct", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  timeVar <- "Month"

  plot <- timeDist(ecomData, timeVar)

  expectTrue(!is.null(plot))
  expectTrue(length(plot$data) == 2)
  expectTrue(plot$labels$x == timeVar)
  expectTrue(plot$labels$y == paste("Orders per", timeVar))
})



test_that("Trend Plot Outputs for Shop Level Analytics are correct", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  dateSpan <- c("2011-01-05", "2011-07-08")
  trendVar <- "Quantity"

  plot <- trendDist(ecomData, dateSpan,  trendVar)

  expectTrue(!is.null(plot))
  expectTrue(length(plot$data) == 2)
  expectTrue(plot$labels$y == trendVar)
  expectTrue(plot$labels$x == "Period")
})



test_that("Time Plot Outputs for Individual Level Analytics are correct", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  timeVarI <- "Month"
  customerID <- "17293"
  dateSpan <- c("2011-01-05", "2011-07-08")

  plot <- timeDistI(ecomData, customerID, timeVarI)

  expectTrue(!is.null(plot))
  expectTrue(length(plot$data) == 2)
  expectTrue(plot$labels$x == timeVarI)
  expectTrue(plot$labels$y == paste("Orders per", timeVarI))
})



test_that("Trend Plot Outputs for Individual Level Analytics are correct", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  dateSpan <- c("2011-01-05", "2011-07-08")
  customerID <- "17293"
  trendVarI <- "Quantity"

  plot <- trendDistI(ecomData, customerID, dateSpan, trendVarI)

  expectTrue(!is.null(plot))
  expectTrue(length(plot$data) == 2)
  expectTrue(plot$labels$y == trendVarI)
  expectTrue(plot$labels$x == "Period")
})
