# appologies 
... for having misread the paragraph about writing into file system


# Checking

- local  Win7
- Travis (Ubuntu) : https://travis-ci.org/petermeissner/wikipediatrend



# Submission comments/responses -> actions taken

But this is leaving behind a file /tmp/wikipediatrend_cache.csv .
That is not allowed by the CRAN policies.  The package is now scheduled for 
removal on Fri May 29 unless corrected before then.


-> the cache now by default only resides in memory

-> there are however two possibilities to write cache content to disk / reuse it later on 
    
    (1) wp_trend("main", file="dings.csv") will activate caching on disk for the 
    duration of the session (basically just automatically saving and loading 
    of the data)
    
    (2) with wp_make_cache_permanent() the user can activate or deactivate persistant
    caching by saving an file path via 
    Sys.setenv("WP_CACHE_PATH", paste0(dirname(tempdir()),"/wikipediatrend_cache.csv"))


I hope these changes make the package compliant to the CRAN policies. 
The (persistant) caching of the downloaded data is one explicit aim of the 
package. Data downloads take a lot of time and put a lot of pressure on the 
server making it a indespensible feature. 

