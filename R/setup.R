#' Setup
#'
#' @param key your API key.
#'
#' @examples
#' \dontrun{
#' live_setup(key = "Xxx0xX0X0x0X0x")
#' }
#'
#' @export
live_setup <- function(key){
  options(livestream_api_key = key)
}
