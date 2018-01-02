#' Get events
#'
#' Get information on events.
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

  which <- which[1]

  if(!which %in% c("past", "upcoming", "draft", "private")){
    stop("wrong which parameter", call. = FALSE)
  }

  if(which == "past"){

  } else if (which == "upcoming"){

  } else if (which == "draft"){

  } else {

  }

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

#' Events gadgets
#'
#' @inheritParams live_past_events
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
#' live_events_gadget()
#' }
#'
#' @export
live_events_gadget <- function(account.id = NULL, key = NULL,
                   which = c("past", "upcoming", "draft", "private")){

  which <- which[1]

  if(!which %in% c("past", "upcoming", "draft", "private"))
    stop("wrong which parameter", call. = FALSE)

  if(which == "past"){
    data <- live_past_events(account.id = NULL, key = NULL)
  } else if (which == "upcoming"){
    data <- live_upcoming_events(account.id = NULL, key = NULL)
  } else if (which == "draft"){
    data <- live_draft_events(account.id = NULL, key = NULL)
  } else {
    data <- live_private_events(account.id = NULL, key = NULL)
  }

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Events"),
    miniUI::miniContentPanel(
      shiny::dataTableOutput("table")
    )
  )

  server <- function(input, output){

    dataTable <- reactive({
      data <- data[, c("id", "fullName", "viewerCount", "logo.url")]
      data$logo.url <- img_embed(data$logo.url)
      data
    })

    output$table <- shiny::renderDataTable({
      dataTable()
    }, escape = FALSE)
  }

  shiny::runGadget(ui, server)
}
