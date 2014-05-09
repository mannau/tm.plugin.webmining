\name{auth.google.reader}
\alias{auth.google.reader}
\title{Authentification and token retrieval from the Google Reader web service}
\usage{
auth.google.reader(email = readline("Email:"),
  password = readline("Password:"), get.curl.opts = F)
}
\arguments{
  \item{email}{email address, e.g.
  <firstname.lastname@gmail.com>}

  \item{password}{password for Google Account}

  \item{get.curl.opts}{determines if RCurl options object
  (\code{\link{curlOptions}}) should be returned.}
}
\value{
Character if get.curl.opts is FALSE or curlOpts if
get.curl.opts is TRUE
}
\description{
Function to retrieve token string for the Google Reader web
service. String can subsequently be used with
\code{\link{GoogleReaderSource}}
}
\seealso{
\code{\link{GoogleReaderSource}}
}

