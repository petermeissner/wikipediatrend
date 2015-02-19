#' Helper function for wp_trend that loads previous saved wp_trend results
#' 
#' @param resname  name of the file from which previous \code{wp_trend()}
#'   results should be loaded (option is passed down from \code{wp_trend()})
#' @param friendly should previous results be ignored or loaded (option is
#'   passed down from \code{wp_trend()})
#' 
#' @export

wp_load <- function(file=.wp_trend_cache){
  if ( file.exists(file) ) {
    dat <- read.csv(file,stringsAsFactors=F)
    dat$date <- wp_date(dat$date)
    return(dat)
  }
  if ( file == .wp_trend_cache ){
    dat <- data.frame(date=NULL, 
                      count=NULL, 
                      project=NULL, 
                      title=NULL, 
                      rank=NULL, 
                      month=NULL)
    return(dat)
  }
  stop("wp_load(): File not found.")
}

