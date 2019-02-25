#' Start Application
#'
#' @param ... passed to \link[shiny]{runApp}
#'
#'
  #' #' @export
  #' #' @rdname startApplication
  #' startApplication <- function() {
  #'   packageDir <- system.file(package = "EcomAnalytics")
  #'   shiny::runApp(
  #'     paste0(packageDir, "/app"),
  #'     port = 3838,
  #'     host = "0.0.0.0"
  #' }

#' @export
#' @rdname startApplication
startApplicationLocal <- function(...) {
  shiny::runApp("inst/app", ...)
}
