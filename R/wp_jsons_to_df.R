#' Helper function for wp_trend
#' 
#' The function does accepts a list of JSON snippets and transforms the
#' information into a data frame
#' 
#' @param wp_json The results from server request in JSON format
#' @param page the name of the downloaded page
#' #@export 

wp_jsons_to_df <- function(wp_json, page){
  # function doing the extraction work
  worker <- function(wp_json, page){
    tmp <- 
      tryCatch(
        {
          jsonlite::fromJSON(wp_json)
        }, 
          error=function(e){
            warning("[wp_jsons_to_df()]\nCould not extract data from server response. Data for one month will be missing.")
            data.frame()
          }
      )
    # no data? OR some data?
    if( length(tmp$daily_views)==0 ){
      return( data.frame() )
    }else{
      tmp_data <- data.frame( date    = wp_date( names(tmp$daily_views) ), 
                              count   = unlist(tmp$daily_views),
                              lang    = tmp$project,
                              page    = page,
                              rank    = tmp$rank,
                              month   = tmp$month,
                              title   = tmp$title,
                              stringsAsFactors=F)
      return(tmp_data)
    }
  }
  # case of no data
  if( length(wp_json)==0 ){
    res <- data.frame()
    return(unique(res))
  }
  # case of only one json
  if( length(wp_json)==1 & is.character(wp_json[[1]])){
    res <- worker(wp_json[[1]], page = page)
    suppressWarnings(res <- res[!is.na(res$date),])
    return(unique(res))
  }
  # case of multiple jsons
  if(length(wp_json)> 1 & is.character(wp_json[[1]])){
    tmp <- lapply(wp_json, worker, page = page)
    res <- do.call(rbind, tmp)
    rownames(res) <- NULL
    suppressWarnings(res <- res[!is.na(res$date),])
    return(unique(res))
  }
}
