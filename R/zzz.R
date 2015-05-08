.onLoad <- function(libname, pkgname){
  wp_cache_file()
  wp_cache_load()
}
