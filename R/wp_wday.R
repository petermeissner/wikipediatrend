#' Function to extract the day of the week
#' 
#' Function to extract the day from a timestamp of e.g. class POSIXlt, POSIXct, 
#' Date, or character. If the option is of type character it should be in the 
#' form of yyyy-mm-dd.
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form 
#'   of yyyy-mm-dd.
#'   
#' @param startmonday whether the week should start on Monday (TRUE, the
#'   default) or it should start on Sunday (FALSE)
#'   


wp_wday         <- function(timestamp, startmonday=T) UseMethod("wp_wday")

#' @describeIn wp_wday
wp_wday.POSIXlt  <- function(timestamp, startmonday=T){
  if(startmonday){
    tmp <- timestamp$wday
    tmp[tmp==0] <- 7
    return( tmp )
  }
  if(!startmonday){
    return( timestamp$wday+1 )
  }
}

#' @describeIn wp_wday
wp_wday.default  <- function(timestamp, startmonday=T){
  timestamp <- as.POSIXlt(wp_date(timestamp))
  if(startmonday){
    tmp <- timestamp$wday
    tmp[tmp==0] <- 7
    return( tmp )
  }
  if(!startmonday){
    return( timestamp$wday+1 )
  }
}



