#' Function to extract the month
#' 
#' Function to extract the month from a timestamp of e.g. class POSIXlt,
#' POSIXct, Date, or character. If the option is of type character it should be
#' in the form of yyyy-mm-dd.
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd.
#'    
#' 
#' @export 
#' 

wp_month          <- function(timestamp) UseMethod("wp_month")


#' @describeIn wp_month extract
#'  @export 
#'  

wp_month.POSIXlt  <- function(timestamp) {
  timestamp$mon+1
}


#' @describeIn wp_month extract
#'  @export 
#'  

wp_month.default  <- function(timestamp) {
  if( is.null(timestamp) ) return(NULL)
  as.POSIXlt(wp_date(timestamp))$mon+1
}
