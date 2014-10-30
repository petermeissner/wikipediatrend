#' Helper function for wp_trend that transforms a time span into a series of months
#'
#' @param from start of timespan
#' @param to end of timespan

wp_expand_ts <- function(from, to, by){
  dates <- seq(as.Date(from), as.Date(to), by)
  return(dates)
}
