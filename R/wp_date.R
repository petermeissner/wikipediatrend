wp_date <- function (x, ...) UseMethod("wp_date")

wp_date.character <- function (x, format = "", ...) {
  charToDate <- function(x) {
    xx <- x[1L]
    if (is.na(xx)) {
      j <- 1L
      while (is.na(xx) && (j <- j + 1L) <= length(x)) xx <- x[j]
      if (is.na(xx)) 
        f <- "%Y-%m-%d"
    }
    if (is.na(xx) || !is.na(strptime(xx, f <- "%Y-%m-%d", 
                                     tz = "GMT")) || !is.na(strptime(xx, f <- "%Y/%m/%d", 
                                                                     tz = "GMT"))) 
      return(strptime(x, f))
    warning("character string is not in a standard unambiguous format")
    return(NA)
  }
  res <- if (missing(format)) 
    charToDate(x)
  else strptime(x, format, tz = "GMT")
  as.Date(res)
}

wp_date.default <- function (x, ...){
  if (inherits(x, "Date")) 
    return(x)
  if (is.logical(x) && all(is.na(x))) 
    return(structure(as.numeric(x), class = "Date"))
  stop(gettextf("do not know how to convert '%s' to class %s", 
                deparse(substitute(x)), dQuote("Date")), domain = NA)
}

wp_date.numeric <- function (x, origin, ...) {
  if (missing(origin)) 
    warning("'origin' was not supplied assuming '1970-01-01'")
  as.Date("1970-01-01", ...) + x
}

as.Date.date <- function (x, ...) 
{
  if (inherits(x, "date")) {
    x <- (x - 3653)
    return(structure(x, class = "Date"))
  }
  else stop(gettextf("'%s' is not a \"date\" object", deparse(substitute(x))))
}

as.Date.dates     

as.Date.factor   

as.Date.numeric   

as.Date.POSIXct   

as.Date.POSIXlt 









