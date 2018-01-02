#' Setup
#'
#' Setup your session.
#'
#' @param key your API key.
#' @param account.id your account id.
#' @param event.id event id.
#'
#' @examples
#' \dontrun{
#' live_setup(key = "Xxx0xX0X0x0X0x") # setup
#'
#' live_options() # retrieve
#' }
#'
#' @rdname setup
#' @export
live_setup <- function(key = NULL, account.id = NULL, event.id = NULL){
  options(
    livestream_api_key = key,
    livestream_account_id = account.id,
    livestream_event_id = event.id
  )
}

#' @rdname setup
#' @export
live_options <- function(){
  list(
    key = getOption("livestream_api_key"),
    account.id = getOption("livestream_account_id"),
    event.id = getOption("livestream_event_id")
  )
}
