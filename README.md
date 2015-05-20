# wikipediatrend

# Author

Peter Meißner



# Last Update

2015-05-20



# Status

[<img src="https://api.travis-ci.org/petermeissner/wikipediatrend.svg?branch=master">
](https://travis-ci.org/petermeissner/wikipediatrend)
 <br> 
[<img src="https://coveralls.io/repos/petermeissner/wikipediatrend/badge.svg" >
](https://coveralls.io/r/petermeissner/wikipediatrend)
 <br> 
[<img src="http://cranlogs.r-pkg.org/badges/grand-total/wikipediatrend">
](http://cranlogs.r-pkg.org/)
[<img src="http://cranlogs.r-pkg.org/badges/wikipediatrend">
](http://cranlogs.r-pkg.org/)






# Purpose

The wikipeditrend package is designed around the idea to make Wikipedia page view statistics data availible in R in a most convenient way. 

*Consequently the package provides* 

- daily page views as data frames 
- page views for user set time spans
- page views for multiple articles in one function call
- page views for articles in different language domains 
- background caching of results to minimize function execution time as well as server burdens






# Installation 

A stable version of the package can be found on CRAN and installed via ...

```r
install.packages("wikipediatrend")
```

... while the current developement version can be retrieved by using `install_github()` from the devtools package ... 


```r
devtools::install_github("petermeissner/wikipediatrend")
```

After loading the package several functions are available.


```r
library(wikipediatrend)
```




# Usage:


The workhorse of the package is the `wp_trend()` function:


```r
wp <- wp_trend(page = c("Fever","Fieber"), 
               from = "2013-08-01", 
               to   = prev_month_end(), 
               lang = c("en","de"))
```

```
## .
```

The function's return is a data frame with six variables *date*, *count*, *project*, *title*, *rank*, *month* paralleling the data provided by the stats.grok.se server:


```r
head(wp)
```

```
##   date       count lang page  rank month  title
## 1 2013-08-26 2993  en   Fever 5014 201308 Fever
## 2 2013-08-27 3153  en   Fever 5014 201308 Fever
## 3 2013-08-28 2984  en   Fever 5014 201308 Fever
## 4 2013-08-19 3229  en   Fever 5014 201308 Fever
## 5 2013-08-18 2700  en   Fever 5014 201308 Fever
## 6 2013-08-31 2441  en   Fever 5014 201308 Fever
```


```r
library(ggplot2)

ggplot(wp, aes(date, count, group=page, color = page)) + 
  geom_point() +
  geom_smooth(method="lm", formula = y ~ poly(x, 20), size=1.5) +
  theme_bw()
```

![](Readme_files/figure-html/unnamed-chunk-6-1.png) 




# Vignette

*For a more detailed usage have a look at the vignette accompanying the package. `vignette("using-wikipediatrend", package="wikipediatrend")`*

... or GoTo [CRAN](http://cran.r-project.org/web/packages/wikipediatrend/index.html) or build it from scratch from [Github](https://raw.githubusercontent.com/petermeissner/wikipediatrend/master/vignettes/using-wikipediatrend.Rmd).



# Some examples for using page view statistics


- Mellon, Jonathan (2014) *Internet Search Data and Issue Salience: The Properties of Google Trends as a Measure of Issue Salience* Journal of Elections, Public Opinion and Parties 24(1):4572.
http://www.tandfonline.com/doi/abs/10.1080/17457289.2013.846346 

- Ripberger, Joseph T. (2011): *Capturing curiosity: using Internet search trends to measure public attentiveness*. Policy Studies Journal 39(2):239-259.
http://onlinelibrary.wiley.com/doi/10.1111/j.1541-0072.2011.00406.x/full

- Yla Tausczik, Kate Faasse, James W. Pennebaker, Keith J. Petrie (2012): *Public Anxiety and Information Seeking Following the H1N1 Outbreak: Blogs, Newspaper Articles, and Wikipedia Visits*. Health Communication, Vol. 27, Iss. 2.
 http://www.tandfonline.com/doi/pdf/10.1080/10410236.2011.571759

- Taha Yasseri and Jonathan Bright (2015): *Predicting elections from online information flows: towards theoretically informed models*. http://arxiv.org/abs/1505.01818

 




# Thanks 

Fernando Reis, Eryk Walczak, Simon Munzert





# Credits

- Parts of the package's code have been shamelessly copied and modified from R base package written by R core team. This concerns the `wp_date()` generic and its methods and is detailed in the help files. 







