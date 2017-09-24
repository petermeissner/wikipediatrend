#' function to prepare date for execution of pageviews request
#' 
#' @param date date as character string
#' @param type "from" or "to"
#'
#' @keywords internal
wp_prepare_date_for_pageviews <- function(date, type){
  if( type == "from" ){
    if( date < "2016-01-01"){
      date <- "2016-01-01"
    }
  }
  
  paste0(stringr::str_replace_all(date, "-", ""), "00")
}
