## ---- include=FALSE------------------------------------------------------
library(ggplot2)
update_geom_defaults("line",   list(colour = "steelblue"))

## ---- message=F, eval=FALSE----------------------------------------------
#  install.packages("wikipediatrend")

## ---- message=F, eval=FALSE----------------------------------------------
#  devtools::install_github("petermeissner/wikipediatrend")

## ---- message=F----------------------------------------------------------
library(wikipediatrend)

## ---- message=F----------------------------------------------------------
page_views <- wp_trend("main_page")
page_views

## ---- message=F----------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count)) + 
  geom_line(size=1.5, colour="steelblue") + 
  geom_smooth(method="loess", colour="#00000000", fill="#001090", alpha=0.1) +
  scale_y_continuous( breaks=c(10e6, 15e6, 20e6), 
                      label=c("10 M","15 M","20 M")) +
  theme_bw()

## ---- message=F----------------------------------------------------------
page_views <- wp_trend( page = c( "Millennium_Development_Goals",
                                  "Climate_Change") )

## ---- message=F----------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count, group=page, color=page)) + 
  geom_line(size=1.5) + theme_bw()

## ---- message=F----------------------------------------------------------
page_views <- wp_trend( 
                page = "Millennium_Development_Goals" ,
                from = "2000-01-01",
                to   = prev_month_end())

## ---- message=F, warning=FALSE-------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count, color=wp_year(date))) + 
  geom_line() + 
  stat_smooth(method = "lm", formula = y ~ poly(x, 22), color="#CD0000a0", size=1.2) +
  theme_bw() 

## ---- message=F----------------------------------------------------------
page_views <- wp_trend( 
                page = c("Objetivos_de_Desarrollo_del_Milenio",
                         "Millennium_Development_Goals") ,
                lang = c("es", "en"),
                from = Sys.Date()-100
              )

## ---- message=F----------------------------------------------------------
library(ggplot2)
ggplot(page_views, aes(x=date, y=count, group=lang, color=lang, fill=lang)) + 
  geom_smooth(size=1.5) + 
  geom_point() +
  theme_bw() 

## ---- message=F----------------------------------------------------------
wp_cache_file()

## ---- message=F----------------------------------------------------------
cache <- wp_get_cache()
head(cache)
dim(cache)

## ---- message=F, eval=FALSE----------------------------------------------
#  wp_cache_reset()

## ---- message=F----------------------------------------------------------
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

## ---- message=F----------------------------------------------------------
titles <- wp_linked_pages("Islamic_State_of_Iraq_and_the_Levant", "en")
titles <- titles[titles$lang %in% c("en", "de", "es", "ar", "ru"),]
titles 

## ---- message=F----------------------------------------------------------
page_views <- wp_trend(page = titles$page[1:5], 
                       lang = titles$lang[1:5],
                       from = "2014-08-01")

## ---- message=F----------------------------------------------------------
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

## ---- include=F----------------------------------------------------------
if ( !require(AnomalyDetection) ){    
  devtools::install_github("twitter/AnomalyDetection")
  library(AnomalyDetection)
}
library(dplyr)
library(ggplot2)

## ---- eval=FALSE---------------------------------------------------------
#  devtools::install_github("twitter/AnomalyDetection")
#  library(AnomalyDetection)
#  library(dplyr)
#  library(ggplot2)

