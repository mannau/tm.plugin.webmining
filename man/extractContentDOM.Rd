\name{extractContentDOM}
\alias{assignValues}
\alias{calcDensity}
\alias{extractContentDOM}
\alias{getMainText}
\alias{removeTags}
\title{Extract Main HTML Content from DOM}
\usage{
extractContentDOM(url, threshold, asText = TRUE, ...)
}
\arguments{
  \item{url}{character, url or filename}

  \item{threshold}{threshold for extraction, defaults to
  0.5}

  \item{asText}{boolean, specifies if url should be
  interpreted as character}

  \item{...}{Additional Parameters to
  \code{\link{htmlTreeParse}}}
}
\description{
Function extracts main HTML Content using its Document
Object Model. Idea comes basically from the fact, that main
content of an HTML Document is in a subnode of the HTML DOM
Tree with a high text-to-tag ratio. Internally, this
function also calls \code{assignValues},
\code{calcDensity}, \code{getMainText} and
\code{removeTags}.
}
\author{
Mario Annau
}
\references{
\url{http://www.elias.cn/En/ExtMainText},
\url{http://ai-depot.com/articles/the-easy-way-to-extract-useful-text-from-arbitrary-html/}
\cite{Gupta et al., DOM-based Content Extraction of HTML
Documents},\url{http://www2003.org/cdrom/papers/refereed/p583/p583-gupta.html}
}
\seealso{
\code{\link{xmlNode}}
}

