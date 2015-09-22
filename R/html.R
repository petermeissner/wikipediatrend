#' function downloading content
#' @param url url to content
html <- function(url, ...){
  httr::content(
    httr::GET(url, ...), 
    type="text/plain", 
    encoding="UTF-8"
  )
}
