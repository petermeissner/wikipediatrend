#' a wikipediastrend specific data frame
#' 
#' @aliases print
#' @export


print.wp_df <- function (df, ..., digits = NULL, quote = FALSE, right = TRUE, 
          row.names = TRUE) 
{
  n <- length(row.names(df))
  if (length(df) == 0L) {
    cat(sprintf(ngettext(n, "data frame with 0 columns and %d row", 
                         "data frame with 0 columns and %d rows", domain = "R-base"), 
                n), "\n", sep = "")
  }
  else if (n == 0L) {
    print.default(names(df), quote = FALSE)
    cat(gettext("<0 rows> (or 0-length row.names)\n"))
  }
  else {
    #m <- as.matrix(format.data.frame(df, digits = digits, 
    #                                 na.encode = FALSE))
    m <- as.matrix(df)
    dummy <- function(x){
      ifelse(
        nchar(x) > 30, 
        paste(substring(x, 1, 26 ), "..." ),
        x
      )
    }
    m <- apply(m, c(1,2), dummy )
    dimnames(m)[[1L]] <- seq_len(dim(m)[1])
    #if( dim(m)[1] > 30 ){
    #  print(m[1:29,], ..., quote = quote, right = right)
    #  cat(paste0("\n... ", dim(m)[1]-29, " rows of data not shown"))  
    #}else{
      print(m, ..., quote = quote, right = right)
    #}
    
    
  }
  invisible(df)
}
