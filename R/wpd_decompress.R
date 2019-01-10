#' wpd_decompress
#'
#' @param cont_item single content item
#' @param lang language to decompress
#' 
wpd_decompress <-
  function(cont_item, lang){
    year <- cont_item$year
    
    date <-
      if ( year == 2007 ){
        seq.Date(
          from = as.Date(paste0(year, "-12-10")),
          to   = as.Date(paste0(year, "-12-31")),
          by   = "day"
        )
      } else {
        seq.Date(
          from = as.Date(paste0(year, "-01-01")),
          to   = as.Date(paste0(year, "-12-31")),
          by   = "day"
        )  
      }
    
    data.frame(
      page_id    = cont_item$page_id,
      lang       = lang,
      page_name  = cont_item$page_name,
      date       = date,
      page_views = unlist(strsplit(cont_item$page_view_count, ","))
    )
  }
