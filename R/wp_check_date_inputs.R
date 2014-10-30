#' Helper function for \code{wp_trend()}
#' 
#' Function checks time span given by fromDate and toData if complying with
#' logical constraints: from not prior to first available data; to not past
#' today
#' 
#' @param from first date of timespan to check
#' @param to second date of timespan to check
#' 
wp_check_date_inputs <- function(from, to){
  from <- as.character(from)
  to <- as.character(to)
  if ( as.Date(from) < as.Date("2007-12-01")  ) { 
  from <- as.Date("2007-12-01")
  } 
  if ( as.Date(to) > Sys.Date()  ) { 
    to <- Sys.Date()
  } 
  return( list(from=from, to=to) )
}
