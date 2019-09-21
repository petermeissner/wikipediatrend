#' function for getting data (download + extraction)
#' 
#' 
#' @inheritParams wp_trend
#' @inheritParams pageviews::article_pageviews
#' 
wp_get_data <- 
  function(
    page      = "R_(programming_language)", 
    from      = "2007-12-01", 
    to        = as.character(Sys.Date()), 
    lang      = "en",
    user_type = "all",
    platform  = "all",
    warn      = TRUE
  ){
    
    # initialize data storage
    res <- list()
    
    # go to API for old data
    if( from < "2016-01-01" ){
      res[[ length(res) + 1 ]] <- 
        wpd_get_exact(page = page, lang = lang, from = from, to = to, warn = warn)
    }
   # browser()
    # go to wikipedias' own pageviews API
    if ( to > "2015-12-31" ) {
      for ( m in seq_along(user_type) ) {
        for ( k in seq_along(platform) ) {
          
          tryCatch(
            {
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
            },
            error = 
              function(e){
                res[[ length(res) + 1 ]] <- 
                  data.frame(
                    language = character(),
                    article  = character(), 
                    date     = integer(),
                    views    = integer()
                  )
                
                if ( warn == TRUE ){
                  warning(
                    "Unable to retrieve data via {pageviews}.\n", 
                    glue::glue(" Error: {e$message}.\n"), 
                    glue::glue(" Params: project = '{lang}', article='{page}', start='{wp_prepare_date_for_pageviews(date = from, type = \"start\")}', end='{wp_prepare_date_for_pageviews(date = to  , type = \"end\")}', user_type='{user_type[m]}', platform='{platform[k]}'."),
                    immediate. = TRUE
                  ) 
                }
              }
          )
        }
      }
    }
    
    # combine data.frames
    res         <- do.call(rbind, res)
    res$article <- tolower(res$article)
    
    # return
    return(res)
  }


