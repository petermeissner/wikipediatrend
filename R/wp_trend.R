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
#' @param friendly Either \code{TRUE}, \code{FALSE}, \code{1} or \code{2} 
#' This option causes twofold. First, the results of the request are saved in the current working directory in a CSV file with name scheme: \code{wp__[page name]_[country code].csv}. 
#' Second, the function will look if perhaps a previously saved result is available to be used to only download those information that are still missing instead of the whole timespan. 
#' 
#' For storage on disk write.csv() and write.csv2() are used
#'   

wp_trend <- function( requestFrom = "anonymous",
                      pageName    = "Peter_principle", 
                      countryCode = "en", 
                      fromDate    = Sys.Date()-30, 
                      toDate      = Sys.Date(),
                      friendly    = F
){
  # encourage being freindly
  if ( !friendly ) {
    message("
    With option 'friendly' set to FALSE subsequent requests 
    of the same wikipedia-page cause the server -- which is kindly 
    providing information for you -- to work hard to get the same 
    stuff over and over and over and over again. Do not bore 
    the server - be friendly. 
    
    More information is found via '?wp_trend'.
    ")
  }
  
  
  # http header
  standardHeader <- list( from         = requestFrom,
                          'user-agent' = paste( "wikipediatrend running on: ", 
                                                R.version$platform,
                                                R.version$version.string,
                                                sep=", "))
  
  # file name for beeing friendly
  resname <- paste0("wp", "__", pageName, "__", countryCode, ".csv")
  
  # check dates
  tmp  <- wp_check_date_inputs(fromDate, toDate)
  from <- tmp$from
  to   <- tmp$to
  
  # beeing friendly
  friendly_data <- wp_friendly_load(resname, friendly)
  
  # checking for months with missing data
  dates_day <- wp_expand_ts(from, to, "day")
  not_in_fd <- !(dates_day %in% friendly_data$date)
  dates_url <- unique(wp_yearmonth(dates_day[ not_in_fd ]))
  
  # prepare urls
  urls  <- paste( "http://stats.grok.se/json",
                  countryCode, dates_url, pageName, sep="/")
  
  # chunking urls
  urlchunks <- chunk(urls, 5)
  
  # make http requests
  jsons <- list()
  for(i in seq_along(urlchunks)){
    jsons <- c(
      jsons, 
      RCurl::getURL(url = urlchunks[[i]], httpheader = standardHeader)
     )
    message(paste(urlchunks[[i]], collapse="\n"))
    Sys.sleep(1)
  }
  
  # extract data
  res <- extract_access_counts(jsons)
  
  # combine new data and old data
  not_in_res <- !(friendly_data$date %in% res$date)
  res <- rbind(res, friendly[not_in_res])
  res <- res[order(res$date), ]
  
  # beeing friendly: saving results to file for possible later use
  wp_friendly_save(res, friendly, resname)

  # return
  res <- res[ res$date <= to & res$date >= from ,]
  return(res)
}




