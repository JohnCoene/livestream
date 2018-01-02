#' check passed key against setup
#' @keywords internal
get_key <- function(key){
  if(is.null(getOption("livestream_api_key")) && is.null(key))
    stop("pass key or use live_setup", call. = FALSE)

  if(!is.null(key)){
    return(key)
  } else {
    getOption("livestream_api_key")
  }
}

#' check passed key against setup
#' @keywords internal
get_accountid <- function(id){
  if(is.null(getOption("livestream_account_id")) && is.null(id))
    stop("pass id or use live_setup", call. = FALSE)

  if(!is.null(id)){
    return(id)
  } else {
    getOption("livestream_account_id")
  }
}

#' check passed key against setup
#' @keywords internal
get_eventid <- function(id){
  if(is.null(getOption("livestream_event_id")) && is.null(id))
    stop("pass id or use live_setup", call. = FALSE)

  if(!is.null(id)){
    return(id)
  } else {
    getOption("livestream_event_id")
  }
}

#' call api
#' @keywords internal
call_api <- function(uri, key){

  key <- get_key(key)

  req <- httr::GET(uri, httr::authenticate(key, "", type = "basic"))
  httr::stop_for_status(req)
}

#' @keywords internal
parse_content <- function(x){
  x <- jsonlite::toJSON(x, auto_unbox = T)
  jsonlite::fromJSON(x, flatten = TRUE)
}

#' @keywords internal
get_events <- function(account.id = NULL, key = NULL, quiet = !interactive(), which = "past_events"){
  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/", get_accountid(account.id), "/", which)
  uri <- httr::parse_url(uri)
  uri$query <- list(
    maxItems = 50
  )

  uri <- httr::build_url(uri) # build url

  # call API
  response <- call_api(uri, key)
  content <- httr::content(response)

  # compute number of pages
  rez <- content$total
  pages <- ceiling(rez / 50)

  # just save data
  content <- content$data

  # paginate
  if(pages > 1){

    if(!isTRUE(quiet))
      message(pages, " pages for ", rez, " results")

    for(i in 2:pages){

      urip <- paste0(uri, "&page=", i)
      responsep <- call_api(urip, key)
      contentp <- httr::content(responsep)
      content <- append(content, contentp$data)
    }
  }

  # parse
  parse_content(content)
}

#' @keywords internal
get_feed <- function(event.id, newer = NULL, older = NULL, offset.id = NULL, offset.type = NULL,
                     account.id = NULL, key = NULL, which = "feed"){
  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/",
                get_accountid(account.id), "/events/", get_eventid(event.id), "/", which)
  uri <- httr::parse_url(uri)
  uri$query <- list(
    newer = newer,
    older = older,
    offsetPostId = offset.id,
    offsetPostType = offset.type
  )

  uri <- httr::build_url(uri) # build url

  # call API
  response <- call_api(uri, key)
  content <- httr::content(response)

  parse_content(content$data)
}

#' @keywords internal
img_embed <- function(x){
  paste0(
    "<a href='", x, "' target='_blank'><img style='max-height:50px;' src='", x, "' /></a>"
  )
}
