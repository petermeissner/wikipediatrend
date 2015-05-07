# tests for functions responsible for data gathering and transformation

context("caching")

test_that(
  "caching works as expected", {
    expect_null( write_utf8_csv(data.frame(), "test.csv") )
    expect_equivalent( read_utf8_csv("test.csv") , data.frame() )
    wp_cache_load()
    expect_true(exists("cache", envir = cache))
    expect_is(wp_get_cache(), "data.frame")
    expect_is(wp_get_cache(), "wp_df")
  }
)

