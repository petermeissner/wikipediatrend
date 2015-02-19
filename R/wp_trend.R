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
#' @param userAgent Whether or not to send the following information along your
#'   requests: \code{paste( "wikipediatrend running on: ", R.version$platform,
#'   R.version$version.string, sep=", ")}
#'   
#' @examples 
#' wp_trend(page        = "Main_Page", 
#'          from        = "2014-11-01", 
#'          to          = "2014-11-30", 
#'          lang        = "en",
#'          file        = ""
#'          )
#'          
#' @export

wp_trend <- function( page        = "Peter_principle", 
                      from        = Sys.Date()-30, 
                      to          = Sys.Date(),
                      lang        = "en", 
                      file        = ""
){
  # make first letter of page title always capital
  page <- stringr::str_replace( 
            page, 
            "^.", 
            substring(toupper(page),1,1) 
          )
  
  # caching to user defined file or to session-long tempfile
  if(file == ""){
    file = .wp_trend_cache
  }
  
  # check dates
  from <- wp_check_date_inputs(from, to)$from
  to   <- wp_check_date_inputs(from, to)$to
  
  # loading cached data
  cache <- wp_load(file)
  
  # prepare URLs
  urls <- wp_prepare_urls(page=page, 
                          from=from, 
                          to=to, 
                          lang=lang, 
                          cachedata=cache)
  
  # download data 
  jsons <- wp_download_data(urls)
  
  # extract data
  res <- wp_jsons_to_df(jsons)
  
  # combine new data and old data
  res <- wp_join_data(res, cache)
  
  # saving data in cache or file
  wp_save(res, file)

  # return
  res <- res[ res$date <= to & res$date >= from ,]
  rownames(res) <- NULL
  invisible(res)
}




