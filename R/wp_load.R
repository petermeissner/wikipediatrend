#' Helper function for wp_trend that loads previous saved wp_trend results
#' 
#' @param file  name of the file from which previous \code{wp_trend()}
#'   results should be loaded 
#' 
#' @export

wp_load <- function(file=wp_cache_file()){
  if ( file.exists(file) ) {
    dat <- read.csv(file,stringsAsFactors=F)
    dat$date <- wp_date(dat$date)
    return(dat)
  }
  if ( file == wp_cache_file() ){
    dat <- data.frame(date    = NULL, 
                      count   = NULL, 
                      project = NULL, 
                      title   = NULL, 
                      rank    = NULL, 
                      month   = NULL)
    return(dat)
  }
  # else ...
    return(data.frame())
}

