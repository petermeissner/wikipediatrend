#' function downloading prepared URLs 
#'
#' @param urls a vector of urls to be downloaded
#' @param wait the time to wait in seconds before downloading the next chunk (default=1)
#' 

wp_download_data <- function(urls, wait=1){
  # make http requests
  jsons <- list()
  # looping
  for(i in seq_along(urls)){
    jsons <- c(
      jsons, 
      try(
        html( 
            urls[i], 
            httr::user_agent(wp_http_header()$`user-agent`)
            # does not work on linux!? # , handle = h
          ) 
        )
      )
    message(urls[i])
    Sys.sleep(wait)
  }
  # return
  return(jsons)
}
