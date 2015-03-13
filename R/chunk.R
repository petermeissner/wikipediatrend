#' Helper function that splits vector into chunks of specific size
#' 
#' Credit goes to: Harlan (http://stackoverflow.com/users/135944/harlan) and
#' dfrankow (http://stackoverflow.com/users/34935/dfrankow) due to their efforts
#' at Stackoverflow (http://stackoverflow.com/a/3321659/1144966)
#' 
#' @param x The vector to be chunked.
#' @param n The prefered size of those chunks.
#' 
#' @export

chunk <- function(x,n){
  if(is.null(x)) return(NULL)
  split(x, ceiling(seq_along(x)/n))
}
