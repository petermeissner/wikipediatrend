#' function downloading content
#' @param url url to content
#' @param ... further arguments passed trough to httr::GET()
html <- function(url, ...){
  pcks <- installed.packages()
  if( pcks[rownames(pcks)=="rvest", colnames(pcks)=="Version"] > "0.2.0" ){
    httr::content(
      httr::GET(url, ...), 
      type="text/plain", 
      encoding="UTF-8"
    )  
  }else{
    rvest::html_text(rvest::html(url, ...))
  }
}

#' function downloading content
#' @param url url to content
#' @param ... further arguments passed trough to httr::GET()
html2 <- function(url, ...){
  pcks <- installed.packages()
  if( pcks[rownames(pcks)=="rvest", colnames(pcks)=="Version"] > "0.2.0" ){
    xml2::read_html(url, ...)
  }else{
    rvest::html(url, ...)
  }
}
