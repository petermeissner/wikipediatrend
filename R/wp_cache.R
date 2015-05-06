#' function for determining where downloaded information can be stored
#' @export
#'
wp_cache_file <- function(){
  paste0(dirname(tempdir()), "/", "wikipediatrend_cache.csv")
}

#' function for resetting cache
#' @export
#'
wp_cache_reset <- function(){
  file.remove(wp_cache_file())
  file.create(wp_cache_file())
  wp_cache_load()
}

#' function for loading data in cache
#' @export
#'
wp_cache_load <- function(){
  tmp <- wp_load(wp_cache_file())
  class(tmp) <- c("wp_df","data.frame")
  assign("cache", tmp, envir = cache )
}

#' function to get cache content
#' @export
wp_get_cache <- function(){
  return(cache$cache)
}

#' functio to save cache to file
#' @export
#' 
wp_save_cache <- function(file=wp_cache_file()){
  wp_save(cache$cache, file)
}

#' function adding downloaded data to the cache
#' @export
wp_add_to_cache <- function(df){
  if( dim(cache$cache)[1] > 0 & dim(df)[1] > 0 ){
    df_ids    <- tolower(apply(df[,c("lang", "page", "date")], 1, paste, collapse=" "))
    cache_ids <- tolower(apply(cache$cache[,c("lang", "page", "date")], 1, paste, collapse=" "))
    iffer <- !( df_ids %in% cache_ids )
  }else{
    iffer <- T  
  }
  cache$cache <- rbind(cache$cache, df[iffer,])
  rownames(cache$cache) <- NULL
  return(sum(iffer))
}

#' a cache for downloads
#' @export
cache <- new.env()






















