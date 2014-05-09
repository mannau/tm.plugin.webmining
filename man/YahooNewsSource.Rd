\name{YahooNewsSource}
\alias{YahooNewsSource}
\title{Get feed data from Yahoo! News (\url{http://news.yahoo.com/}).}
\usage{
YahooNewsSource(query, params = list(p = query, n = 20, ei = "UTF-8"), ...)
}
\arguments{
  \item{query}{words to be searched in Yahoo News, multiple
  words must be separated by '+'}

  \item{params,}{additional query parameters, see
  \url{http://developer.yahoo.com/rss/}}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
Yahoo! News is a large news aggregator and provides a
customizable RSS feed. Only a maximum of 20 items can be
retrieved.
}
\examples{
\dontrun{
corpus <- Corpus(YahooNewsSource("Microsoft"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

