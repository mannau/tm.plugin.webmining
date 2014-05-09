\name{YahooInplaySource}
\alias{YahooInplaySource}
\alias{readYahooInplay}
\title{Get News from Yahoo Inplay.}
\usage{
YahooInplaySource(...)
}
\arguments{
  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebHTMLSource
}
\description{
Yahoo Inplay lists a range of company news provided by
Briefing.com. Since Yahoo Inplay does not provide a
structured XML news feed, content is parsed directly from
the HTML page. Therefore, no further Source parameters can
be specified. The number of feed items per request can vary
substantially.
}
\examples{
\dontrun{
corpus <- Corpus(YahooInplaySource())
}
}
\author{
Mario Annau
}

