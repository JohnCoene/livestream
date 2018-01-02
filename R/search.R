#' Search livestream
#'
#' Search live stream
#'
#' @param q query string.
#' @param from,to date range, optional.
#' @param tags a vector of event tag strings.
#' @param key your API key, optional, if passed overrides \code{\link{live_setup}}.
#' @param account.id defaults to all linked accounts unless an owned or linked account ID is specified.
#' @param quiet Whether to print information about calls in the console.
#'
#' @return a list of public and private events for all associated accounts (owned and linked) matched on query,
#' filters, and/or tags unless requested with a particular account ID. The response returns events in descending score
#' order based on our \href{ranking logic}{https://livestreamapis.com/apidocs/v3/#ranking}.
#' Tags can be added for each Event inside Livestream.com. We recommend using tags to easily search based on your
#' own custom categories or identifiers.
#'
#' @examples
#' \dontrun{
#' live_setup(key = "Xxx0xX0X0x0X0x") # setup key
#'
#' results <- live_search(q = "Davos")
#' }
#'
#' @export
live_search <- function(q, from = NULL, to = NULL, tags = NULL, account.id = NULL, key = NULL, quiet = !interactive()){

  if(missing(q))
    stop("must pass q", call. = FALSE)

  # build query
  uri <- paste0(getOption("livestream_base_url"), "search")
  uri <- httr::parse_url(uri)
  uri$query <- list(
    q = q,
    maxItems = 50,
    tags = tags,
    accountId = account.id
  )

  uri <- httr::build_url(uri)

  if(!is.null(from))
    uri$query$from <- format(from, "%Y-%m-%dT%H:%M:%S%z", tz = "UTC")

  if(!is.null(to))
    uri$query$to <- format(to, "%Y-%m-%dT%H:%M:%S%z", tz = "UTC")

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
