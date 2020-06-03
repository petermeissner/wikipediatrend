

# Release Comment

This is a release tackling errors that poped up on CRAN checks. The problem was an server error preventing the exampes from completing. Examples are now marked by \dontrun to prevent these kinds of errors to poping up again. 



# Checking
# ------------------------------------

- Local :
    * OK  for : 
    
    R version 3.6.3 (2018-12-20)
    Platform: x86_64-w64-mingw32/x64 (64-bit)
    Running under: Windows 10 x64 
  

- winbuilder:
    * (OK) for : "devel" 
    * (OK) for : "release" 


- Travis Ubuntu (old, release, devel) :
    * https://travis-ci.org/petermeissner/wikipediatrend
    * OK  for : "old"
    * OK  for : "release"
    * OK  for : "devel"
  
  
- Appveyor Win
    * OK 




