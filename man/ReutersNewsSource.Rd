\name{ReutersNewsSource}
\alias{ReutersNewsSource}
\alias{readReutersNews}
\title{Get feed data from Reuters News RSS feed channels. Reuters provides numerous feed}
\usage{
ReutersNewsSource(query = "businessNews", ...)
}
\arguments{
  \item{query}{Reuters News RSS Feed, see
  \url{http://www.reuters.com/tools/rss} for a list of all
  feeds provided. Note that only string after
  'http://feeds.reuters.com/reuters/' must be given.
  Defaults to 'businessNews'.}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
channels (\url{http://www.reuters.com/tools/rss}) which can
be retrieved through RSS feeds. Only up to 25 items can be
retrieved---therefore an alternative retrieval through the
Google Reader API (\code{link{GoogleReaderSource}}) could
be considered.
}
\examples{
\dontrun{
corpus <- Corpus(ReutersNewsSource("businessNews"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

