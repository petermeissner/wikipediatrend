#' function for getting year and month of a timestamp
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd. 
#' 
#' @export 
#' 

wp_yearmonth <- function(timestamp){
  if( is.null(timestamp) ) return(NULL)
  paste0(
    wp_year(wp_date(timestamp)), 
    stringr::str_pad(wp_month(wp_date(timestamp)), 2, "left", 0)
  )
}
