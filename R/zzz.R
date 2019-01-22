.onAttach <- function(libname, pkgname){
  packageStartupMessage(
    "
  [wikipediatrend]
    
  Note:
    
    - Data before 2016-01-01 
      * is provided by petermeissner.de and
      * was prepared in a project commissioned by the Hertie School of Governance (Simon Munzert)
      * and supported by the Daimler and Benz Foundation.
    
    - Data from 2016-01-01 onwards 
      * is provided by the Wikipedia Foundation
      * via its pageviews package and API.
    ")
}

.onLoad <- function(libname, pkgname){
  
}
