library(testthat)

context('testing data prepration')

expectTrue <- function(x) {
  testthat::expect_true(x)
}

test_that("Correct Data Preparation Output", {
  # browser()
  # ecomData <- read.table('tests/testdata/ecomData.csv', header = TRUE, sep = ',')
  ecomData <- read.table('../testdata/ecomData.csv', header = TRUE, sep = ',')

  ecomData <- prepData(ecomData)

  expectTrue(length(ecomData) == 14)
  expectTrue(is.factor(ecomData$Month))
  expectTrue(is.factor(ecomData$Weekday))
  expectTrue(is.factor(ecomData$Hour))
  expectTrue(is.Date(ecomData$DateComplete))
})

