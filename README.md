# wikipediatrend

**Author:** Peter Meißner

**Last update:** 2015-05-09

**Status:**
<img src="https://api.travis-ci.org/petermeissner/wikipediatrend.svg?branch=master"></img>
<img src="http://cranlogs.r-pkg.org/badges/wikipediatrend"></img>
[![Coverage Status](https://coveralls.io/repos/petermeissner/wikipediatrend/badge.svg)](https://coveralls.io/r/petermeissner/wikipediatrend)

# Purpose

The wikipeditrend package is designed around the idea to make Wikipedia page view statistics data availible in R in a most convenient way. 

*Consequently the package provides* 

- daily page views as data frames 
- page views for user set time spans
- page views for multiple articles in one function call
- page views for articles in different language domains 
- background caching of results minimize function execution time as well as server burdens


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
## 1 2015-01-18 1363  en   Fever 5014 201501 Fever
## 2 2015-01-19 2036  en   Fever 5014 201501 Fever
## 3 2015-01-10 1290  en   Fever 5014 201501 Fever
## 4 2015-01-11 1379  en   Fever 5014 201501 Fever
## 5 2015-01-12 1901  en   Fever 5014 201501 Fever
## 6 2015-01-13 1841  en   Fever 5014 201501 Fever
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

# Thanks

- Fernando Reis
- Eryk Walczak


# Credits

- Parts of the package's code have been shamelessly copied and modified from R base package written by R core team. This concerns the `wp_date()` generic and its methods and is detailed in the help files. 



<!-- http://www.tandfonline.com/doi/pdf/10.1080/10410236.2011.571759 -->



