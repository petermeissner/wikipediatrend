#' function for getting data (download + extraction)
#' 
#' 
#' @param urls urls to be downloaded


wp_get_data <- 
  function(
    page = "R_(programming_language)", 
    from = "2007-12-01", 
    to   = as.character(Sys.Date()), 
    lang = "en",
    user_type = "all",
    platform  = "all"
  ){
  
    res <- list()
    if( from < "2016-01-01" ){
      # TBD
    }
    
    if ( to > "2015-12-31" ) {
      for ( m in seq_along(user_type) ) {
        for ( k in seq_along(platform) ) {
          
          res[[ length(res) + 1 ]] <- 
            pageviews::article_pageviews(
              project   = glue::glue("{lang}.wikipedia"),
              article   = page,
              start     = wp_prepare_date_for_pageviews(date = from, type = "start"),
              end       = wp_prepare_date_for_pageviews(date = to  , type = "end"),
              user_type = user_type[m],
              platform  = platform[k]
            )
          
        }
      }
    }

  return(res)
}


