library(wikipediatrend)


context("wp_check_date_inputs()")
# ----------------------------------------------------------

test_that("wp_check_date_inputs() works as expected", {
  expect_error(
    wp_check_date_inputs()
    )
  expect_error(
    wp_check_date_inputs(1,1)
    )
  expect_true({
    wp_check_date_inputs(from="2001-01-01", to="2001-01-02"); TRUE;
  })
  expect_true({
    wp_check_date_inputs(from="2000-01-01", to="2001-01-01"); TRUE;
  })
  expect_error({
    wp_check_date_inputs(from="2001-01-01", to="2000-01-01"); TRUE;
  })
  expect_true({
    wp_check_date_inputs(from="2011-01-01", to="2011-01-01"); TRUE;
  })
  expect_true({
    wp_check_date_inputs(from="2010-01-01", to="2011-01-01"); TRUE;
  })
  expect_error({
    wp_check_date_inputs(from="2011-01-01", to="2010-01-01")
  })
})



context("wp_date()")
# ----------------------------------------------------------

date_na   <- c("", "01-01", "2000-01", "2015-02-29")
date_num  <- -10:10
date_char <- apply(expand.grid(year=2004:2006, months=1:3, days=1:5),1, paste0, collapse="-")

dates1 <- paste0("2015-03-", 1:32)
dates2 <- paste0("2015-02-", 1:32)
dates3 <-         apply(expand.grid(year=2004:2006, months=0:14, days=-5:33),1, paste0, collapse="-")
dates4 <- as.Date(apply(expand.grid(year=2006,      months=1:12, days= 1:28),1, paste0, collapse="-"))


test_that("wp_date() works as expected", {
  expect_is(
    wp_date("2000-01-01"), "Date"
    )
  expect_is(suppressWarnings(
    wp_date(1:10)), "Date"
    )
  expect_warning(
    wp_date(1:10)
    )
  expect_error(
    wp_date()
    )
  
  expect_true(  
    all(is.na(wp_date(date_na))) 
    )
  expect_true(  
    all(wp_date(date_num, origin=0)== -10:10) 
    )
  expect_is(  
    wp_date(date_char, origin=0) , "Date"
    )
  
  expect_true( 
    !is.na(wp_date("2012-02-29")) 
    )
  
  expect_true(
    suppressWarnings(                
      wp_date(as.numeric(as.Date("2015-01-01"))) == "2015-01-01"
      )
    )
  expect_true(
    suppressWarnings(                
      wp_date(16436) == "2015-01-01"              
      )
    )
})



context("wp_day()")
# ----------------------------------------------------------

test_that("wp_day() works as expected.", {
  expect_true(  all(is.na(wp_day(date_na))) )
  expect_true(  suppressWarnings(all(wp_day(date_num)== c(22:31,1:11))) )
  expect_true(  is.numeric(wp_day(date_char)))
})



context("wp_year()")
# ----------------------------------------------------------

test_that("wp_year() works as expected.", {
  expect_true(  all(is.na(wp_year(date_na))) )
  expect_true(  suppressWarnings(all(wp_year(date_num) %in% 1969:1970)) )
  expect_is(  wp_year(date_char) , "numeric")
})



context("wp_month()")
# ----------------------------------------------------------

test_that("wp_month() works as expected.", {
  expect_true(  all(is.na(wp_month(date_na))) )
  expect_true(  suppressWarnings(all(wp_month(date_num) %in% c(12,1))) )
  expect_is(  wp_month(date_char) , "numeric")
})



context("wp_yearmonth()")
# ----------------------------------------------------------

test_that("wp_yearmonth() works as expected.", {
  # expect_true(  all(is.na(wp_yearmonth(date_na))) )
  expect_true(  suppressWarnings(all(wp_yearmonth(date_num) %in% c(196912,197001))) )
  expect_is(  wp_yearmonth(date_char) , "character")
})




















