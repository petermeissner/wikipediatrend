.onLoad <- function(libname, pkgname){
  assign( ".wp_trend_cache", 
          tempfile("wp_trend_cache_",fileext=".csv"),
          env=globalenv())
}


