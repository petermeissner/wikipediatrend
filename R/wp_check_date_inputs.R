#' Helper function for \code{wp_trend()}
#' 
#' Function that checks if the time span given by from and to (passed down from
#' wp_trend) are complying with logical constraints: from not prior to first
#' available data; to not past today; to not prior to from
#' 
#' @param from first date of timespan to check
#' @param to second date of timespan to check
#'
#' 

wp_check_date_inputs <- function(from, to){
  from <- as.character(from) 
  to   <- as.character(to)
  # from larger than to
  if ( !(wp_date(from) <= wp_date(to)) ) {
    stop("In wp_check_date_inputs: from-date larger than to-date.")
  }
    # to small a value (no data before 2007)
  if ( wp_date(from) < wp_date("2007-12-01")  ) { 
    from <- wp_date("2007-12-01")
  } 
  if ( wp_date(to) < wp_date("2007-12-01")  ) { 
    to <- wp_date("2007-12-01")
  } 
  # to large a value (data beyond today)
  if ( wp_date(to) > Sys.Date()  ) { 
    to <- Sys.Date()
  } 
  if ( wp_date(from) > Sys.Date()  ) { 
    from <- Sys.Date()
  } 
  return( list(from=from, to=to) )
}
