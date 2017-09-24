#' check page input 
#'
wp_check_page_input <- function(page){
  # make first letter capital
  page <- stringr::str_replace( page, "^.", substring(toupper(page),1,1) )
  
  # replace spaces with underscore
  page <- stringr::str_replace( page, " ", "_" )
  
  # url encode thos not already encoded
  for( i in seq_along(page) ){
    if ( stringr::str_detect( page[i], "%" ) ){
      page[i] <- utils::URLdecode(page[i])
    }
  }
  
  # return
  return(page)
}
