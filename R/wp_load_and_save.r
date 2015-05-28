
#' function to convert character vectors to UTF-8 encoding
#'
#' @param x the vector to be converted


toUTF8 <- 
  function(x){
    worker <- function(x){
      iconv(x, 
            from = ifelse( Encoding(x)=="unknown", "",Encoding(x) ), 
            to = "UTF-8")
    }
    unlist(lapply(x, worker))
  }



#' function to write csv files with UTF-8 characters (even under Windwos)
#' @param df data frame to be written to file
#' @param file file name / path where to put the data


write_utf8_csv <- 
function(df, file){
  if ( is.null(df) ) df <- data.frame()
  firstline <- paste(  '"', names(df), '"', sep = "", collapse = " , ")
  char_columns <- seq_along(df[1,])[sapply(df, class)=="character"]
  for( i in  char_columns){
    df[,i] <- toUTF8(df[,i])
  }
  data <- apply(df, 1, function(x){paste('"', x,'"', sep = "",collapse = " , ")})
  writeLines( text=c(firstline, data), con=file , useBytes = T)
}


#' function to read csv file with UTF-8 characters (even under Windwos) that 
#' were created by write_U
#' @param file file name / path where to get the data


read_utf8_csv <- function(file){
  if ( !file.exists(file) ) return( data.frame() )
  # reading data from file
  content <- readLines(file, encoding = "UTF-8")
  if ( length(content) < 2 ) return( data.frame() )
  # extracting data
  content <- stringr::str_split(content, " , ")
  content <- lapply(content, stringr::str_replace_all, '"', "")
  content_names <- content[[1]][content[[1]]!=""]
  content <- content[seq_along(content)[-1]]  
  # putting it into data.frame
  df <- data.frame(dummy=seq_along(content), stringsAsFactors = F)
  for(name in content_names){
    tmp <- sapply(content, `[[`, dim(df)[2])
    Encoding(tmp) <- "UTF-8"
    df[,name] <- tmp 
  }
  df <- df[,-1]
  # return
  return(df)
}

#' Helper function for wp_trend that loads previous saved wp_trend results
#' 
#' @param file  name of the file from which previous \code{wp_trend()}
#'   results should be loaded 
#' 
#' @export

wp_load <- function(file=wp_cache_file()){
  if ( file.exists(file) ) {
#    dat <- read.csv( file = file,
#                     stringsAsFactors = F, 
#                     fileEncoding = "UTF-8")
    dat      <- read_utf8_csv(file)
    if( any(dim(dat)==0) ){
      dat <- data.frame()
    }
    if( any(dim(dat)[1]>0&dim(dat)[2]>0) ){
      dat$date   <- wp_date(dat$date)
      dat$count  <- as.numeric(dat$count)
    }else{
      dat <- data.frame()
    }
    class(dat) <- c("wp_df","data.frame")
    return(dat)
  }
  # else ...
  dat <- data.frame()  
  class(dat) <- c("wp_df","data.frame")
  return(dat)
}



#' Helper function for wp_trend
#' 
#' Function writes wp_trend() data to a CSV file that serves as cache/storage
#' 
#' @param res data retreived by \code{wp_trend()}
#' @param file where to save/cache results (defaults to \code{wp_cache_file()})
#' @export  
#'   
#' 

wp_save <- function(res, file=wp_cache_file()){
    write_utf8_csv( df = res, file = file)
    #dev# message(paste0(".\n"))
    return( file )
}











