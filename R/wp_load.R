#' Helper function for wp_trend that loads previous saved wp_trend results
#' 
#' @param file  name of the file from which previous \code{wp_trend()}
#'   results should be loaded 
#' 
#' @export

wp_load <- function(file=wp_cache_file()){
  if ( file.exists(file) ) {
#    dat <- read.csv( file = file,
#                     stringsAsFactors = F, 
#                     fileEncoding = "UTF-8")
    dat      <- read_utf8_csv(file)
    if(dim(dat)[1] > 0)  dat$date <- wp_date(dat$date)
    return(dat)
  }
  # else ...
    return(data.frame())
}

