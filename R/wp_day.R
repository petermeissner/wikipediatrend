#' Function to extract the day
#' 
#' Function to extract the day from a timestamp of e.g. class POSIXlt, POSIXct, Date, or character. If the option is of type character it should be in the form of yyyy-mm-dd.
#' 
#' @param timestamp a timestamp
#' 
#' 


wp_day          <- function(timeStamp) UseMethod("wp_day")

#' @describeIn wp_day extract
wp_day.POSIXlt  <- function(timeStamp) {
  timeStamp$mday+1
}

#' @describeIn wp_day extract
wp_day.default  <- function(timeStamp) {
  as.POSIXlt(timeStamp)$mday+1
}
