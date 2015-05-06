#' function for joining cache and request data
#' 
#' @param request data downloaded
#' @param cache data loaded from cache file
#' @export 


wp_join_data <- function(request, cache){
  cache_tmp   <- data.frame(cache$date, cache$lang, cache$page)
  cache_ids   <- apply(cache_tmp, 1, paste, collapse=" ")
  request_tmp <- data.frame(request$date, request$lang, request$page)
  request_ids <- apply(request_tmp, 1, paste, collapse=" ")
  res <-  plyr::rbind.fill( 
            cache[ !(cache_ids %in% request_ids) , ], 
            request
          )
  res <- res[order(res$page, res$lang, res$date),]
  row.names(res) <- NULL
  return(res)
}
