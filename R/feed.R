#' Get feed items
#'
#' Get feed items.
#'
#' @param id id of object to retrieve.
#' @param event.id optional, if passed here overrides \code{\link{live_setup}}.
#' @param account.id optional, if passed here overrides \code{\link{live_setup}}.
#' @param older,newer the number of posts to return older or newer than \code{offset}.
#' The maximum value of these parameters is limited to \code{25}.
#' @param offset.id the ID of the post returned in the previous call relative to which older or newer posts will be returned.
#' If no value is passed, this endpoint will fetch older posts based on \code{older} parameter value.
#' @param offset.type the type of post returned in the previous call relative to which older or newer posts will be returned.
#' Valid values are \code{status}, \code{image} and \code{video}.
#' This parameter is required if \code{offset.id} paramter is also present.
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#'
#' @examples
#' \dontrun{
#' # setup account id
#' # to remove need to pass in subsequent calls
#' live_setup(
#'   key = "Xxx0xX0X0x0X0x", # your API token
#'   account.id = 1234567
#'   event.id = 1234567
#' )
#'
#' feed <- live_feed()
#' }
#'
#' @rdname feed
#' @export
live_feed <- function(event.id = NULL, newer = 0, older = 25, offset.id = NULL, offset.type = NULL, account.id = NULL,
                      key = NULL){

  get_feed(event.id, newer, older, offset.id, offset.type, account.id, key, which = "feed")
}

#' @rdname feed
#' @export
live_status <- function(id, event.id = NULL, account.id = NULL, key = NULL){
    # build query
    uri <- paste0(getOption("livestream_base_url"), "accounts/",
                  get_accountid(account.id), "/events/", get_eventid(event.id), "/statuses/", id)

    # call API
    response <- call_api(uri, key)
    content <- httr::content(response)

    parse_content(content$data)
}

#' @rdname feed
#' @export
live_image <- function(id, event.id = NULL, account.id = NULL, key = NULL){

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/",
                get_accountid(account.id), "/events/", get_eventid(event.id), "/images/", id)

  # call API
  response <- call_api(uri, key)
  content <- httr::content(response)

  parse_content(content$data)
}

#' @rdname feed
#' @export
live_pending <- function(event.id = NULL, account.id = NULL, key = NULL){

  get_feed(event.id = event.id, account.id = account.id, key = key, which = "pending_posts")
}
