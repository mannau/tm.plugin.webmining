\docType{data}
\name{rbloggers}
\alias{rbloggers}
\title{WebCorpus retrieved from the Google Reader API for the R-Bloggers blog
consisting only of meta data (no main content available). Length of
retrieved corpus is 1000.}
\description{
WebCorpus retrieved from the Google Reader API for the
R-Bloggers blog consisting only of meta data (no main
content available). Length of retrieved corpus is 1000.
}
\examples{
#Data set has been generated as follows:
\dontrun{
token <- auth.google.reader(email="<username>@gmail.com", password="<password>")
rbloggers <- WebCorpus(GoogleReaderSource("http://feeds.feedburner.com/RBloggers", token, params = list(n = 1000)),
		postFUN = NULL)
}
}
\author{
Mario Annau
}
\references{
\url{http://feeds.feedburner.com/RBloggers}
}
\keyword{data}

