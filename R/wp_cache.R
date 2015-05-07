#' function for determining where downloaded information can be stored
#' @export
#'
wp_cache_file <- function(){
  if(is.null(cache$cachefile)){
    file <- paste0("~", "/", "wikipediatrend_cache.csv")
  }else{
    file <- cache$cachefile
  }
  if ( !file.exists(file) ) file.create(file)
  return(file)
}

#' function to set a different cachefile as session default
#' @export
#' @param file name of the file to be used as cache
wp_set_cache_file <- function(file) cache$cachefile <- file

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
  assign("cache", tmp, envir = cache )
  }

#' function to get cache content
#' @export
wp_get_cache <- function(){
  tmp <- cache$cache
  class(tmp) <- c("wp_df", "data.frame")
  return(tmp)
}

#' functio to save cache to file
#' @export
#' @param file to which file the cache should be saved (wp_cache_file by
#'   default)
#'   
wp_save_cache <- function(file=wp_cache_file()){
  wp_save(cache$cache, file)
}

#' function adding downloaded data to the cache
#' @param df data frame to be aded to cache
#' #@export
wp_add_to_cache <- function(df){
  if( is.null(cache$cache) ){
    iffer <- T
  }else{
    if( dim(cache$cache)[1] > 0 & dim(df)[1] > 0 ){
      df_ids    <- tolower(apply(df[,c("lang", "page", "date")], 1, paste, collapse=" "))
      cache_ids <- tolower(apply(cache$cache[,c("lang", "page", "date")], 1, paste, collapse=" "))
      iffer <- !( df_ids %in% cache_ids )
    }else{
      iffer <- T  
    }
  }
  df$count <- as.numeric(df$count)
  cache$cache <- rbind(cache$cache, df[iffer,])
  rownames(cache$cache) <- NULL
  return(sum(iffer))
}

#' a cache for downloads
#' #@export
cache <- new.env()






















