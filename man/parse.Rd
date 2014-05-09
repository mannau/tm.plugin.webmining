\name{parse}
\alias{parse}
\title{Wrapper/Convenience function to ensure right encoding for different Platforms}
\usage{
parse(..., asText = TRUE, type = c("XML", "HTML", "JSON"))
}
\arguments{
  \item{...}{arguments to be passed to specified parser
  function}

  \item{asText}{defines if input should be treated as
  text/character, default to TRUE}

  \item{type}{either "XML", "HTML" or "JSON". Defaults to
  "XML"}
}
\description{
Depending on specified type one of the following parser
functions is called: \describe{
\item{XML}{\code{\link{xmlInternalTreeParse}}}
\item{HTML}{\code{\link{htmlTreeParse}}}
\item{JSON}{\code{\link{fromJSON}}} }
}

