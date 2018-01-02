#' Get Account information
#'
#' Collect information aboutr your account.
#'
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#'
#' @examples
#' \dontrun{
#' live_setup(key = "Xxx0xX0X0x0X0x") # setup key
#'
#' account <- live_account()
#' }
#'
#' @export
live_account <- function(key = NULL){

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts")

  # call api
  response <- call_api(uri, key)
  content <- httr::content(response, as = "text", encoding = "UTF-8")
  parse_content(content)
}
