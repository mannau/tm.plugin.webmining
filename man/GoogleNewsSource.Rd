\name{GoogleNewsSource}
\alias{GoogleNewsSource}
\title{Get feed data from Google News Search \url{http://news.google.com/}}
\usage{
GoogleNewsSource(query, params = list(hl = "en", q = query, ie = "utf-8", num
  = 100, output = "rss"), ...)
}
\arguments{
  \item{query}{Google News Search query}

  \item{params,}{additional query parameters}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
Google News Search is one of the most popular news
aggregators on the web. News can be retrieved for any
customized user query. Up to 100 can be retrieved per
request.
}
\examples{
\dontrun{
corpus <- Corpus(GoogleNewsSource("Microsoft"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

