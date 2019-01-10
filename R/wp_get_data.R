#' function for getting data (download + extraction)
#' 
#' 
#' @inheritParams wp_trend
#' @inheritParams pageviews::article_pageviews
#' 
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
      res[[ length(res) + 1 ]] <- 
        wpd_get_exact(page = page, lang = lang, from = from, to = to)
    }
    
    if ( to > "2015-12-31" ) {
      for ( m in seq_along(user_type) ) {
        for ( k in seq_along(platform) ) {
          
          tmp_res <- 
            pageviews::article_pageviews(
              project   = glue::glue("{lang}.wikipedia"),
              article   = page,
              start     = wp_prepare_date_for_pageviews(date = from, type = "start"),
              end       = wp_prepare_date_for_pageviews(date = to  , type = "end"),
              user_type = user_type[m],
              platform  = platform[k]
            )
          
          tmp_res <- tmp_res[, c("language", "article", "date", "views")] 
          
          res[[ length(res) + 1 ]] <- tmp_res
        }
      }
    }

  res <- do.call(rbind, res)
  res$article <- tolower(res$article)
    
  return(res)
}


