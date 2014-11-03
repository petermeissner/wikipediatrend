# Wikipedia Article Access Statistics
Peter Meißner  
Friday, October 31, 2014  

## Introduction

On Wikipedia there are a lot of information to be explored behind the scenes. One type of information are page access statistics -- e.g. http://stats.grok.se/en/201409/Peter_Principle. Another type are the info pages -- e.g. https://en.wikipedia.org/w/index.php?title=Peter_Principle&action=info. While the latter falls into the jurisdiction of the [MediaWiki](http://cran.r-project.org/web/packages/WikipediR/index.html)-package for the former no ready made package exists. 

## Stats.grok.se API and the wikipediatrend package

`http://stats.grok.se` provides an Web API to retreive Wikipedia page access statistics on a daily basis. The information is either presented in HTML or provided as JSON data. 

```
http://stats.grok.se/en/201409/Peter_Principle
```
versus
```
http://stats.grok.se/json/en/201409/Peter_Principle
```

A single request results in data for a certain page, from one of Wikipedia's different language subdomains, and for all days of a given month. The `wikipediatrend` package draws on this Web API and provides a consistent and convenient way to use those data within R. Fruthermore the package not only takes care of the communication between the Web API on `stats.grok.se` and your local R session but also allows for minimizing traffic and workload on behalf of the `stats.grok.se`-server by having a build in storage and reuse system of already used data -- data is (if user decides so) saved locally in CSV format and reused for subsequent requests. 



## A First Tutorial


```r
require(wikipediatrend)
```

```
## Loading required package: wikipediatrend
```

The workhorse of the package is the `wp_trend()` function with several arguments:

- **page**        [ `"Peter_principle"` ]: <br>
... here goes the name of the page
- **from**        [ `Sys.Date()-30` ]: <br>
... starting date of the timespan to be considered
- **to**          [ `Sys.Date()` ]: <br>
... end date of the timespan to be considered
- **lang**        [ `"en"` ]: <br>
... language of the page
- **friendly**    [ `F` ]: <br>
... should `wp_trend()` try minimize workload on behalf of `stats.grok.se`
- **requestFrom** [ `"anonymous"` ]: <br>
... do you care to identify yourself towards `stats.grok.se`


Let's have a first run using the defaults:

```r
peter_principle <- wp_trend()
```

```
## 
##     With option 'friendly' set to FALSE subsequent requests 
##     of the same wikipedia-page cause the server -- which is kindly 
##     providing information for you -- to work hard to get the same 
##     stuff over and over and over and over again. Do not bore 
##     the server - be friendly. 
##     
##     More information is found via '?wp_trend'.
##     
## http://stats.grok.se/json/en/201410/Peter_principle
```

The function informs us that using the friendly option might be a good idea and shows us which URLs it used to retreive the inforamtion we were asking for. 

The function's return is a data frame with two variables *date* and *count*:


```r
dim(peter_principle)
```

```
## [1] 30  2
```

```r
class(peter_principle)
```

```
## [1] "data.frame"
```

```r
head(peter_principle)
```

```
##                  date count
## 2014-10-01 2014-10-01  1892
## 2014-10-02 2014-10-02  1974
## 2014-10-03 2014-10-03  1638
## 2014-10-04 2014-10-04   800
## 2014-10-05 2014-10-05   826
## 2014-10-06 2014-10-06  1272
```

... that e.g. can be used directly for visualization. Using `wp_wday()` we can furthermore descriminate weekdays <span style="color:black">(black)</span> from weekends <span style="color:red">(red)</span>. 


```r
plot( peter_principle, 
      col=ifelse( wp_wday(peter_principle$date) > 5 , "red", "black") ,
      ylim=c(0, max(peter_principle$count)),
      main="Peter Principle's Wikipedia Attention",
      ylab="views per day", xlab="time")
lines(peter_principle)
```

![](./Readme_files/figure-html/unnamed-chunk-4-1.png) 

