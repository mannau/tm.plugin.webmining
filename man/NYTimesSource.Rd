\name{NYTimesSource}
\alias{NYTimesSource}
\alias{readNYTimes}
\title{Get feed data from NYTimes Article Search (\url{http://developer.nytimes.com/docs/read/article_search_api}).}
\usage{
NYTimesSource(query, n = 100, count = 10, appid, params = list(format =
  "json", query = query, offset = seq(0, n - count, by = count), `api-key` =
  appid), ...)
}
\arguments{
  \item{query}{character specifying query to be used to
  search NYTimes articles}

  \item{n}{number of results defaults to 100}

  \item{count}{number of results per page, defaults to 10}

  \item{appid}{Developer App id to be used, obtained from
  \url{http://developer.nytimes.com/}}

  \item{params}{additional query parameters, specified as
  list, see
  \url{http://developer.nytimes.com/docs/read/article_search_api}}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\description{
Excerpt from the website: "With the NYTimes Article Search
API, you can search New York Times articles from 1981 to
today, retrieving headlines, abstracts, lead paragraphs,
links to associated multimedia and other article metadata.
Along with standard keyword searching, the API also offers
faceted searching. The available facets include
Times-specific fields such as sections, taxonomic
classifiers and controlled vocabulary terms (names of
people, organizations and geographic locations)." Feed
retrieval is limited to 100 items.
}
\examples{
\dontrun{
#nytimes_appid needs to be specified
corpus <- WebCorpus(NYTimesSource("Microsoft", appid = nytimes_appid))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}, \code{\link{readNYTimes}}
}

