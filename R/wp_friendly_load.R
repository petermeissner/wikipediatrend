#' Helper function for wp_trend that loads previous saved wp_trend results
#' 
#' @param resname  name of the file from which previous \code{wp_trend()}
#'   results should be loaded (option is passed down from \code{wp_trend()})
#' @param friendly should previous results be ignored or loaded (option is
#'   passed down from \code{wp_trend()})

wp_friendly_load <- function(resname, friendly){
  
  if ( (friendly==1 | friendly==2) & file.exists(resname) ) {
  
    test <- !any(names(read.csv(resname))=="X.date.count")
    
    if ( friendly & test ) {
      dat <- read.csv(resname)[,c("date", "count")]
      dat$date <- wp_date(dat$date)
      return(dat)
    }
    
    if ( friendly & !test ) {
      dat <- read.csv2(resname)[,c("date", "count")]
      dat$date <- wp_date(dat$date)
      return(dat)
    }
  
  }
  
  return(data.frame(date=NULL, count=NULL))
}

