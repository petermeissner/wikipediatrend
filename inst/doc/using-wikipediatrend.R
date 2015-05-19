## ---- eval=FALSE---------------------------------------------------------
#  install.packages("wikipediatrend")

## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github("petermeissner/wikipediatrend")

## ------------------------------------------------------------------------
library(wikipediatrend)

## ------------------------------------------------------------------------
page_views <- wp_trend("main_page")
page_views

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count)) + 
  geom_line(size=1.5, colour="steelblue") + 
  geom_smooth(method="loess", colour="#00000000", fill="#001090", alpha=0.1) +
  scale_y_continuous( breaks=c(10e6, 15e6, 20e6), 
                      label=c("10 M","15 M","20 M")) +
  theme_bw()

## ------------------------------------------------------------------------
page_views <- wp_trend( page = c( "Millennium_Development_Goals",
                                  "Climate_Change") )

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count, group=page, color=page)) + 
  geom_line(size=1.5) + theme_bw()

## ------------------------------------------------------------------------
page_views <- wp_trend( 
                page = "Millennium_Development_Goals" ,
                from = "2000-01-01",
                to   = prev_month_end())

## ---- warning=FALSE------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count, color=wp_year(date))) + 
  geom_line() + 
  stat_smooth(method = "lm", formula = y ~ poly(x, 22), color="#CD0000a0", size=1.2) +
  theme_bw() 

## ------------------------------------------------------------------------
page_views <- wp_trend( 
                page = c("Objetivos_de_Desarrollo_del_Milenio",
                         "Millennium_Development_Goals") ,
                lang = c("es", "en"),
                from = Sys.Date()-100
              )

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count, group=lang, color=lang, fill=lang)) + 
  geom_smooth(size=1.5) + 
  geom_point() +
  theme_bw() 

## ------------------------------------------------------------------------
wp_cache_file()

## ------------------------------------------------------------------------
cache <- wp_get_cache()
head(cache)
dim(cache)

## ---- eval=FALSE---------------------------------------------------------
#  wp_cache_reset()

## ------------------------------------------------------------------------
# save apth of curent cache file
tmp <- wp_cache_file()

# set cache file 
wp_set_cache_file("My_Other_Cache_File.csv")

wp_cache_file()

wp_get_cache()

# set cache file back
wp_set_cache_file(tmp)

wp_cache_file()

wp_get_cache()

## ------------------------------------------------------------------------
titles <- wp_linked_pages("Islamic_State_of_Iraq_and_the_Levant", "en")
titles <- titles[titles$lang %in% c("en", "de", "es", "ar", "ru"),]
titles 

## ------------------------------------------------------------------------
page_views <- wp_trend(page = titles$page[1:5], 
                       lang = titles$lang[1:5],
                       from = "2014-08-01")

## ------------------------------------------------------------------------
library(ggplot2)

for(i in unique(page_views$lang) ){
  iffer <- page_views$lang==i
  page_views[iffer, ]$count <- scale(page_views[iffer, ]$count)
}

ggplot(page_views, aes(x=date, y=count, group=lang, color=lang)) + 
  geom_line(size=1.2, alpha=0.5) + 
  ylab("standardized count\n(by lang: m=0, var=1)") +
  theme_bw() + 
  scale_colour_brewer(palette="Set1") + 
  guides(colour = guide_legend(override.aes = list(alpha = 1)))

## ------------------------------------------------------------------------
if ( !require(BreakoutDetection) ){    
  devtools::install_github("twitter/BreakoutDetection")
  library(BreakoutDetection)
}
library(dplyr)

## ------------------------------------------------------------------------
if ( !require(AnomalyDetection) ){    
  devtools::install_github("twitter/AnomalyDetection")
  library(AnomalyDetection)
}
library(dplyr)
library(ggplot2)


page_views <- wp_trend("Wikipedia:Pageview_statistics", from = "2012-01-01")

page_views_br <- 
  page_views  %>% 
  select(date, count)  %>% 
  rename(timestamp=date)  %>% 
  unclass()  %>% 
  as.data.frame() %>% 
  mutate(timestamp = as.POSIXct(timestamp))

res <- AnomalyDetectionTs(page_views_br, plot=TRUE, longterm=T)$anoms
res$timestamp <- as.Date(res$timestamp)

ggplot( data=page_views, aes(x=date, y=count) ) + 
  #geom_smooth(color="#4D87B740", fill="#4D87B740") +
  geom_smooth(
    data=filter(page_views, !(page_views$date %in% res$timestamp) ), 
    aes(x=date, y=count), color="#EE000040", fill="#EE000040") +
  geom_point(data=res, aes(x=timestamp, y=anoms),color="red2",size=3) +
  theme_bw() + stat_smooth(level=1-1e-15)




