# tests for functions responsible for data gathering and transformation

context("caching")

test_that(
  "write_utf8_csv works", {
    expect_null( write_utf8_csv(data.frame(), "test.csv") )
    expect_equivalent( read_utf8_csv("test.csv") , data.frame() )
    expect_true( file.exists("test.csv"))
    file.remove("test.csv")
  }
)
 
test_that(
  "default cache file", {
    expect_true( 
      wp_cache_file() == Sys.getenv("WP_CACHE_FILE") | 
      grepl( "Rtmp\\w*[\\\\/]wikipediatrend_cache\\w*\\.csv" , wp_cache_file()) 
   )  
  }
)    


test_that(
  "adding NULL to cache does not cause any error", 
  {
    expect_true(  {wp_add_to_cache(data.frame()) ; TRUE })
  }
)














