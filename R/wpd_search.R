#' wpd_search
#'
#' @param page_fragment substring to search for within titles
#' @param lang language to search
#'
#' @export
#'
wpd_search <- 
  function(page_fragment = "R_(programming_language)", lang="en"){
    page_fragment <- tolower(page_fragment)

    url <- 
      glue::glue("http://petermeissner.de:8880/search/{lang}/{page_fragment}")
    
    req <- httr::GET(url)
    
    res_list <- httr::content(req, type = "application/json")$data
    data.frame(
      lang = 
        vapply(res_list, `[[`, FUN.VALUE = character(1), "page_lang"),
      page_id = 
        vapply(res_list, `[[`, FUN.VALUE = integer(1), "page_id"),
      page = vapply(res_list, `[[`, FUN.VALUE = character(1), "page_name")
    )
  }
