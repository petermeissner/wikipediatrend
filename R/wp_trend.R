#' Function for getting access statistics for wikipedia pages
#' 
#'   
#' @param page The name of the Wikipedia page as to be found in the URL to the 
#'   wikipedia article. If e.g. the URL is: 
#'   \code{https://en.wikipedia.org/wiki/Peter_Fox_(musician)}, than the page 
#'   name equals to \code{Peter_Fox_(musician)}.
#'   
#' @param lang The language shorthand identifying which Wikipedia access 
#'   statistics are to be used: e.g. \code{"en"} for the English version found 
#'   at https://en.wikipedia.org, \code{"de"} for the German version found at 
#'   https://de.wikipedia.org or perhaps \code{"als"} for the Alemannic dialect 
#'   found under https://als.wikipedia.org/.
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
#' @param file Where to store data retrieved by function call? The data 
#'   is stored in CSV format. If an already existing file is used for storage, 
#'   the old data will not be deleted but instead new data will be added to this 
#'   file! The cache in memory before the function call will be saved and restored 
#'   afterwards. If you prefer automatic mirroring of in memory cache and cache 
#'   on disk 
#'
#' @param friendly deprecated
#' @param requestFrom deprecated
#' @param userAgent deprecated
#' 
#'
#' @examples 
#' library(wikipediatrend)
#' wp_trend(page        = c("Cheese", "K\u00e4se"),
#'          from        = "2014-11-01", 
#'          to          = "2014-11-30", 
#'          lang        = c("en", "de"),
#'          file        = wp_cache_file()
#'          )
#'
#' 
#' @export

wp_trend <- function( page , 
                      from        = prev_month_start(), 
                      to          = prev_month_end(),
                      lang        = "en", 
                      file        = ""
){
  # dev # 
  # page="main"; from=prev_month_start(); to=prev_month_end(); lang="en"; file=""
  # page="main"; from=prev_month_start(); to=prev_month_end(); lang="en"; file="test.csv"
  # page="pegida"; from=prev_month_start(); to=Sys.Date(); lang="de"; file=""
  # deprecation
  old_cache_file <- wp_cache_file()
                          
  # input check
  stopifnot( length(page)==length(lang) | length(lang)==1 )
  stopifnot( all( !is.na(page) ), all( !is.na(lang) ) )
  
  # check dates
  from <- wp_check_date_inputs(from, to)$from
  to   <- wp_check_date_inputs(from, to)$to
  
  # check page
  page <- stringr::str_replace( page, "^.", substring(toupper(page),1,1) )
  page <- stringr::str_replace( page, " ", "_" )
  for( i in seq_along(page) ){
    if ( !stringr::str_detect( page[i], "%" ) ){
      page[i] <- utils::URLencode(page[i])
    }
  }

  # setting cache-file (if necessary)
  if ( file != wp_cache_file() & file != "" ) {
    wp_set_cache_file(file)
  }
   
  # prepare URLs
  urls <- wp_prepare_urls(page=page, 
                          from=from, 
                          to=to, 
                          lang=lang)

  # download data and extract data
  trash <- wp_get_data(urls)
  
  # save cache to file and load cache for returning results 
  res <- wp_get_cache()
  
  # re-setting cache-file
  wp_set_cache_file(old_cache_file)

  # return
  res <- 
    res[  res$date <= to & 
          res$date >= from &
          paste( res$lang, toupper(res$page))  %in% paste( lang, toupper(page) ) 
          , 
        ]
  rownames(res) <- NULL
  class(res) <- c("wp_df", "data.frame")
  invisible(res)
}




