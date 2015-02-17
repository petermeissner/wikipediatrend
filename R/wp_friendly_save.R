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

wp_friendly_save <- function(res, friendly, resname){
  if ( friendly==1 | friendly==2 ) {
    if ( friendly==1 ) write.csv(res, resname, row.names=FALSE)
    if ( friendly==2 ) write.csv2(res, resname, row.names=FALSE)
    message(paste0("\nResults written to:\n", getwd(), "/", resname ,"\n"))
    return( paste0(getwd(),"/",resname) )
  }
  return(FALSE)
}
