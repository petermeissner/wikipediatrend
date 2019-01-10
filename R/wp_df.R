#' a wikipediastrend specific data frame
#' @param x the thing to be printed
#' @param ... print.default parameters
#' @import hellno
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
    rows <- 10
    width <- floor((options()$width - 51)/2) 

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
      text   <-  paste0("\n... ", dim(m)[1]-rows, " rows of data not shown")
      sq     <- seq_along(m[,1])
      SAMPLE <- c( utils::head(sq, 5), utils::tail(sq, 5) )
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
  invisible(x)
}

