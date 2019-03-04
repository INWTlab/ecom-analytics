
#' @export
#' @rdname kpiFunctions
calcTopProductsShop <- function(ecomData, numProducts, dateSpan) {
  ecomData <- ecomData %>%
    filter( (DateComplete > dateSpan[1]) & (DateComplete < dateSpan[2]))
  top <- ecomData %>% group_by(StockCode, Description) %>%
    summarise(count = n()) %>% arrange(desc(count)) %>%
    head(n = as.numeric(numProducts))
}

#' @export
#' @rdname kpiFunctions
emptyProdTable <- function() {
  top <- data.frame(StockCode = as.character(character()),
                    Description = character(),
                    Count = as.numeric(),
                    stringsAsFactors = FALSE)
}

#' @export
#' @rdname kpiFunctions
calcLowProductsShop <- function(ecomData, numProducts, dateSpan) {
  ecomData <- ecomData %>%
    filter( (DateComplete > dateSpan[1]) & (DateComplete < dateSpan[2]))
  low <- ecomData %>% group_by(StockCode, Description) %>%
    summarise(count = n()) %>% arrange(count) %>%
    head(n = as.numeric(numProducts))
}

#' @export
#' @rdname kpiFunctions
calcTopProductsI <- function(ecomData, customerID, numProducts, dateSpan) {
  ecomData <- ecomData %>%
    filter( (DateComplete > dateSpan[1]) & (DateComplete < dateSpan[2]))
  top <- ecomData %>% filter(CustomerID == customerID) %>%
    group_by(StockCode, Description) %>% summarise(count = n()) %>%
    arrange(desc(count)) %>% head(n = as.numeric(numProducts))
}


#' @export
#' @rdname kpiFunctions
calcLowProductsI <- function(ecomData, customerID, numProducts, dateSpan) {
  ecomData <- ecomData %>%
    filter((DateComplete > dateSpan[1]) & (DateComplete < dateSpan[2]))
  top <- ecomData %>% filter(CustomerID == customerID) %>%
    group_by(StockCode, Description) %>% summarise(count = n()) %>%
    arrange(count) %>% head(n = as.numeric(numProducts))
}
