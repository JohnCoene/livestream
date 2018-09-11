#' Get videos
#'
#' Get videos of particular event.
#'
#' @param video.id id of video to download.
#' @param event.id optional, if passed here overrides \code{\link{live_setup}}.
#' @param account.id optional, if passed here overrides \code{\link{live_setup}}.
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#'
#' @examples
#' \dontrun{
#' # setup account id
#' # to remove need to pass in subsequent calls
#' live_setup(
#'   key = "Xxx0xX0X0x0X0x", # your API token
#'   account.id = 1234567
#' )
#'
#' past_events <- live_past_events()
#'
#' # random event
#' id <- past_events[sample(nrow(past_events), 1), "id"]
#' videos <- live_videos(id)
#'
#' # get download url of random video
#' download_urls <- live_download(sample(videos$vods$data$data.id, 1))
#' }
#'
#' @return a \code{list}, see \href{official documentation}{https://livestream.com/developers/docs/api/#download-video-urls}.
#' #' @export
live_download <- function(video.id, event.id = NULL, account.id = NULL, key = NULL){

  if(missing(video.id))
    stop("must pass video.id", call. = FALSE)

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/",
                get_accountid(account.id), "/events/",
                get_eventid(event.id), "/videos/",
                video.id, "/download_urls")

  # call API
  response <- call_api(uri, key)
  content <- httr::content(response)

  parse_content(content)

}
