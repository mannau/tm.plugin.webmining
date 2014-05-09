\name{YahooFinanceSource}
\alias{YahooFinanceSource}
\alias{readYahoo}
\title{Get feed data from Yahoo! Finance.}
\usage{
YahooFinanceSource(query, params = list(s = query, n = 20), ...)
}
\arguments{
  \item{query}{ticker symbols of companies to be searched
  for, see \url{http://finance.yahoo.com/lookup}.}

  \item{params,}{additional query parameters, see
  \url{http://developer.yahoo.com/rss/}}

  \item{...}{additional parameters to
  \code{\link{WebSource}}}
}
\value{
WebXMLSource
}
\description{
Yahoo! Finance is a popular site which provides financial
news and information. It is a large source for historical
price data as well as financial news. Using the typical
Yahoo! Finance ticker news items can easily be retrieved.
However, the maximum number of items is 20.
}
\examples{
\dontrun{
corpus <- Corpus(YahooFinanceSource("MSFT"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{WebSource}}
}

