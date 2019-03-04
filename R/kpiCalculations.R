#' Data Preparation Functions

#' @export
#' @rdname kpiFunctions
calcRevenueShop <- function(ecomData) {
  format(round(ecomData %>% select("Sales") %>%  sum()), big.mark = " ")
}
#' @export
#' @rdname kpiFunctions
calcCustomersShop <- function(ecomData) {
  format(round(ecomData %>% summarise(
    UniqueElements = n_distinct(CustomerID))), big.mark = " ")
}

#' @export
#' @rdname kpiFunctions
calcNumProdsShop <- function(ecomData) {
  format(round(ecomData %>% summarise(
    UniqueElements = n_distinct(as.character(StockCode)))),
    big.mark = " ")
}

#' @export
#' @rdname kpiFunctions
calcRevenueI <- function(ecomData, customerID) {
  ecomData <- ecomData %>% filter(CustomerID == customerID)
  revenue <- format(round(ecomData %>% select("Sales") %>%  sum()),
                    big.mark = " ")
}
#' @export
#' @rdname kpiFunctions
calcQuantileI <- function(ecomData, customerID) {
  revenues <- ecomData %>% group_by(CustomerID) %>%
    summarise(revenue = sum(Sales))
  listRevenues <- revenues$revenue
  percentile <- ecdf(listRevenues)
  revenueI <- ecomData %>% filter(CustomerID == customerID) %>%
    group_by(CustomerID) %>% summarise(revenue = sum(Sales))
  revenueI <- revenueI$revenue
  100 - round(percentile(revenueI) * 100, 1)
}

#' @export
#' @rdname kpiFunctions
calcNumProdsI <- function(ecomData, customerID) {
  numProducts <- format(round(
    ecomData %>% filter(CustomerID == customerID) %>%
      summarise(UniqueElements = n_distinct(as.character(StockCode)))),
    big.mark = " ")
}
