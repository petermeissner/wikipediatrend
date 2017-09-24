#' simple plot function for objects of class wp_df
#' 
#' @method plot wp_df
#' 
#' @param x object of class wp_df to be plotted
#' @param ... other parameter
#' 
#' @export
#' 
#' @import ggplot2 
#' 
plot.wp_df <- function(x, ...){
  
  # make label for data series
  if( length(unique(x$language)) > 1 ){
    x$label <- glue::glue("({x$language}) {x$article}")
  }else{
    x$label <- x$article
  }
  
  # make plot
  ggplot(
    x, 
    mapping = 
      aes_string( 
        x     = "date",
        y     = "views", 
        group = "label", 
        color = "label"
      )
    ) + 
    geom_point() +
    geom_smooth(se = FALSE, method = "loess") + 
    theme_bw()
    
}
