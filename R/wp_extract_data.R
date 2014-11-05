#' Helper function for wp_trend
#' 
#' The function does accepts a list of JSON snippets and transforms the
#' information into a data frame
#' 
#' @param wp_json The results from server request in JSON format

wp_extract_data <- function(wp_json){
  worker <- function(wp_json){
    tmp         <- jsonlite::fromJSON(wp_json)$daily_views
    tmp_data <- data.frame( date = wp_date( names(tmp) ), 
                            count= unlist(tmp)           )
    return(tmp_data)
  }
  if( length(wp_json)==0 ) return(data.frame(date=NULL, count=NULL))
  if(length(wp_json)==1 & is.character(wp_json[[1]])){
    res <- worker(wp_json[[1]])
    res <- res[!is.na(res$date),]
    return(res)
  }
  if(length(wp_json)> 1 & is.character(wp_json[[1]])){
    date  <- unlist(lapply(lapply(wp_json, worker), '[[', "date"))
    count <- unlist(lapply(lapply(wp_json, worker), '[[', "count"))
    res   <- data.frame( date=wp_date(date, origin="1970-01-01"), 
                         count, row.names = NULL)
    res <- res[!is.na(res$date),]
    return(res)
  }
}
