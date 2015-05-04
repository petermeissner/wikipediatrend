#' function to convert character vectors to UTF-8 encoding
#'
#' @param x the vector to be converted
#' 

toUTF8 <- 
  function(x){
    worker <- function(x){
      iconv(x, from = Encoding(x), to = "UTF-8")
    }
    unlist(lapply(x, worker))
  }

#' function to write csv files with UTF-8 characters (even under Windwos)
#' @param df data frame to be written to file
#' @param file file name / path where to put the data

write_utf8_csv <- 
function(df, file){
  firstline <- paste(  '"', names(df), '"', sep = "", collapse = " , ")
  char_columns <- seq_along(df[1,])[sapply(df, class)=="character"]
  for( i in  char_columns){
    df[,i] <- toUTF8(df[,i])
  }
  data <- apply(df, 1, function(x){paste('"', x,'"', sep = "",collapse = " , ")})
  writeLines( c(firstline, data), file , useBytes = T)
}


read_utf8_csv <- function(file){
  # reading data from file
  content <- readLines(file, encoding = "UTF-8")
  # extracting data
  content <- stringr::str_split(content, " , ")
  content <- lapply(content, stringr::str_replace_all, '"', "")
  content_names <- content[[1]]
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












