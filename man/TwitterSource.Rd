\name{TwitterSource}
\alias{TwitterSource}
\alias{readTwitter}
\title{Get feed data from Twitter Search API (\url{https://dev.twitter.com/docs/api/1/get/search}).}
\usage{
TwitterSource(query, n = 1500, params = list(lang = "en"), ...)
}
\arguments{
  \item{query}{Google Blog Search query}

  \item{n}{number of results, defaults to 1500}

  \item{params,}{additional query parameters, see
  \url{http://search.twitter.com/api/}}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
The microblogging and social networking service twitter
provides text based messages of up to 140 characters which
can be searched and retrieved through the Twitter Search
API. Up to 1500 tweets are provided per request and no
external content retrieval is necessary. However, it should
be noted that tweets contain special character formats and
are quite challenging for text mining tasks (therefore
require specialized toolset).
}
\examples{
\dontrun{
corpus <- Corpus(TwitterSource("Microsoft"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

