
#' a cache for downloads
wp_cache <- new.env()

#' function for building default cache file name
#' 
wp_cache_default <- function(){
  path <- Sys.getenv("WP_CACHE_FILE")
  if ( path == "" ) {
    path <- tempfile("wikipediatrend_cache", fileext = ".csv") 
  }else{
    message(
      paste0(
        "\nNon empty system variable WP_CACHE_FILE found and\n",
        Sys.getenv("WP_CACHE_FILE"),
        "\nused as path to permanent cache.\n"
      )
    )
  }
  return(path)
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
  if ( !file.exists(file) & file!="" ){
    file.create(file)
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

#' function for resetting cache/cachefile as if package was just loaded
#' @export
#'
wp_cache_reset <- function(){
  wp_cache$cache <- NULL 
  file = wp_cache_default()
  wp_set_cache_file( file  )
  wp_cache_load( file )
}

#' function for loading cache on disk into memory
#' @param file where to find previously saved cache
#' @export
wp_cache_load <- function(file=wp_cache_file()){
  tmp <- wp_load(file)
  assign("cache", tmp, envir = wp_cache )
}

#' function to get cache content
#' @export
wp_get_cache <- function(){
  if ( !is.null(wp_cache$cache) ){
    tmp <- wp_cache$cache
  }else{
    tmp <- data.frame()
  }
  class(tmp) <- c("wp_df", "data.frame")
  return(tmp)
}

#' functio to save cache to file
#' @param file where to store in memory cache (e.g. "myData.csv")
#' @export
wp_save_cache <- function(file=wp_cache_file()){
  if ( wp_cache_file() != "" ){
    wp_save( wp_cache$cache, file )
  }
}

#' function adding downloaded data to the cache
#' @param df data frame to be added to cache

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
  if( !is.null(df$count) ) df$count <- as.numeric(df$count)
  wp_cache$cache <- rbind(wp_cache$cache, df[iffer,])
  rownames(wp_cache$cache) <- NULL
  return(sum(iffer))
}
























