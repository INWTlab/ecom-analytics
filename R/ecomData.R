#' Load example dataset
#' 
#' @export
ecomData <- function() {
  filename <- system.file("extdata", "ecomData.csv", package = "ecomAnalytics")
  ecomData <- read.csv(filename)
}
