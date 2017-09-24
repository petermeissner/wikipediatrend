
<!-- README.md is generated from README.Rmd. Please edit that file -->
Public Subject Attention via Wikipedia Page View Statistics
===========================================================

**Status**

<a href="https://travis-ci.org/petermeissner/wikipediatrend"> <img src="https://api.travis-ci.org/petermeissner/wikipediatrend.svg?branch=master"> <a/> <a href="https://codecov.io/gh/petermeissner/wikipediatrend"> <img src="https://codecov.io/gh/petermeissner/wikipediatrend/branch/master/graph/badge.svg" alt="Codecov" /> </a> <a href="https://cran.r-project.org/package=wikipediatrend"> <img src="http://www.r-pkg.org/badges/version/wikipediatrend"> </a> <img src="http://cranlogs.r-pkg.org/badges/grand-total/wikipediatrend"> <img src="http://cranlogs.r-pkg.org/badges/wikipediatrend">

*lines of R code:* 316, *lines of test code:* 158

**Version**

2.0.1.900000 ( 2017-09-24 21:41:52 )

**Description**

**License**

GPL (&gt;= 2) <br>Peter Meissner \[aut, cre\], \[ctb\]

**Credits**

-   Parts of the package's code have been shamelessly copied and modified from R base package written by R core team. This concerns the `wp_date()` generic and its methods and is detailed in the help files.

**Citation**

``` r
citation("wikipediatrend")
```

Meissner P (2017). *wikipediatrend: Public Subject Attention via Wikipedia Page View Statistics*. R package version 2.0.1.900000.

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
    ## 573  wikipedia de       Der_Spiegel all-access all-agents daily       2015-11-21 3359 
    ## 1139 wikipedia en       Der_Spiegel all-access all-agents daily       2016-04-10  381 
    ## 2153 wikipedia de       Der_Spiegel all-access all-agents daily       2016-12-20 1154 
    ## 627  wikipedia en       Der_Spiegel all-access all-agents daily       2015-12-04  416 
    ## 2041 wikipedia de       Der_Spiegel all-access all-agents daily       2016-11-22 1011 
    ## 1415 wikipedia en       Der_Spiegel all-access all-agents daily       2016-06-18  403 
    ## 1863 wikipedia en       Der_Spiegel all-access all-agents daily       2016-10-08  429 
    ## 1676 wikipedia en       Die_Zeit    all-access all-agents daily       2016-08-22  179 
    ## 564  wikipedia en       Die_Zeit    all-access all-agents daily       2015-11-18  284 
    ## 206  wikipedia de       Die_Zeit    all-access all-agents daily       2015-08-21  565 
    ## 
    ## ... 2194 rows of data not shown

*having another look ...*

``` r
plot(trend_data)
```

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png)
