\name{GoogleBlogSearchSource}
\alias{GoogleBlogSearchSource}
\alias{readGoogleBlogSearch}
\title{Get feed data from Google Blog Search (\url{http://www.google.com/blogsearch}).}
\usage{
GoogleBlogSearchSource(query, params = list(hl = "en", q = query, ie =
  "utf-8", num = 100, output = "rss"), ...)
}
\arguments{
  \item{query}{Google Blog Search query}

  \item{params,}{additional query parameters}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
Google Blog Search is a specialized search service/index
for web blogs. Since the Googlebots are typically just
scanning the blog's RSS feeds for updates they are much
faster updating than comparable general purpose crawlers.
}
\examples{
\dontrun{
corpus <- Corpus(GoogleBlogSearchSource("Microsoft"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

