#' function downloading prepared URLs 
#'
#' @param urls a vector of urls to be downloaded
#' @param size the size of url chunks to be downloaded at once before pausing fo a while (default=5)
#' @param wait the time to wait in seconds before downloading the next chunk (default=1)
#' @export


wp_download_data <- function(urls, size=5, wait=1){
  # chunking urls
  urlchunks <- chunk(urls, size)
  # make http requests
  jsons <- list()
  for(i in seq_along(urlchunks)){
    jsons <- c(
      jsons, 
      RCurl::getURL(url = urlchunks[[i]], httpheader = wp_http_header())
    )
    message(paste(urlchunks[[i]], collapse="\n"))
    Sys.sleep(wait)
  }
  # return
  return(jsons)
}
