#' Plot Output Functions

#' @export
#' @rdname kpiFunctions
trendDist <- function(ecomData, dateSpan, trendVar) {
  trendData <- ecomData %>% filter(
    (DateComplete > dateSpan[1]) & (DateComplete < dateSpan[2]))  %>%
    group_by(DateComplete) %>% summarise(summation = sum(get(trendVar)))

  ggplot(trendData, aes(x = DateComplete, y = summation)) +
    geom_line(color = "#b3d0ec") + labs(x = "Period", y = trendVar)
}

#' @export
#' @rdname kpiFunctions
timeDist <- function(ecomData, timeVar) {
  timeDistribution <- ecomData %>%
    group_by(get(timeVar)) %>% summarise(Orders = length(get(timeVar)))
  if (timeVar == "Weekday") {levels(timeDistribution$`get(timeVar)`) <- seq(1:7)}

  ggplot(timeDistribution, aes(`get(timeVar)`, Orders)) +
    geom_col(fill = "#b3d0ec") +
    labs(x = timeVar, y = paste("Orders per", timeVar)) +
    scale_x_discrete(drop = FALSE)
}

#' @export
#' @rdname kpiFunctions
trendDistI <- function(ecomData, customerID, dateSpan, trendVarI) {
  ecomData <- ecomData %>%  filter(CustomerID == customerID)
  trendData <- ecomData %>%
    filter( (DateComplete > dateSpan[1]) & (DateComplete < dateSpan[2]))  %>%
    group_by(DateComplete) %>% summarise(summation = sum(get(trendVarI)))

  ggplot(trendData,   aes(x = DateComplete, y = summation)) +
    geom_line(color = "#b3d0ec") +
    labs(x = "Period", y = trendVarI) +
    geom_point()
}

#' @export
#' @rdname kpiFunctions
timeDistI <- function(ecomData, customerID, timeVarI) {
  timeDistribution <- ecomData %>% filter(CustomerID == customerID) %>%
    group_by(get(timeVarI)) %>% summarise(Orders = length(get(timeVarI)))
  if (timeVarI == "Weekday") {levels(timeDistribution$`get(timeVarI)`) <- seq(1:7)}

  ggplot(timeDistribution, aes(`get(timeVarI)`, Orders)) +
    geom_col(fill = "#b3d0ec") +
    labs(x = timeVarI, y = paste("Orders per", timeVarI)) +
    scale_x_discrete(drop = FALSE)
}
