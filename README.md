
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

*lines of R code:* 474, *lines of test code:* 160

**Version**

2.1.6 ( 2020-06-03 12:43:18 )

**Description**

**License**

GPL (\>= 2) <br>Peter Meissner \[aut, cre\], R Core Team \[cph\]

**Credits**

  - Parts of the package’s code have been shamelessly copied and
    modified from R base package written by R core team. This concerns
    the `wp_date()` generic and its methods and is detailed in the help
    files.

**Citation**

``` r
citation("wikipediatrend")
```

Meissner P (2020). *wikipediatrend: Public Subject Attention via
Wikipedia Page View Statistics*. R package version 2.1.6.

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
    ##       * was prepared in a project commissioned by the Hertie School of Governance (Prof. Dr. Simon Munzert)
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
    ## 9114 en       die_zeit    2020-05-31   209
    ## 9116 en       die_zeit    2020-06-01   174
    ## 9115 de       der_spiegel 2020-06-01  1498
    ## 9118 en       die_zeit    2020-06-02   208
    ## 9117 de       der_spiegel 2020-06-02  1252
    ## 
    ## ... 9108 rows of data not shown

*having another look …*

``` r
plot(
  trend_data[trend_data$views < 2500, ]
)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](man/figures/README-unnamed-chunk-17-1.png)<!-- -->

**Usage 2**

*getting some data …*

``` r
trend_data <- 
  wp_trend(
    page = 
      c(
        "Climate_crisis", 
        "2019–20_coronavirus_pandemic",
        "Donald_Trump",
        "Syria",
        "Crimea",
        "Influenza"
      ), 
    lang = "en", 
    from = "2007-01-01",
    to   = Sys.Date()
  )
```

    ## Warning in wpd_get_exact(page = page, lang = lang, from = from, to = to, : Unable to retrieve data for url:
    ## http://petermeissner.de:8880/article/exact/en/2019–20_coronavirus_pandemic. Status: error.

*having a look …*

``` r
trend_data
```

    ##       language article        date       views  
    ## 1     en       climate_crisis 2007-12-10       0
    ## 2     en       crimea         2007-12-10    1051
    ## 5     en       syria          2007-12-10    3205
    ## 4     en       influenza      2007-12-10    4153
    ## 3     en       donald_trump   2007-12-10    5050
    ## 22723 en       climate_crisis 2020-06-02     103
    ## 22726 en       influenza      2020-06-02    3437
    ## 22724 en       crimea         2020-06-02    3681
    ## 22727 en       syria          2020-06-02    4969
    ## 22725 en       donald_trump   2020-06-02  916742
    ## 
    ## ... 22717 rows of data not shown

*having another look …*

``` r
options(scipen = 1000000)

plot(trend_data) + 
  ggplot2::scale_y_log10()
```

    ## Warning: Transformation introduced infinite values in continuous y-axis
    
    ## Warning: Transformation introduced infinite values in continuous y-axis

    ## `geom_smooth()` using formula 'y ~ x'

    ## Warning: Removed 1202 rows containing non-finite values (stat_smooth).

![](man/figures/README-unnamed-chunk-20-1.png)<!-- -->