Looking at the graph we can conclude that the *Peter Principle* as a work related phenomenon obviously is something that is most pressing on workdays.


## Being friendly

One of the most important features of the package is its `friendly` option. On the one hand it saves us time when making subsequent requests of the same page because less pages have to be loeaded. On the other hand it serves to minimize workload on behalf of the `stats.grok.se`-server that kindly provides the information we are using. 

The option can be set to different values: 

- **FALSE**, the default, deactivates `wp_trend()`'s friendly behaviour alltogether
- **TRUE**, activates `wp_trend()`'s friendly behaviour and retreieved access statistics are stored on disk in CSV format via `write.csv()`
- **1** is the same as **TRUE**
- **2**, is the same as **TRUE** but storage takes place via `write.csv2()`





## So what? 

### Cats

First of all we are now able to study cats:


```r
cats <- wp_trend("Cat", from="2010-01-01", friendly=T)
```

```
## http://stats.grok.se/json/en/201411/Cat
## 
## Results written to:
## D:/Peter/Dropbox/RPackages/wikipediatrend/wp__Cat__en.csv
```

```r
  # throw out extreme values
  no_outlier <- 
  cats$count < 
    quantile(cats$count, na.rm=T, 0.99) & 
  cats$count > 
    quantile(cats$count, na.rm=T, 0.01)  
cats <- cats[no_outlier,]
plot( cats, 
      col=ifelse( wp_wday(cats$date) > 5 , "red", "black") ,
      ylim=c(0, max(cats$count)),
      main="Cats' Wikipedia Attention",
      ylab="views per day", xlab="time")
lines(cats)
```

![](./Readme_files/figure-html/unnamed-chunk-5-1.png) 

... and can triumphantly can conclude that cats are sooooo early 2010's.

### Ebola


```r
ebola_en1 <- wp_trend("Ebola", from="2008-01-01", friendly=T)
```

```
## http://stats.grok.se/json/en/200801/Ebola
## http://stats.grok.se/json/en/200807/Ebola
## http://stats.grok.se/json/en/201411/Ebola
## 
## Results written to:
## D:/Peter/Dropbox/RPackages/wikipediatrend/wp__Ebola__en.csv
```

```r
plot( ebola_en1, 
      ylim=c(0, max(ebola_en1$count)),
      main="Ebola's Wikipedia Attention",
      ylab="views per day", xlab="time",
      type="l")
lines(ebola_en1)
```

![](./Readme_files/figure-html/unnamed-chunk-6-1.png) 



```r
ebola_en2 <- wp_trend("Ebola_virus_disease", from="2008-01-01", friendly=T)
```

```
## http://stats.grok.se/json/en/200801/Ebola_virus_disease
## http://stats.grok.se/json/en/200807/Ebola_virus_disease
## http://stats.grok.se/json/en/201411/Ebola_virus_disease
## 
## Results written to:
## D:/Peter/Dropbox/RPackages/wikipediatrend/wp__Ebola_virus_disease__en.csv
```

```r
ebola_de1 <- wp_trend("Ebola", lang="de", from="2008-01-01", friendly=T)
```

```
## http://stats.grok.se/json/de/200801/Ebola
## http://stats.grok.se/json/de/200807/Ebola
## http://stats.grok.se/json/de/201411/Ebola
## 
## Results written to:
## D:/Peter/Dropbox/RPackages/wikipediatrend/wp__Ebola__de.csv
```

```r
ebola_de2 <- wp_trend("Ebolafieber", lang="de", from="2008-01-01", friendly=T)
```

```
## http://stats.grok.se/json/de/200801/Ebolafieber
## http://stats.grok.se/json/de/200807/Ebolafieber
## http://stats.grok.se/json/de/201411/Ebolafieber
## 
## Results written to:
## D:/Peter/Dropbox/RPackages/wikipediatrend/wp__Ebolafieber__de.csv
```











