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
  "normal usage", {
    wp_trend("main")
    expect_true( all(dim(wp_get_cache())>0) ) 
  }
)

test_that(
  "setting cache file", {
    wp_set_cache_file("test.csv")
    expect_equal( "test.csv", wp_cache_file() )  
    expect_true( file.exists("test.csv") )
  
    dings <- wp_trend("main") 
    
    expect_true( all(dim(wp_get_cache()) > 0 ))
    file.remove("test.csv")

        oldcache  <- wp_cache_file()
    wp_trend("main", file="test.csv")
    expect_true( file.exists("test.csv") )
    expect_true( oldcache == wp_cache_file() )
    file.remove("test.csv")
  }
)

test_that(
  "cache reset", {
    wp_cache_reset()
    expect_true( all(dim(wp_get_cache()) == 0 ))
    expect_true( 
      (
        wp_cache_file() == Sys.getenv("WP_CACHE_FILE") | 
        grepl( "Rtmp\\w*[\\\\/]wikipediatrend_cache\\w*\\.csv" , wp_cache_file())
      ) &
      wp_cache_file()!=""
    )  
    
    dings <- wp_trend("main")
    dongs <- wp_get_cache()
    expect_true( all(dings==dongs) ) 
  }
)


test_that(
  "file argument in wp_trend()", {
    wp_cache_reset()
    
    old_cache_file <- wp_cache_file()
     
    expect_true(
      file.exists("extdata/wikipediatrend_cache.csv") 
    )
    
    wp_cache_load("extdata/wikipediatrend_cache.csv")
    
    expect_true( old_cache_file == wp_cache_file() )
    expect_true( all(dim(wp_get_cache())>0) )
    
    dings <- wp_trend("main", file = "test.csv")
    
  }
)

















