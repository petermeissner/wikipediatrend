# Checking
# ------------------------------------

- Local :
  R version 3.2.2 (2015-08-14)
  Platform: x86_64-pc-linux-gnu (64-bit)
  Running under: Ubuntu 14.04.3 LTS

- winbuilder (release, devel) :
  http://win-builder.r-project.org/fheokitvnBgf/00check.log
  http://win-builder.r-project.org/R0W223v3K3NT/00check.log
  
- Travis Ubuntu (old, release, devel) :
  https://travis-ci.org/petermeissner/wikipediatrend

- Appveyor:
  https://ci.appveyor.com/project/petermeissner/wikipediatrend


# Submission comments 
# ------------------------------------

- rvest package update 0.2.0 to 0.3.0 caused (or will cause depending on when Hadley Wickham submits the package to CRAN) several problems due to function deprecation, those were solved, now package works with old and new versions of rvest
