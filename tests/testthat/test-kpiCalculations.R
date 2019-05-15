library(testthat)

context("testing kpi calculations")

expectTrue <- function(x) {
  testthat::expect_true(x)
}


test_that("Correct Revenue KPI Output for Shop Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)

  revenue <- calcRevenueShop(ecomData)

  expectTrue(!is.null(revenue))
  expectTrue(!grepl("\\.", revenue))
  expectTrue(revenue > 0)
})

test_that("Correct Customers KPI Output for Shop Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)

  customers <- calcCustomersShop(ecomData)

  expectTrue(!is.null(customers))
  expectTrue(colnames(customers) == "UniqueElements")
  expectTrue(customers > 0)
})

test_that("Correct Number of Products KPI Output for Shop Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)

  numProducts <- calcNumProdsShop(ecomData)

  expectTrue(!is.null(numProducts))
  expectTrue(colnames(numProducts) == "UniqueElements")
  expectTrue(numProducts > 0)
})



test_that("Correct Revenue KPI Output for Individual Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  customerID <- "17850"

  revenue <- calcRevenueI(ecomData, customerID)

  expectTrue(!is.null(revenue))
  expectTrue(revenue > 0)
})

test_that("Correct Quantile KPI Output for Individual Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  customerID <- "17850"

  quantile <- calcQuantileI(ecomData, customerID)

  expectTrue(!is.null(quantile))
  expectTrue( (quantile >= 0) & (quantile <= 100))
})

test_that("Correct Number of Products KPI Output for Individual Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  customerID <- "17850"

  numProducts <- calcNumProdsI(ecomData, customerID)

  expectTrue(!is.null(numProducts))
  expectTrue(colnames(numProducts) == "UniqueElements")
  expectTrue(numProducts > 0)
})
