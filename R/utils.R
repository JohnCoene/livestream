#' check passed key against setup
get_key <- function(key){
  if(is.null(getOption("livestream_api_key")) && is.null(key))
    stop("pass key or use live_setup", call. = FALSE)

  if(!is.null(key)){
    return(key)
  } else {
    getOption("livestream_api_key")
  }
}

#' call api
call_api <- function(uri, key){

  key <- get_key(key)

  req <- httr::GET(uri, httr::authenticate(key, "", type = "basic"))
  httr::stop_for_status(req)
}

parse_content <- function(x){
  x <- jsonlite::toJSON(x, auto_unbox = T)
  jsonlite::fromJSON(x, flatten = TRUE)
}
