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
#' @param file Where to cache/store the retrieved data? By default a temporary file is used for as long as the R session takes place. The data is stored in CSV format. If an already existing file is used for storage, the old data will not be deleted but instead new data will be added to this file. 
#'   
#' @examples 
#' library(wikipediatrend)
# wp_trend(page        = "Main_Page", 
#          from        = "2014-11-01", 
#          to          = "2014-11-30", 
#          lang        = "en",
#          file        = wp_cache_file()
#          )
#'          
#' @export

wp_trend <- function( page , 
                      from        = Sys.Date()-30, 
                      to          = Sys.Date(),
                      lang        = "en", 
                      file        = wp_cache_file(), 
                      friendly,
                      requestFrom,
                      userAgent
){
  # dev # 
  # page="main"; from=Sys.Date()-30; to=Sys.Date(); lang="en"; file=wp_cache_file()
  
  # deprecation
  if( !missing("requestFrom") ) 
    message("Option 'requestFrom' is deprecated and will cause errors 
            in futuere versions of the wp_trend() function. Please read 
            the package vignette and/or README to learn about the new
            set of options.
            
            Check wp_http_header() to know which information are send to 
            stats.grok.se (R and package versions)
            ")
  if( !missing("friendly") ) 
    message("Option 'friendly' is deprecated and will cause errors 
            in futuere versions of the wp_trend() function. Please read 
            the package vignette and/or README to learn about the new
            set of options.
            
            The package now is friendly by default.
            ")
  if( !missing("userAgent") ) 
    message("Option 'userAgent' is deprecated and will cause errors 
            in futuere versions of the wp_trend() function. Please read 
            the package vignette and/or README to learn about the new
            set of options.
            
            Check wp_http_header() to know which information are send to 
            stats.grok.se (R and package versions)
            ")
  
  # input check
  stopifnot( grepl("\\w",page) )
  stopifnot( length(page)==length(lang) | length(lang)==1 )
  
  # check dates
  from <- wp_check_date_inputs(from, to)$from
  to   <- wp_check_date_inputs(from, to)$to
  
  # make first letter of page title always capital
  page <- stringr::str_replace( 
            page, 
            "^.", 
            substring(toupper(page),1,1) 
          )
  
  
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
  res <- res[ res$date <= to & 
              res$date >= from &
              paste(  res$lang, 
                      toupper(unlist(lapply(res$page, URLencode))) 
                    ) %in% 
              paste(  lang, 
                      toupper(page)
                    ), 
            ]
  rownames(res) <- NULL
  #dev# class(res) <- c("wp_df", "data.frame")
  return(res)
}




