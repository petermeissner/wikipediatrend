This is a re-submit after having been asked to solve the following problems:


# Your complaints
# ------------------------------------

Found the following (possibly) invalid URLs:
  
  URL: http://cran.rstudio.com/web/packages/wikipediatrend/ (moved to https://cran.rstudio.com/web/packages/wikipediatrend/)
    From: inst/doc/using-wikipediatrend.html
    Status: 200
    Message: OK
    CRAN URL not in canonical form
  
  URL: https://cran.rstudio.com/
    From: README.md
    Status: 200
    Message: OK
    CRAN URL not in canonical form



# Re-submission comments 
# ------------------------------------

-> the first URL: 
  - fixed

-> the second URL: 
  - should be left as is
  - Inedeed the URL is not in canonical form (canonical form would be https://cran.r-project.org/ , I guess?) but the download numbers mentioned in the README.md are only valid for this particular server. So the non-canonical form is the right one in this case. 



# Checking
# ------------------------------------

- Local :
  
  R version 3.2.4 (2016-03-10)
  Platform: x86_64-pc-linux-gnu (64-bit)
  Running under: Ubuntu 14.04.4 LTS

- winbuilder (release, devel) :
  http://win-builder.r-project.org/KM0W4ZGlaQqu/00check.log
  
- Travis Ubuntu (old, release, devel) :
  https://travis-ci.org/petermeissner/wikipediatrend
  
- Appveyor Win
  https://ci.appveyor.com/project/petermeissner/wikipediatrend

- check status: 
    - checks succeded without Errors and Warnings for most builds
    - one Note on Windows builds informed that qpdf was missing to check PDF size
    - on local Ubuntu build I get "LaTeX errors when creating PDF version." warning but not on other builds ... I am not sure what is the problem here


