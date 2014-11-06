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

wp_date <- function (x, ...)
{
  UseMethod("wp_date")
}


#' @describeIn wp_date Difference to \code{as.Date.character()}: Failing to
#'   parse the date, \code{wp_date()} will give return a warning and \code{NA}
#'   instead of killing itself with an error.
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
wp_date.default <- function (x, ...)
{
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
wp_date.numeric <- function (x, origin, ...) 
{
  if (missing(origin)) 
    warning("'origin' was not supplied assuming '1970-01-01'")
  wp_date("1970-01-01", ...) + x
}


#' @describeIn wp_date  same as \code{as.Date()}
wp_date.date <- function (x, ...) 
{
  if (inherits(x, "date")) {
    x <- (x - 3653)
    return(structure(x, class = "Date"))
  }
  else stop(gettextf("'%s' is not a \"date\" object", deparse(substitute(x))))
}


#' @describeIn wp_date  same as \code{as.Date()}
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
wp_date.factor <- function (x, ...) 
{
  wp_date(as.character(x), ...) 
}


#' @describeIn wp_date  same as \code{as.Date()}
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
wp_date.POSIXlt <- function (x, ...) 
{
  as.Date(x)
}








