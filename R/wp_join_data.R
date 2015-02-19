#' function for joining cache and request data
#' 
#' @param request data downloaded
#' @param cache data loaded from cache file
#' @export 


wp_join_data <- function(request, cache){
  cache_tmp   <- data.frame(cache$date, cache$project, cache$title)
  cache_ids   <- apply(cache_tmp, 1, paste, collapse=" ")
  request_tmp <- data.frame(request$date, request$project, request$title)
  request_ids <- apply(request_tmp, 1, paste, collapse=" ")
  res <-  rbind( 
            cache[ !(cache_ids %in% request_ids) , ], 
            request
          )
  res <- res[order(res$title, res$project, res$date),]
  return(res)
}
