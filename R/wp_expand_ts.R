#' Helper function for wp_trend that transforms a time span into a series of 
#' months
#' 
#' @param from start of timespan
#' @param to end of timespan
#' @param by in which time unit expansion should take place: \code{"day"}, 
#'   \code{"month"}, \code{"year"}
#'   

wp_expand_ts <- function(from, to, by){
  dates <- seq(wp_date(from), wp_date(to), by)
  return(dates)
}
