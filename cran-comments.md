# appologies 

... for having misread the paragraph about writing into file system



# Checking

- Local  Win7 / win8
- Local Ubuntu 14.10

- winbuilder 
- Travis (Ubuntu) : https://travis-ci.org/petermeissner/wikipediatrend



# Submission comments/responses -> actions taken

But this is leaving behind a file /tmp/wikipediatrend_cache.csv .
That is not allowed by the CRAN policies.  The package is now scheduled for 
removal on Fri May 29 unless corrected before then.


-> the cache now *by default* resides in memory and only is written to:
   tempfile("wikipediatrend_cache", fileext = ".csv") which should be CRAN
   policies compatible (quote: "Packages should not write in the users’ home 
   filespace, nor anywhere else on the file system apart from the R session’s 
   temporary directory")


-> there are however three possibilities (session wise or permanently) to 
   activate more extensive caching / more user friendly caching
  
    (1) wp_set_cache_file(file="foo.csv") will activate caching on disk 
    (reloading previously stored data and adding data downloaded during the 
    course of the session) for the rest of the session 
    (or until wp_set_cache_file() is called with no arguments)
      
    (2) wp_trend("main", file="foo.csv") will use disk caching only for this 
    single function call and thereafter fallback to whatever state was present
    beforehand - so its simply a save-my-results-on-disk option.
    
    (3) wp_cache_file() (which is also executed at startup of the package) will 
    always look if Sys.getenv("WP_CACHE_FILE") is set. If this results in a path 
    to a file, this path will be used for caching during the session if not, 
    default behaviour is applied. If used the package notifies the user with a 
    message at startup, e.g.:
      > Non empty system variable WP_CACHE_FILE found and
      > ~/wiki_cache_test.csv
      > used as path to permanent cache.
    

I hope these changes make the package compliant to the CRAN policies. 
The (persistant) caching of the downloaded data is one explicit aim of the 
package. Data downloads take a lot of time and put a lot of pressure on the 
server making it a indespensible feature. I hope this is a good compromise 
between following CRAN policies but allowing user to tune their sessions 
to no-,  semi-automatic-, or automatic-caching - whatever the preference. 

