#' Helper function for wp_trend
#' 
#' Function writes wp_trend() data to a CSV file that serves as cache/storage
#' 
#' @param res data retreived by \code{wp_trend()}
#' @param file where to save/cache results (defaults to \code{wp_cache_file()})
#'   
#'   
#' @export
#' 

wp_save <- function(res, file=wp_cache_file()){
    #write.csv( x = res, 
    #           file = file, 
    #           row.names = FALSE,
    #           fileEncoding = "UTF-8")
    write_utf8_csv( df = res, file = file)
    #message(paste0("\nResults written to:\n", file ,"\n"))
    return( file )
}
