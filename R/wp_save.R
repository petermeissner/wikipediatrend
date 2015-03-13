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
    write.csv(res, file, row.names=FALSE)
    message(paste0("\nResults written to:\n", file ,"\n"))
    return( file )
}
