\docType{package}
\name{tm.plugin.webmining-package}
\alias{tm.plugin.webmining}
\alias{tm.plugin.webmining-package}
\alias{webmining}
\title{Retrieve structured, textual data from various web sources}
\description{
tm.plugin.webmining facilitates the retrieval of textual
data through various web feed formats like XML and JSON.
Also direct retrieval from HTML is supported. As most
(news) feeds only incorporate small fractions of the
original text tm.plugin.webmining goes a step further and
even retrieves and extracts the text of the original text
source. Generally, the retrieval procedure can be described
as a two--step process: \describe{ \item{Meta Retrieval}{In
a first step, all relevant meta feeds are retrieved. From
these feeds all relevant meta data items are extracted. }
\item{Content Retrieval}{In a second step the relevant
source content is retrieved. Using the \code{boilerpipeR}
package even the main content of \code{HTML} pages can be
extracted. }}
}
\examples{
\dontrun{
googleblogsearch <- WebCorpus(GoogleBlogSearchSource("Microsoft"))
googlefinance <- WebCorpus(GoogleFinanceSource("NASDAQ:MSFT"))
googlenews <- WebCorpus(GoogleNewsSource("Microsoft"))
nytimes <- WebCorpus(NYTimesSource("Microsoft", appid = nytimes_appid))
reutersnews <- WebCorpus(ReutersNewsSource("businessNews"))
yahoofinance <- WebCorpus(YahooFinanceSource("MSFT"))
yahooinplay <- WebCorpus(YahooInplaySource())
yahoonews <- WebCorpus(YahooNewsSource("Microsoft"))
}
}
\author{
Mario Annau \email{mario.annau@gmail}
}
\seealso{
\code{\link{WebCorpus}}
\code{\link{GoogleBlogSearchSource}}
\code{\link{GoogleFinanceSource}}
\code{\link{GoogleNewsSource}} \code{\link{NYTimesSource}}
\code{\link{ReutersNewsSource}}
\code{\link{YahooFinanceSource}}
\code{\link{YahooInplaySource}}
\code{\link{YahooNewsSource}}
}
\keyword{package}

