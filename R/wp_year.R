#' Function to extract the year 
#' 
#' Function to extract the year from a timestamp of e.g. class POSIXlt, POSIXct, Date, or character. If the option is of type character it should be in the form of yyyy-mm-dd.
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd.
#' 

wp_year          <- function(timestamp) UseMethod("wp_year")

#' @describeIn wp_year extract
wp_year.POSIXlt  <- function(timestamp) {
  timestamp$year+1900
}

#' @describeIn wp_year extract
wp_year.default  <- function(timestamp) {
  as.POSIXlt(wp_date(timestamp))$year+1900
}
