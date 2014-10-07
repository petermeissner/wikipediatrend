#' Function for getting access statistics for wikipedia pages
#' 
#' @param requestFrom This parameter sends an identifier (i.e. your email
#'   address to contact you if necessary) to stats.grok.se (the server that
#'   kindly provides the information you request).
#'   
#' @param pageName The name of the Wikipedia page as to be found in the URL to the wikipedia article. If e.g. the URL is: \code{https://en.wikipedia.org/wiki/Peter_Fox_(musician)}, than the page name equals to \code{Peter_Fox_(musician)}.
#'   
#' @param countryCode The country code of
#'
#' @param fromDate blsa
#'   
#' @param toDate blsa
#'   
#' @param friendly blsa
#'   

wp_trend <- function( requestFrom = "retep.meissner@gmail.com",
                      pageName    = "Peter_Principle", 
                      countryCode = "en", 
                      fromDate    = Sys.Date()-30, 
                      toDate      = Sys.Date(),
                      friendly    = T
){
  # http header
  standardHeader <- list( from         = requestFrom,
                          'user-agent' = paste( "wikipediaTrend running on: ", 
                                                R.version$platform,
                                                R.version$version.string,
                                                sep=", "))
  
  # expand dates 
  if ( as.Date(fromDate) < as.Date("2007-12-01")  ) { 
    fromDate <- as.Date("2007-12-01")
  } 
  dates    <- seq(as.Date(fromDate), as.Date(toDate), "month")
  dates    <- paste0(substring(dates, 1, 4), substring(dates, 6, 7))
  
  # prepare urls
  urls  <- paste( "http://stats.grok.se/json",
                  countryCode, dates, pageName, sep="/")
  
  # beeing friendly: using already downloaded data (except for current month)
  resname <- paste0("wikipediaTrend", "__", pageName, ".csv")
  if ( (friendly==1 | friendly==2) & file.exists(resname) ) {
    if ( friendly==1 ) {
      restmp <- read.csv(resname)[,c("date", "count")]
      restmp$date <- as.Date(restmp$date)
    }
    if ( friendly==2 ) {
      restmp <- read.csv2(resname)[,c("date", "count")]
      restmp$date <- as.Date(restmp$date)
    }
    restmp_dates <- substring(
        stringr::str_replace(as.character(restmp$date), "-", ""),
        1,6)
    iffer <- !(dates %in% restmp_dates)
    if ( toDate==Sys.Date() ) { 
      iffer2 <- dates == substring(
        stringr::str_replace(as.character(Sys.Date()), "-", ""), 
        1, 6)
      iffer  <- iffer | iffer2 
    } 
    dates <- dates[iffer]
    urls  <- urls[iffer]
  }
  
  # chunking urls
  urlchunks <- chunk(urls, 5)
  
  # make http requests
  jsons <- list()
  for(i in seq_along(urlchunks)){
    jsons   <- c(jsons, RCurl::getURL(url = urlchunks[[i]], httpheader = standardHeader))
    message(paste(urlchunks[[i]], collapse="\n"))
    Sys.sleep(1)
  }
  
  # produce data set
  res <- extract_access_counts(jsons)
  
  # beeing friendly: saving results to file for possible later use
  if ( friendly==1 | friendly==2 ) {
    resname <- paste0("wikipediaTrend", "__", pageName, ".csv")
    if( exists("restmp") ){
      res <-  rbind(
        restmp, 
        res[!(as.character(res$date) %in% as.character(restmp$date)),]
      )
    }
    if ( friendly==1 ) write.csv(res, resname)
    if ( friendly==2 ) write.csv2(res, resname)
    message(paste0("\nResults written to:\n", getwd(), "/", resname ,"\n"))
  }
  if ( friendly==0 ) {
    message("\nPlease think about beeing server friendly by turning on the friendly option.")
  }
  # return
  res <- res[ res$date <= toDate & res$date >= fromDate ,]
  res <- res[order(res$date), ]
  return(res)
}




