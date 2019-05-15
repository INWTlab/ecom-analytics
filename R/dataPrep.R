#' Data Preparation Functions
#'
#' @param ecomData data object
#'
#' @export
#' @rdname dataPreps
prepData <- function(ecomData) {
  ecomData <- na.omit(ecomData)
  ecomData$StockCode <- as.character(ecomData$StockCode)
  ecomData$Description <- as.character(ecomData$Description)
  ecomData <- ecomData[, -1]
  ecomData$DateComplete <- as.Date(ecomData$Date, "%Y-%m-%d")
  ecomData
}
