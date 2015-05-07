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
    if( any(dim(dat)==0) ) dat <- data.frame()
    if( any(dim(dat)[1]>0&dim(dat)[2]>0) ){
      dat$date   <- wp_date(dat$date)
      dat$count  <- as.numeric(dat$count)
      class(dat) <- c("wp_df","data.frame")
    }else{
      dat <- data.frame()
    }
    
    return(dat)
  }
  # else ...
  dat <- data.frame()  
  class(dat) <- c("wp_df","data.frame")
  return(dat)
}

