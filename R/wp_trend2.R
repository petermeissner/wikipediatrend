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
#' 
#' @examples 
#' 
#' res <- wp_trend(page=c("Der_Spiegel", "Die_Zeit"), lang=c("de", "en"))
#' 
#' 
#' @export

wp_trend <- 
  function( 
    page , 
    from        = Sys.Date()-30, 
    to          = Sys.Date(),
    lang        = "en"
  ){
    
    # input check
    stopifnot( length(page)==length(lang) | length(lang)==1 )
    stopifnot( all( !is.na(page) ), all( !is.na(lang) ) )
    
    # check dates
    from <- wp_check_date_inputs(from, to)$from
    to   <- wp_check_date_inputs(from, to)$to
    
    # check page
    page <- wp_check_page_input(page)
    
    
    # download data and extract data
    data_list <- wp_get_data(page = page, from = from, to = to, lang = lang)
    
    
    # combine data
    res <- do.call(rbind, data_list)
    
    # return
    if( any(dim(res)) > 0 ){
      res <- 
        res[order(res$date, res$language, res$article),]
    }
    
    
    class(res) <- c("wp_df", class(res))
    return(res)
  }




