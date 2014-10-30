#' function for getting year and month of a timestamp
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date, or character. If the option is of type character it should be in the form of yyyy-mm-dd.

wp_yearmonth <- function(timestamp){
  paste0(
    wp_year(timestamp), 
    stringr::str_pad(wp_month(timestamp), 2, "left", 0)
  )
}
