
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

**Credits**

-   Parts of the package's code have been shamelessly copied and modified from R base package written by R core team. This concerns the `wp_date()` generic and its methods and is detailed in the help files.

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
    ## 511  wikipedia en       Der_Spiegel all-access all-agents daily       2015-11-05  500 
    ## 1391 wikipedia en       Der_Spiegel all-access all-agents daily       2016-06-12  458 
    ## 1599 wikipedia en       Der_Spiegel all-access all-agents daily       2016-08-03  373 
    ## 909  wikipedia de       Der_Spiegel all-access all-agents daily       2016-02-13 1171 
    ## 1546 wikipedia de       Die_Zeit    all-access all-agents daily       2016-07-21  615 
    ## 1132 wikipedia en       Die_Zeit    all-access all-agents daily       2016-04-08  160 
    ## 1420 wikipedia en       Die_Zeit    all-access all-agents daily       2016-06-19  129 
    ## 2012 wikipedia en       Die_Zeit    all-access all-agents daily       2016-11-14  204 
    ## 2190 wikipedia de       Die_Zeit    all-access all-agents daily       2016-12-29  717 
    ## 586  wikipedia de       Die_Zeit    all-access all-agents daily       2015-11-24 1348 
    ## 
    ## ... 2194 rows of data not shown

*having another look ...*

``` r
plot(trend_data)
```

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png)
