#' function to get date of end of prev month
#' @export

prev_month_end <- function() Sys.Date()-wp_day(Sys.Date())


#' function to get date of start of prev month
#' @export

prev_month_start <- function() prev_month_end() - wp_day(prev_month_end()) +1
