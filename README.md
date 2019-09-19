
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Public Subject Attention via Wikipedia Page View Statistics

**Status**

<a href="https://travis-ci.org/petermeissner/wikipediatrend"><img src="https://api.travis-ci.org/petermeissner/wikipediatrend.svg?branch=master"><a/>
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/petermeissner/wikipediatrend?branch=master&svg=true)](https://ci.appveyor.com/project/petermeissner/wikipediatrend)
<a href="https://codecov.io/gh/petermeissner/wikipediatrend"><img src="https://codecov.io/gh/petermeissner/wikipediatrend/branch/master/graph/badge.svg" alt="Codecov" /></a>
<a href="https://cran.r-project.org/package=wikipediatrend">
<img src="http://www.r-pkg.org/badges/version/wikipediatrend"> </a>
<img src="http://cranlogs.r-pkg.org/badges/grand-total/wikipediatrend">
<img src="http://cranlogs.r-pkg.org/badges/wikipediatrend">

*lines of R code:* 448, *lines of test code:* 160

**Version**

2.1.1 ( 2019-09-19 21:51:46 )

**Description**

**License**

GPL (\>= 2) <br>Peter Meissner \[aut, cre\], \[ctb\]

**Credits**

  - Parts of the package’s code have been shamelessly copied and
    modified from R base package written by R core team. This concerns
    the `wp_date()` generic and its methods and is detailed in the help
    files.

**Citation**

``` r
citation("wikipediatrend")
```

Meissner P (2019). *wikipediatrend: Public Subject Attention via
Wikipedia Page View Statistics*. R package version 2.1.1.

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

*starting up …*

``` r
library(wikipediatrend)
```

    ## 
    ##   [wikipediatrend]
    ##     
    ##   Note:
    ##     
    ##     - Data before 2016-01-01 
    ##       * is provided by petermeissner.de and
    ##       * was prepared in a project commissioned by the Hertie School of Governance (Simon Munzert)
    ##       * and supported by the Daimler and Benz Foundation.
    ##     
    ##     - Data from 2016-01-01 onwards 
    ##       * is provided by the Wikipedia Foundation
    ##       * via its pageviews package and API.
    ## 

*getting some data …*

``` r
trend_data <- 
  wp_trend(
    page = c("Der_Spiegel", "Die_Zeit"), 
    lang = c("de", "en"), 
    from = "2007-01-01",
    to   = Sys.Date()
  )
```

*having a look …*

``` r
trend_data
```

    ##      language article     date       views
    ## 2    en       die_zeit    2007-12-10    74
    ## 1    de       der_spiegel 2007-12-10   798
    ## 4    en       die_zeit    2007-12-11    35
    ## 3    de       der_spiegel 2007-12-11   710
    ## 5    de       der_spiegel 2007-12-12   770
    ## 8598 en       die_zeit    2019-09-16   181
    ## 8600 en       die_zeit    2019-09-17   225
    ## 8599 de       der_spiegel 2019-09-17  1116
    ## 8602 en       die_zeit    2019-09-18   182
    ## 8601 de       der_spiegel 2019-09-18  1014
    ## 
    ## ... 8592 rows of data not shown

*having another look …*

``` r
plot(
  trend_data[trend_data$views < 2500, ]
)
```

![](README_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->
