% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/videos.R
\name{live_videos}
\alias{live_videos}
\title{Get videos}
\usage{
live_videos(event.id = NULL, newer = 0, older = 25, offset = NULL,
  account.id = NULL, key = NULL)
}
\arguments{
\item{event.id}{optional, if passed here overrides \code{\link{live_setup}}.}

\item{older, newer}{the number of posts to return older or newer than \code{offset}.
The maximum value of these parameters is limited to \code{25}.}

\item{offset}{offset id.}

\item{account.id}{optional, if passed here overrides \code{\link{live_setup}}.}

\item{key}{your API key, optional, if passed overrides \code{\link{live_setup}}.}
}
\value{
a \code{list}, see \href{official documentation}{https://livestream.com/developers/docs/api/#video-object}.
}
\description{
Get videos of particular event.
}
\examples{
\dontrun{
# setup account id
# to remove need to pass in subsequent calls
live_setup(
  key = "Xxx0xX0X0x0X0x", # your API token
  account.id = 123456
)

past_events <- live_past_events()

# random event
id <- past_events[sample(nrow(past_events), 1), "id"]
videos <- live_videos(id)
}

}
