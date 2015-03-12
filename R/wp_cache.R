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
}

#' function for loading data in cache
#' @export
#'
wp_cache_load <- function(){
  wp_load(wp_cache_file())
}
