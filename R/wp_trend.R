#' Function for getting access statistics for wikipedia pages
#' 
#' @param requestFrom This parameter sends an identifier (i.e. your email 
#'   address to contact you if necessary) to stats.grok.se (the server that 
#'   kindly provides the information you request).
#'   
#' @param page The name of the Wikipedia page as to be found in the URL to the
#'   wikipedia article. If e.g. the URL is:
#'   \code{https://en.wikipedia.org/wiki/Peter_Fox_(musician)}, than the page
#'   name equals to \code{Peter_Fox_(musician)}.
#'   
#' @param lang The language shorthand identifying which Wikipedia access
#'   statistics are to be used: e.g. \code{"en"} for the English version found
#'   at http://en.wikipedia.org, \code{"de"} for the German version found at
#'   http://de.wikipedia.org or perhaps \code{"als"} for the Alemannic dialect
#'   found under http://als.wikipedia.org/.
#'   
#' @param from The starting date of the timespan for which access statistics
#'   should be retrieved - note that there is no data prior to 2007-12-01.
#'   Supply some sort of timestamp e.g. of class POSIXlt, POSIXct, Date, or
#'   character. If the option is of type character it should be in the form of
#'   yyyy-mm-dd.
#'   
#' @param to The last date for which access statistics should be retrieved.
#'   Supply some sort of timestamp e.g. of class POSIXlt, POSIXct, Date, or
#'   character. If the option is of type character it should be in the form of
#'   yyyy-mm-dd.
#'   
#' @param friendly Either \code{TRUE}, \code{FALSE}, \code{1} or \code{2} This
#'   option causes twofold. First, if the value is set to TRUE, 1, or 2 the
#'   results of the request are saved in the current working directory in a CSV
#'   file with name scheme: \code{wp__[page name]_[country code].csv}. Second,
#'   the function will look if perhaps a previously saved result is available to
#'   be used to only download those information that are still missing instead
#'   of the whole timespan.
#'   
#'   For storage on disk \code{write.csv()} (friendly=TRUE or friendly=1) and
#'   \code{write.csv2()} (friendly=2) are used.
#'   

wp_trend <- function( page        = "Peter_principle", 
                      from        = Sys.Date()-30, 
                      to          = Sys.Date(),
                      lang        = "en", 
                      friendly    = F,
                      requestFrom = "anonymous"
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
  resname <- paste0("wp", "__", page, "__", lang, ".csv")
  
  # check dates
  tmp  <- wp_check_date_inputs(from, to)
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
                  lang, dates_url, page, sep="/")
  if(all(dates_url=="")) urls  <- NULL
  
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
  res <- wp_extract_data(jsons)
  
  # combine new data and old data
  not_in_res <- !(friendly_data$date %in% res$date)
  res <- rbind(res, friendly_data[not_in_res,])
  res <- res[order(res$date), ]
  
  # beeing friendly: saving results to file for possible later use
  wp_friendly_save(res, friendly, resname)

  # return
  res <- res[ res$date <= to & res$date >= from ,]
  return(res)
}




