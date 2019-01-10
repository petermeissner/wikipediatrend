
#' wiki_search
#'
#' @param page_fragment substring to search for
#' @param lang wikipedia language to search in 
#'
#' @export
#'
wiki_search <- 
  function(page_fragment = "R_(programming_language)", lang="en"){
    url <- 
      glue::glue("https://{lang}.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch={page_fragment}&srlimit=500")
    
    # https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=Angela%20Merkel&prop=info|description
    
    req <- httr::GET(url)
    
    res_list <- httr::content(req, type = "application/json")
    
    res_df <- 
      data.frame(
        ns = 
          vapply(res_list$query$search, `[[`, integer(1), "ns"), 
        title = 
          vapply(res_list$query$search, `[[`, character(1), "title"), 
        pageid =
          vapply(res_list$query$search, `[[`, integer(1), "pageid"), 
        size = 
          vapply(res_list$query$search, `[[`, integer(1), "size"), 
        wordcount = 
          vapply(res_list$query$search, `[[`, integer(1), "wordcount"),
        timestamp = 
          as.POSIXct(
            vapply(res_list$query$search, `[[`, character(1), "timestamp"),
            tz = "UTC",
            format = "%Y-%m-%dT%H:%M:%SZ"
          ),
        snippet = 
          vapply(res_list$query$search, `[[`, character(1), "snippet")
      )

    res_df
  }
