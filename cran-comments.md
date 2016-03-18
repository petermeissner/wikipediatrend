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


# Submission comments 
# ------------------------------------

- tests and vignette building failed due to missing data on the stats.grok.se server - tests and vignette were made more robust against these problems
