#' Title
#'
#' @inheritParams wp_get_data
#' @export
#'
wpd_get_exact <- 
  function(page, lang, from, to){
    url <- 
      glue::glue("http://petermeissner.de:8880/article/exact/{lang}/{page}")
    
    http_request <- httr::GET(url)
    cont         <- httr::content(http_request, type = "application/json")
    
    
    res <- do.call(rbind, lapply(cont$data, wpd_decompress, lang = lang))
    
    res <- res[order(res$date), c("lang", "page_name", "date", "page_views")]
    names(res) <- c("language", "article", "date", "views")
    
    res <- res[res$date >= from & res$date <= to, ]
    res$views <- as.integer(res$views)
      
    # return
    res
  }
