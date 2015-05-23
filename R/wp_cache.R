#' function for building default cache file name
#' 
wp_cache_default <- function(){
  paste0(
    dirname(tempdir()),
    "/wikipediatrend_cache.csv"
  )
}

#' function for determining where downloaded information can be stored
#' @export
#'
wp_cache_file <- function(){
  if( is.null(wp_cache$cachefile) ){
    file <- wp_cache_default()
    wp_cache$cachefile <- file
  }else{
    file <- wp_cache$cachefile
  }
  if ( !file.exists(file) ){
    file.create(file)
    wp_cache$cachefile <- file
  }
  return(file)
}

#' function to set a different cachefile as session default
#' @export
#' @param file name of the file to be used as cache
wp_set_cache_file <- function(file){
  wp_save_cache()
  wp_cache$cachefile <- file
  wp_cache_load()
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
#'
wp_cache_load <- function(){
  tmp <- wp_load(wp_cache_file())
  assign("cache", tmp, envir = wp_cache )
  }

#' function to get cache content
#' @export
wp_get_cache <- function(){
  tmp <- wp_cache$cache
  class(tmp) <- c("wp_df", "data.frame")
  return(tmp)
}

#' functio to save cache to file
#'   
wp_save_cache <- function(){
  wp_save(wp_cache$cache, wp_cache_file())
}

#' function adding downloaded data to the cache
#' @param df data frame to be aded to cache

wp_add_to_cache <- function(df){
  if( is.null(wp_cache$cache) ){
    iffer <- T
  }else{
    if( dim(wp_cache$cache)[1] > 0 & dim(df)[1] > 0 ){
      df_ids    <- tolower(apply(df[,c("lang", "page", "date")], 1, paste, collapse=" "))
      cache_ids <- tolower(apply(wp_cache$cache[,c("lang", "page", "date")], 1, paste, collapse=" "))
      iffer <- !( df_ids %in% cache_ids )
    }else{
      iffer <- T  
    }
  }
  df$count <- as.numeric(df$count)
  wp_cache$cache <- rbind(wp_cache$cache, df[iffer,])
  rownames(wp_cache$cache) <- NULL
  return(sum(iffer))
}

#' a cache for downloads


wp_cache <- new.env()






















