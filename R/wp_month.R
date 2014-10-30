#' Function to extract the month 
#' 
#' Function to extract the month from a timestamp of e.g. class POSIXlt, POSIXct, Date, or character. If the option is of type character it should be in the form of yyyy-mm-dd.
#' 
#' @param timestamp a timestamp
#' 

wp_month          <- function(timeStamp) UseMethod("wp_month")

#' @describeIn wp_month extract
wp_month.POSIXlt  <- function(timeStamp) {
  timeStamp$mon+1
}

#' @describeIn wp_month extract
wp_month.default  <- function(timeStamp) {
  as.POSIXlt(timeStamp)$mon+1
}
