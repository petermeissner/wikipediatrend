#' Helper function for wp_trend
#' 
#' Function writes wp_trend data to a CSV file that can be used for subsequent
#' requests
#' 
#' @param res      internal data retreived by \code{wp_trend()}
#' @param friendly should retrieved data be saved for later use (option is
#'   passed down from \code{wp_trend()})
#' @param resname  the name serving to save the data (option is passed down from
#'   \code{wp_trend()})
#'    
#' 
#' @export 
#' 

wp_save <- function(res, file){
    write.csv(res, file, row.names=FALSE)
    message(paste0("\nResults written to:\n", file ,"\n"))
    return( file )
}
