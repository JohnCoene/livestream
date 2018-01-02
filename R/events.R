#' Get past events
#'
#' Get information on past events.
#'
#' @param account.id your account id, can be setup via \code{\link{live_setup}}.
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#' @param quiet Whether to print information about calls in the console.
#' @param event.id optional, if passed here overrides \code{\link{live_setup}}.
#'
#' @examples
#' \dontrun{
#' # setup account id
#' # to remove need to pass in subsequent calls
#' live_setup(
#'   key = "Xxx0xX0X0x0X0x", # your API token
#'   account.id = 1909571 # Forum id
#' )
#'
#' past_events <- live_past_events()
#' event <- live_event(sample(past_events$id, 1))
#' }
#'
#' @rdname events
#' @export
live_past_events <- function(account.id = NULL, key = NULL, quiet = !interactive()){

  get_events(account.id, key, quiet, "past_events")

}

#' @rdname events
#' @export
live_upcoming_events <- function(account.id = NULL, key = NULL, quiet = !interactive()){

  get_events(account.id, key, quiet, "upcoming_events")

}

#' @rdname events
#' @export
live_draft_events <- function(account.id = NULL, key = NULL, quiet = !interactive()){

  get_events(account.id, key, quiet, "draft_events")

}

#' @rdname events
#' @export
live_private_events <- function(account.id = NULL, key = NULL, quiet = !interactive()){

  get_events(account.id, key, quiet, "private_events")

}

#' @rdname events
#' @export
live_event <- function(event.id, account.id = NULL, key = NULL){

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/", get_accountid(account.id), "/events/", get_eventid(event.id))
  uri <- httr::parse_url(uri)
  uri <- httr::build_url(uri)

  # call API
  response <- call_api(uri, key)
  content <- httr::content(response)

  parse_content(content)

}
