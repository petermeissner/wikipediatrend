#' Helper function for wp_trend
#' 
#' The function does accepts a list of JSON snippets and transforms the information into a data frame
#' 
#' @param wikipediaTrendJson The results from server request in JSON format

extract_access_counts <- function(wikipediaTrendJson){
  worker <- function(wikipediaTrendJson){
    tmp <- RJSONIO::fromJSON(wikipediaTrendJson)$daily_views
    data.frame(date=names(tmp), count=tmp)
  }
  if(length(wikipediaTrendJson)==1 & is.character(wikipediaTrendJson[[1]])){
    return(worker(wikipediaTrendJson[[1]]))
  }
  if(length(wikipediaTrendJson)> 1 & is.character(wikipediaTrendJson[[1]])){
    date  <- unlist(lapply(lapply(wikipediaTrendJson, worker), '[[', "date"))
    count <- unlist(lapply(lapply(wikipediaTrendJson, worker), '[[', "count"))
    res   <- data.frame(date=as.Date(date), count, row.names = NULL)
    res <- res[!is.na(res$date),]
    return(res)
  }
}
