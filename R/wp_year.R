#' Function to extract the year 
#' 
#' Function to extract the year from a timestamp of e.g. class POSIXlt, POSIXct, Date, or character. If the option is of type character it should be in the form of yyyy-mm-dd.
#' 
#' @param timestamp a timestamp
#' 

wp_year          <- function(timeStamp) UseMethod("wp_year")

#' @describeIn wp_year extract
wp_year.POSIXlt  <- function(timeStamp) {
  timeStamp$year+1900
}

#' @describeIn wp_year extract
wp_year.default  <- function(timeStamp) {
  as.POSIXlt(timeStamp)$year+1900
}
