\name{feedquery}
\alias{feedquery}
\title{Buildup string for feedquery.}
\usage{
feedquery(url, params)
}
\arguments{
  \item{url}{character specifying feed url}

  \item{params}{list which contains feed parameters, e.g.
  list(param1="value1", param2="value2")}
}
\description{
Function has partly been taken from
\code{\link[RCurl]{getForm}} function. Generally, a feed
query is a string built up as follows: \cr
\code{<url>?<param1=value1>&<param2=value2>&...&<paramN=valueN>}
\cr By specifying a feed url and parameter--value pairs (as
list) we can easily generate a feed query in R.
}
\examples{
\dontrun{
feedquery(url = "http://dummy.com",
params = list(param1 = "value1", param2 = "value2"))
}
}
\author{
Mario Annau
}
\seealso{
\code{\link{xmlNode}} \code{\link{getForm}}
}

