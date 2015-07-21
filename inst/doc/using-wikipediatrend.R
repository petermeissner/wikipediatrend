## ----general options, include=FALSE--------------------------------------
  # default line color in ggplot graphics
    library(ggplot2)
    update_geom_defaults("line",   list(colour = "steelblue"))
  
  # use cache coming with package to make vignette build by magnitudes faster 
  # there still we be some downloads of data so that building the vignette should imply 
  # that reproducing the vignette by user is possible
    library(wikipediatrend)
    wp_cache_load(
      system.file(
        "extdata", 
        "wikipediatrend_cache.csv", 
        package = "wikipediatrend"
      )
    )

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
  scale_y_continuous( breaks=seq(5e6, 50e6, 5e6) , 
  label= paste(seq(5,50,5),"M") ) +
  theme_bw()

## ---- message=F----------------------------------------------------------
page_views <- 
  wp_trend( 
    page = c( "Millennium_Development_Goals", "Climate_Change") 
  )

## ---- message=F----------------------------------------------------------
library(ggplot2)

ggplot(page_views, aes(x=date, y=count, group=page, color=page)) + 
  geom_line(size=1.5) + theme_bw()

## ---- message=F----------------------------------------------------------
page_views <- 
  wp_trend( 
    page = "Millennium_Development_Goals" ,
    from = "2000-01-01",
    to   = prev_month_end()
  )

## ---- message=F, warning=FALSE-------------------------------------------
library(ggplot2)

ggplot(page_views, aes(x=date, y=count, color=wp_year(date))) + 
  geom_line() + 
  stat_smooth(method = "lm", formula = y ~ poly(x, 22), color="#CD0000a0", size=1.2) +
  theme_bw() 

## ---- message=F----------------------------------------------------------
page_views <- 
  wp_trend( 
    page = c("Objetivos_de_Desarrollo_del_Milenio", "Millennium_Development_Goals") ,
    lang = c("es", "en"),
    from = Sys.Date()-100
  )

## ---- message=F----------------------------------------------------------
library(ggplot2)

ggplot(page_views, aes(x=date, y=count, group=lang, color=lang, fill=lang)) + 
  geom_smooth(size=1.5) + 
  geom_point() +
  theme_bw() 

## ---- message=FALSE------------------------------------------------------
wp_trend("Cheese", file="cheeeeese.csv")
wp_trend("K\u00e4se", lang="de", file="cheeeeese.csv")

cheeeeeese <- wp_load( file="cheeeeese.csv" )
cheeeeeese

## ---- include=FALSE------------------------------------------------------
file.remove("cheeeeese.csv")

## ------------------------------------------------------------------------
wp_trend("Cheese")
wp_trend("Cheese")

## ------------------------------------------------------------------------
wp_trend("Cheese", from = Sys.Date()-60)

## ------------------------------------------------------------------------
wp_get_cache()

## ---- eval=FALSE---------------------------------------------------------
#  wp_set_cache_file( file = "myCache.csv" )

## ---- eval=FALSE---------------------------------------------------------
#  wp_set_cache_file( Sys.getenv("WP_CACHE_FILE") )

## ---- message=F----------------------------------------------------------
titles <- wp_linked_pages("Islamic_State_of_Iraq_and_the_Levant", "en")
titles <- titles[titles$lang %in% c("de", "es", "ar", "ru","zh-min-nan"),]
titles 

## ---- message=F----------------------------------------------------------
page_views <- 
  wp_trend(
    page = titles$page, 
    lang = titles$lang,
    from = "2014-08-01"
  )

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

## ------------------------------------------------------------------------
RUN_IT <- require(AnomalyDetection) & require(BreakoutDetection) & F

## ---- eval=RUN_IT--------------------------------------------------------
#  # install.packages( "AnomalyDetection", repos="http://ghrr.github.io/drat",  type="source")
#  library(AnomalyDetection)
#  library(dplyr)
#  library(ggplot2)

