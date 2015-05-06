
#' function to convert character vectors to UTF-8 encoding
#'
#' @param x the vector to be converted
#' @export 

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
#' @export 

write_utf8_csv <- 
function(df, file){
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
#' @param df data frame to be written to file
#' @param file file name / path where to put the data
#' @export 

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












