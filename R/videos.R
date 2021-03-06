#' Get videos
#'
#' Get videos of particular event.
#'
#' @param event.id optional, if passed here overrides \code{\link{live_setup}}.
#' @param account.id optional, if passed here overrides \code{\link{live_setup}}.
#' @param offset offset id.
#' @param older,newer the number of posts to return older or newer than \code{offset}.
#'  The maximum value of these parameters is limited to \code{25}.
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#'
#' @examples
#' \dontrun{
#' # setup account id
#' # to remove need to pass in subsequent calls
#' live_setup(
#'   key = "Xxx0xX0X0x0X0x", # your API token
#'   account.id = 123456
#' )
#'
#' past_events <- live_past_events()
#'
#' # random event
#' id <- past_events[sample(nrow(past_events), 1), "id"]
#' videos <- live_videos(id)
#' }
#'
#' @return a \code{list}, see \href{official documentation}{https://livestream.com/developers/docs/api/#video-object}.
#'
#' @export
live_videos <- function(event.id = NULL, newer = 0, older = 25, offset = NULL, account.id = NULL, key = NULL){

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/",
                get_accountid(account.id), "/events/",
                get_eventid(event.id), "/videos")
  uri <- httr::parse_url(uri)
  uri$query <- list(
    newer = newer,
    older = older,
    offsetPostId = offset
  )

  uri <- httr::build_url(uri) # build url

  # call API
  response <- call_api(uri, key)
  content <- httr::content(response)

  parse_content(content)

}
