\name{GoogleFinanceSource}
\alias{GoogleFinanceSource}
\alias{readGoogle}
\title{Get feed Meta Data from Google Finance.}
\usage{
GoogleFinanceSource(query, params = list(hl = "en", q = query, ie = "utf-8",
  start = 0, num = 20, output = "rss"), ...)
}
\arguments{
  \item{query}{ticker symbols of companies to be searched
  for, see \url{http://www.google.com/finance}. Please note
  that Google ticker symbols need to be prefixed with the
  exchange name, e.g. NASDAQ:MSFT}

  \item{params}{additional query parameters}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
Google Finance provides business and enterprise headlines
for many companies. Coverage is particularly strong for
US-Markets. However, only up to 20 feed items can be
retrieved.
}
\examples{
\dontrun{
corpus <- Corpus(GoogleFinanceSource("NASDAQ:MSFT"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

