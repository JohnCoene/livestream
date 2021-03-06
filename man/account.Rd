% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/account.R
\name{live_account}
\alias{live_account}
\alias{live_account_id}
\title{Get Account information}
\usage{
live_account(key = NULL)

live_account_id(id, key = NULL)
}
\arguments{
\item{key}{your API key, optional, if passed overrides \code{\link{live_setup}}.}

\item{id}{account id.}
}
\description{
Collect information about an account.
}
\examples{
\dontrun{
live_setup(key = "Xxx0xX0X0x0X0x") # setup key

(account <- live_account())
}

}
