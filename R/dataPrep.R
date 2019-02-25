#' Data Preparation Functions

#' @export
#' @rdname dataPreps
prepData <- function(ecomData) {
  ecomData = ecomData[,-1]
  ecomData$Month <-as.factor(ecomData$Month)
  ecomData$Weekday <-as.factor(ecomData$Weekday)
  ecomData$Hour <-as.factor(ecomData$Hour)
  ecomData$DateComplete = as.Date(ecomData$Date, "%Y-%m-%d")
  ecomData
}






