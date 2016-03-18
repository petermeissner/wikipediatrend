#' function for getting year and month of a timestamp
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd. 
#' 
#' @export 
#' 

wp_yearmonth <- function(timestamp){
  if( is.null(timestamp) ) return(NULL)
  paste0(
    wp_year(wp_date(timestamp)), 
    stringr::str_pad(wp_month(wp_date(timestamp)), 2, "left", 0)
  )
}


#' Package specific 'as.Date()' function
#' 
#' \code{wp_date()} provides a generic function and several methods to transform
#' something into a date, just like \code{as.Date()} from the base package.
#' While most methods were copied 1:1 from as.Date() some changes were made that
#' alter  the usual behavior: (1) Whenever wp_date() is applied to an empty
#' string \code{""} or any other not-standard-unambiguous format the function
#' will return \code{NA} and throw out a warning instead of simply kill itself
#' with an error. (2) Whenever, as.Date usually is in the need of an origin
#' supplied and does not get one \code{wp_date()} will assume the origin to be
#' "1970-01-01" and throw an error instead of kill itself with an error. All
#' these changes are made with the special purpose to make \code{wp_trend()}
#' also with dirty, unreasonable data (e.g. "" or "2012-13-01" or "2012-02-32")
#' and are not recommended for any other than wikipediatrend internal use.
#' 
#' @param x See \code{?as.Date}
#' @param format See \code{?as.Date}
#' @param origin See \code{?as.Date}
#' @param tz See \code{?as.Date}
#' @param ... See \code{?as.Date}
#' 
#' @export 
#' 

wp_date <- function (x, ...)
{
  UseMethod("wp_date")
}


#' @describeIn wp_date Difference to \code{as.Date.character()}: Failing to
#'   parse the date, \code{wp_date()} will give return a warning and \code{NA}
#'   instead of killing itself with an error.
#' 
#' @export 
#' 
wp_date.character <- function (x, format = "", ...) 
{
  if ( format=="" ) {
    res <- strptime(x, format="%Y-%m-%d")
  }else{
    res <- strptime(x, format=format)
  }
  wp_date(res)
}



#' @describeIn wp_date same as \code{as.Date()}
#' 
#' @export 
#' 

wp_date.default <- function (x, ...)
{
  if( is.null(x) ) return(NULL)
  if (inherits(x, "Date")) 
    return(x)
  if (is.logical(x) && all(is.na(x))) 
    return(structure(as.numeric(x), class = "Date"))
  stop(gettextf("do not know how to convert '%s' to class %s", 
                deparse(substitute(x)), dQuote("Date")), domain = NA)
}


#' @describeIn wp_date  Difference to \code{as.Date.character()}: Whenever an 
#'   origin is needed but not supplied isntead of breaking, \code{wp_date()} 
#'   will raise a warning and proceed by assuming "1970-01-01" to be the origin 
#'   instead of killing itself with an error.
#' 
#' @export 
#' 

wp_date.numeric <- function (x, origin, ...) 
{
  if (missing(origin)) 
    warning("'origin' was not supplied assuming '1970-01-01'")
  wp_date("1970-01-01", ...) + x
}


#' @describeIn wp_date  same as \code{as.Date()} 
#' 
#' @export 
#' 
wp_date.dates <- function (x, ...) 
{
  if (inherits(x, "dates")) {
    z <- attr(x, "origin")
    x <- trunc(as.numeric(x))
    if (length(z) == 3L && is.numeric(z)) 
      x <- x + as.numeric(wp_date(paste(z[3L], z[1L], z[2L], 
                                        sep = "/")))
    return(structure(x, class = "Date"))
  }
  else stop(gettextf("'%s' is not a \"dates\" object", deparse(substitute(x))))
}


#' @describeIn wp_date  same as \code{as.Date()} 
#' 
#' @export 
#' 
wp_date.factor <- function (x, ...) 
{
  wp_date(as.character(x), ...) 
}


#' @describeIn wp_date  same as \code{as.Date()} 
#' 
#' @export 
#' 
wp_date.POSIXct    <- function (x, tz = "UTC", ...) 
{
  if (tz == "UTC") {
    z <- floor(unclass(x)/86400)
    attr(z, "tzone") <- NULL
    structure(z, class = "Date")
  }
  else wp_date(as.POSIXlt(x, tz = tz))
}


#' @describeIn wp_date  using \code{as.Date()} 
#' 
#' @export 
#' 
wp_date.POSIXlt <- function (x, ...) 
{
  as.Date(x)
}








#' Function to extract the day
#' 
#' Function to extract the day from a timestamp of e.g. class POSIXlt, POSIXct,
#' Date, or character. If the option is of type character it should be in the
#' form of yyyy-mm-dd.
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd.
#'   
#'   
#' 
#' @export
#'  

wp_day          <- function(timestamp){
  UseMethod("wp_day")
}

#' @describeIn wp_day extract day from timestamp
#' 
#' @export
#' 
 
wp_day.POSIXlt  <- function(timestamp) {
  timestamp$mday
}

#' @describeIn wp_day extract day from timestamp
#' 
#' @export
#' 

wp_day.default  <- function(timestamp) {
  if( is.null(timestamp) ) return(NULL)
  as.POSIXlt(wp_date(timestamp))$mday
}


#' Function to extract the month
#' 
#' Function to extract the month from a timestamp of e.g. class POSIXlt,
#' POSIXct, Date, or character. If the option is of type character it should be
#' in the form of yyyy-mm-dd.
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd.
#'    
#' 
#' @export 
#' 

wp_month          <- function(timestamp) UseMethod("wp_month")


#' @describeIn wp_month extract
#'  @export 
#'  

wp_month.POSIXlt  <- function(timestamp) {
  timestamp$mon+1
}


#' @describeIn wp_month extract
#'  @export 
#'  

wp_month.default  <- function(timestamp) {
  if( is.null(timestamp) ) return(NULL)
  as.POSIXlt(wp_date(timestamp))$mon+1
}


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
#' 
#' @export 
#'   


wp_wday         <- function(timestamp, startmonday=T) UseMethod("wp_wday")


#' @describeIn wp_wday method for POSIXlt
#' @export 
#'  

wp_wday.POSIXlt  <- function(timestamp, startmonday=T){
  if( is.null(timestamp) ) return(NULL)
  if(startmonday){
    tmp <- timestamp$wday
    tmp[tmp==0] <- 7
    return( tmp )
  }
  if(!startmonday){
    return( timestamp$wday+1 )
  }
}



#' @describeIn wp_wday method for everything coercable by as.POSIXlt 
#' @export 
#' 

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



#' Function to extract the year 
#' 
#' Function to extract the year from a timestamp of e.g. class POSIXlt, POSIXct, Date, or character. If the option is of type character it should be in the form of yyyy-mm-dd.
#' 
#' @param timestamp Some sort of timestamp e.g. of class POSIXlt, POSIXct, Date,
#'   or character. If the option is of type character it should be in the form
#'   of yyyy-mm-dd.
#'  
#' 
#' @export 
#' 

wp_year          <- function(timestamp) UseMethod("wp_year")



#' @describeIn wp_year extract
#' @export 
#' 

wp_year.POSIXlt  <- function(timestamp) {
  timestamp$year+1900
}



#' @describeIn wp_year extract
#' @export 
#' 

wp_year.default  <- function(timestamp) {
  if( is.null(timestamp) ) return(NULL)
  as.POSIXlt(wp_date(timestamp))$year+1900
}
