#' simple plot function for objects of class wp_df
#' 
#' @method plot wp_df
#' 
#' @param x object of class wp_df to be plotted
#' @param ... other parameter
#' 
#' @export
#' 
#' @importFrom graphics lines plot points
#' @importFrom stats lowess
#' 
plot.wp_df <- function(x, ...){
  wp_df <- x
  wp_df <- wp_df[order(wp_df$page, wp_df$lang, wp_df$date), ]
  plot(
    wp_df$date, wp_df$count,
    ylab="pageviews per day", xlab="date",
    ylim=c(floor(min(wp_df$count)), ceiling(max(wp_df$count))),
    pch=19, ..., type = "n"
  )
  wp_df$cat <- paste0(wp_df$title, wp_df$lang)
  for(i in seq_along(unique(wp_df$cat)) ){
    iffer   <- wp_df$cat==unique(wp_df$cat)[i]
    rcb_col <- RColorBrewer::brewer.pal(9, "Set1")[i %% 9 +1]
    points(
      wp_df$date[iffer], wp_df$count[iffer],
      pch=19, col=rcb_col, ...
    )
    lines(
      lowess(wp_df$date[iffer], wp_df$count[iffer]), 
      col=rcb_col
    ) 
  }
}
