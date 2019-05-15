library(testthat)

context("testing table outputs")

expectTrue <- function(x) {
  testthat::expect_true(x)
}

test_that("Correct Table Outputs for Shop Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  numProducts <- "5"
  dateSpan <- c("2010-01-05", "2015-07-08")
  prodTop <- calcTopProductsShop(ecomData, numProducts, dateSpan)

  expectTrue(length(prodTop) == 3)
  expectTrue(all(colnames(prodTop) == c("StockCode", "Description", "count")))
  expectTrue(length(prodTop$StockCode) == numProducts)
  expectTrue(all(prodTop$count > 0))


  prodLow <- calcLowProductsShop(ecomData, numProducts, dateSpan)
  expectTrue(length(prodLow) == 3)
  expectTrue(all(colnames(prodLow) == c("StockCode", "Description", "count")))
  expectTrue(length(prodLow$StockCode) == numProducts)
  expectTrue(all(prodLow$count > 0))
  expectTrue(any(prodLow != prodTop))
})

test_that("Correct Empty Table Output is shown", {
  emptyTable <- emptyProdTable()
  expectTrue(length(emptyTable) == 3)
  expectTrue(length(emptyTable$StockCode) == 0)
  expectTrue(all(colnames(emptyTable) == c("StockCode", "Description", "Count")))
})

test_that("Correct Table Outputs for Individual Level Analytics", {
  ecomData <- read.table("../testdata/ecomData.csv", header = TRUE, sep = ",")
  ecomData <- prepData(ecomData)
  numProducts <- "5"
  dateSpan <- c("2010-01-05", "2015-07-08")
  customerID <- "17850"
  prodTop <- calcTopProductsI(ecomData, customerID, numProducts, dateSpan)

  expectTrue(length(prodTop) == 3)
  expectTrue(all(colnames(prodTop) == c("StockCode", "Description", "count")))
  expectTrue(length(prodTop$StockCode) == numProducts)
  expectTrue(all(prodTop$count > 0))

  prodLow <- calcLowProductsI(ecomData, customerID, numProducts, dateSpan)
  expectTrue(length(prodLow) == 3)
  expectTrue(all(colnames(prodLow) == c("StockCode", "Description", "count")))
  expectTrue(length(prodLow$StockCode) == numProducts)
  expectTrue(all(prodLow$count > 0))
  expectTrue(any(prodLow != prodTop))
})
