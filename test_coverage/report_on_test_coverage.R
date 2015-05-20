setwd("C:/Dropbox/RPackages/wikipediatrend/test_coverage")

if ( !require(testCoverage) ){
  devtools::install_github("MangoTheCat/testCoverage")
  library(testCoverage)
}
library(testthat)
  

reportCoverage(
  "wikipediatrend", 
  packagedir = "C:/Dropbox/RPackages/wikipediatrend", 
  unittestdir = "C:/Dropbox/RPackages/wikipediatrend/tests/testthat"
)
