
<!-- README.md is generated from README.Rmd. Please edit that file -->
Public Subject Attention via Wikipedia Page View Statistics
===========================================================

**Status**

<a href="https://travis-ci.org/petermeissner/wikipediatrend"> <img src="https://api.travis-ci.org/petermeissner/wikipediatrend.svg?branch=master"> <a/> <a href="https://cran.r-project.org/package=wikipediatrend"> <img src="http://www.r-pkg.org/badges/version/wikipediatrend"> </a> <img src="http://cranlogs.r-pkg.org/badges/grand-total/wikipediatrend"> <img src="http://cranlogs.r-pkg.org/badges/wikipediatrend">

*lines of R code:* 320, *lines of test code:* 142

**Version**

2.0.1.900000 ( 2017-09-24 20:54:36 )

**Description**

**License**

GPL (&gt;= 2) <br>Peter Meissner \[aut, cre\], R Core Team \[ctb\]

**Citation**

``` r
citation("wikipediatrend")
```

**BibTex for citing**

``` r
toBibtex(citation("wikipediatrend"))
```

**Installation**

Stable version from CRAN:

``` r
install.packages("wikipediatrend")
```

Latest development version from Github:

``` r
devtools::install_github("petermeissner/wikipediatrend")
```

**Usage**

*starting up ...*

``` r
library(wikipediatrend)
```

*getting some data ...*

``` r
trend_data <- 
  wp_trend(
    page = c("Der_Spiegel", "Die_Zeit"), 
    lang = c("de", "en"), 
    from = "2007-01-01",
    to   = "2017-01-01"
  )
```

*having a look ...*

``` r
trend_data
```

    ##      project   language article     access     agent      granularity date       views
    ## 1329 wikipedia de       Der_Spiegel all-access all-agents daily       2016-05-28  796 
    ## 667  wikipedia en       Der_Spiegel all-access all-agents daily       2015-12-14  426 
    ## 211  wikipedia en       Der_Spiegel all-access all-agents daily       2015-08-22  342 
    ## 1898 wikipedia de       Die_Zeit    all-access all-agents daily       2016-10-17  741 
    ## 138  wikipedia de       Die_Zeit    all-access all-agents daily       2015-08-04  597 
    ## 972  wikipedia en       Die_Zeit    all-access all-agents daily       2016-02-28  182 
    ## 1020 wikipedia en       Die_Zeit    all-access all-agents daily       2016-03-11  274 
    ## 86   wikipedia de       Die_Zeit    all-access all-agents daily       2015-07-22  553 
    ## 12   wikipedia en       Die_Zeit    all-access all-agents daily       2015-07-03  208 
    ## 400  wikipedia en       Die_Zeit    all-access all-agents daily       2015-10-08  233 
    ## 
    ## ... 2194 rows of data not shown

*having another look ...*

``` r
plot(trend_data)
```

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png)

**Credits**

-   Parts of the package's code have been shamelessly copied and modified from R base package written by R core team. This concerns the `wp_date()` generic and its methods and is detailed in the help files.
