#' Get Account information
#'
#' Collect information about an account.
#'
#' @param id account id.
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#'
#' @examples
#' \dontrun{
#' live_setup(key = "Xxx0xX0X0x0X0x") # setup key
#'
#' account <- live_account()
#' }
#'
#' @rdname account
#' @export
live_account <- function(key = NULL){

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts")

  # call api
  response <- call_api(uri, key)
  content <- httr::content(response)
  parse_content(content)
}

#' @rdname account
#' @export
live_account_id <- function(id, key = NULL){

  if(missing(id))
    stop("must pass id", call. = FALSE)

  # build query
  uri <- paste0(getOption("livestream_base_url"), "accounts/", get_accountid(id))

  # call api
  response <- call_api(uri, key)
  content <- httr::content(response)
  parse_content(content)
}
