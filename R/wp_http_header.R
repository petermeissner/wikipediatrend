#' function for pasting together the HTTP user-agent field 
#' 
#' @export


wp_http_header <- function(){
  list( 
    'user-agent' = 
      paste0( 
        R.version$version.string, " ",
        "wikipediatrend/", utils::packageVersion("wikipediatrend"), " ",
        "curl/", RCurl::curlVersion()$version, " ",
        "Rcurl/", utils::packageVersion("RCurl"), " ",
        "httr/", utils::packageVersion("httr")
      ) 
  )
}
