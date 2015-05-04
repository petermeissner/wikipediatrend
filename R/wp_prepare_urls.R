#' function preparing URLs for downlaod
#' 
#' @param page page title supplied by wp_trend()
#' @param from from supplied by wp_trend()
#' @param to to supplied by wp_trend()
#' @param lang lang supplied by wp_trend()
#' @param cachedata cache data found in file supplied by file option in wp_trend()
#' 
#' @export

wp_prepare_urls <- function(page, from, to, lang, cachedata=NULL){
  # expand from-date and to-date to sequence of days
  timeframe <- wp_expand_ts(from, to, "day")
  
  # comparing data in cache with data requested
  cache_dpoints   <-  unique(
                        paste(cachedata$date, 
                              cachedata$lang, 
                              cachedata$page)
                      )
  request_comb <- 
    cbind(
      expand.grid(timeframe, lang, stringsAsFactors=F),
      expand.grid(timeframe, page, stringsAsFactors=F)[,2],
      stringsAsFactors=F
    )
  names(request_comb) <- c("date", "lang", "page")
  request_dpoints <- apply(request_comb, 1, paste, collapse=" ")
  
  request_tbd     <- !(request_dpoints %in% cache_dpoints)
  
  # prepare urls for download
  urls <- 
    apply(
      cbind( 
        request_comb$lang, 
        wp_yearmonth(request_comb$date), 
        request_comb$page
      ),
      1, paste, collapse="/"
    )
  urls <- urls[request_tbd]
  
  # check if there is something to download at all
  if( length(urls) > 0 ){
    urls <- unique(paste0("http://stats.grok.se/json/", urls)) 
  }else{
    urls <- NULL
  }
  # return
  return(urls)
}