## ---- eval=RUN_IT--------------------------------------------------------
#  page_views <- wp_trend("Syria", from = "2010-01-01")
#  
#  page_views_br <-
#    page_views  %>%
#    select(date, count)  %>%
#    rename(timestamp=date)  %>%
#    unclass()  %>%
#    as.data.frame() %>%
#    mutate(timestamp = as.POSIXct(timestamp))

## ---- eval=RUN_IT--------------------------------------------------------
#  res <-
#  AnomalyDetectionTs(
#    x         = page_views_br,
#    alpha     = 0.05,
#    max_anoms = 0.40,
#    direction = "both",
#    longterm  = T
#  )$anoms
#  
#  res$timestamp <- as.Date(res$timestamp)
#  
#  head(res)

## ---- eval=RUN_IT--------------------------------------------------------
#  page_views <-
#    page_views  %>%
#    mutate(normal = !(page_views$date %in% res$timestamp))  %>%
#    mutate(anom   =   page_views$date %in% res$timestamp )
#  
#  class(page_views) <- c("wp_df", "data.frame")

## ---- message=FALSE, eval=RUN_IT-----------------------------------------
#  (
#    p <-
#      ggplot( data=page_views, aes(x=date, y=count) ) +
#        geom_line(color="steelblue") +
#        geom_point(data=filter(page_views, anom==T), color="red2", size=2) +
#        theme_bw()
#  )

## ---- message=FALSE, eval=RUN_IT-----------------------------------------
#  p +
#    geom_line(stat = "smooth", size=2, color="red2", alpha=0.7) +
#    geom_line(data=filter(page_views, anom==F),
#    stat = "smooth", size=2, color="dodgerblue4", alpha=0.5)

## ---- eval=RUN_IT--------------------------------------------------------
#  page_views_clean <-
#    page_views  %>%
#    filter(anom==F)  %>%
#    select(date, count, lang, page, rank, month, title)
#  
#  page_views_br_clean <-
#    page_views_br  %>%
#    filter(page_views$anom==F)

## ---- eval=RUN_IT--------------------------------------------------------
#  # install.packages(  "BreakoutDetection",   repos="http://ghrr.github.io/drat", type="source")
#  library(BreakoutDetection)
#  library(dplyr)
#  library(ggplot2)
#  library(magrittr)

## ---- eval=RUN_IT--------------------------------------------------------
#  br <-
#    breakout(
#      page_views_br_clean,
#      min.size = 30,
#      method   = 'multi',
#      percent  = 0.05,
#      plot     = TRUE
#    )
#  br

## ---- eval=RUN_IT--------------------------------------------------------
#  breaks <- page_views_clean[br$loc,]
#  breaks
#  

## ---- eval=RUN_IT--------------------------------------------------------
#  page_views_clean$span <- 0
#  for (d in breaks$date ) {
#    page_views_clean$span[ page_views_clean$date > d ] %<>% add(1)
#  }
#  
#  page_views_clean$mcount <- 0
#  for (s in unique(page_views_clean$span) ) {
#    iffer <- page_views_clean$span == s
#  page_views_clean$mcount[ iffer ] <- mean(page_views_clean$count[iffer])
#  }
#  
#  spans <-
#    page_views_clean  %>%
#    as_data_frame() %>%
#    group_by(span) %>%
#    summarize(
#      start      = min(date),
#      end        = max(date),
#      length     = end-start,
#      mean_count = round(mean(count)),
#      min_count  = min(count),
#      max_count  = max(count),
#      var_count  = var(count)
#    )
#  spans

## ---- message=FALSE, eval=RUN_IT-----------------------------------------
#  ggplot(page_views_clean, aes(x=date, y=count) ) +
#    geom_line(alpha=0.5, color="steelblue") +
#    geom_line(aes(y=mcount), alpha=0.5, color="red2", size=1.2) +
#    theme_bw()

