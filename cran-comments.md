
###########################################################
# Checking
###########################################################


- Local  Win7-32 / Win8-64
- Local Ubuntu 14.10

- winbuilder :
  http://win-builder.r-project.org/5mr52ul843VK/00check.log
  http://win-builder.r-project.org/4sFNjSdEjY86/00check.log
  
- Travis (Ubuntu) : 
  https://travis-ci.org/petermeissner/wikipediatrend


###########################################################
# Submission comments 
# --> actions taken
###########################################################

One, you suggest packages AnomalyDetection and BreakoutDetection from
non-standard repositories which will thus typically not be available for
checking, but use these unconditionally in your vignettes (so that
running the code in the vignettes mostly fails).  Would it be possible
to conditionalize running these code chunks on the availability of these
packages?  If not (i.e., if this makes the code too messy), we can put
your package onto our --no-vignettes stop lists.

--> I made all chunk evaluations using AnomalyDetection / BreakoutDetection conditional on ...

( require(BreakoutDetection) & AnomalyDetection ) 

... either the packages are installed than code is executed or they are not,
than code is simply included but does not run


-----------------------------------------------------------

 
Two, we get things like
 
Check: for unstated dependencies in vignettes
Result: NOTE
    Warning: parse error in file ‘/home/hornik/tmp/R.check/r-devel-clang/Work/build/Packages/wikipediatrend/doc/using-wikipediatrend.R’:
    invalid multibyte character in parser at line 88 
 
...
 
R> tools::showNonASCIIfile("vignettes/using-wikipediatrend.Rmd")
3: author: "Peter Mei<c3><9f>ner"
217: wp_trend("K<c3><a4>se", lang="de", file="cheeeeese.csv")
 
The corresponding .R file in inst/doc has
 
R> tools::showNonASCIIfile("inst/doc/using-wikipediatrend.R")
88: wp_trend("K<e4>se", lang="de", file="cheeeeese.csv")
 
...

--> I replaced the a-umlaut by \u00e4 

-----------------------------------------------------------

