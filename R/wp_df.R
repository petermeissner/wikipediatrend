#' a wikipediastrend specific data frame
#' @param x the thing to be printed
#' @param ... print.default parameters
#' @export
print.wp_df <- function (x, ...) 
{
  n <- length(row.names(x))
  if (length(x) == 0L) {
    cat(sprintf(ngettext(n, "data frame with 0 columns and %d row", 
                         "data frame with 0 columns and %d rows", domain = "R-base"), 
                n), "\n", sep = "")
  }
  else if (n == 0L) {
    print.default(names(x), quote = FALSE)
    cat(gettext("<0 rows> (or 0-length row.names)\n"))
  }
  else {
    # print options 
    if ( is.null(wp_cache$printoptions$rows) ) {
      rows <- 29  
    }else{
      rows <- wp_cache$printoptions$rows
    }
    if ( is.null(wp_cache$printoptions$rows) ) {
      width <- floor((options()$width - 51)/2) 
    }else{
      width <- wp_cache$printoptions$width
    }
    # printing
    m <- as.matrix(x)
    dummy <- function(x){
      ifelse(
        nchar(x) >  width , 
        paste(substring(x, 1, width ), "..." ),
        x
      )
    }
    m <- apply(m, c(1,2), dummy )
    dimnames(m)[[1L]] <- seq_len(dim(m)[1])
    if( dim(m)[1] > rows+1 ){
      text <-  paste0("\n... ", dim(m)[1]-rows, " rows of data not shown")
      SAMPLE <- sample( seq_along( m[,1] ), rows)
      m <- m[SAMPLE,]
      if( dim(m)[2]>=4 ){
        m <- m[order(m[,3], m[,4], m[,1]), ]
      }else{
        m <- m[order(m[,2]), ]
      }
      print( m , ..., quote = FALSE)
      cat(text)  
    }else{
      print(m, ..., quote = FALSE)
    }
  }
  invisible(df)
}

#' function for setting print options for print.wp_df()
#' @export
#' @param x a list of options, e.g. list(rows=35, width=50) or list(rows=Inf, width=Inf)
#'        
wp_set_print_options <- function(x){
  wp_cache$printoptions <- x
}
