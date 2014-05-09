\name{extractHTMLStrip}
\alias{extractHTMLStrip}
\title{Simply strip HTML Tags from Document}
\usage{
extractHTMLStrip(url, asText = TRUE, encoding, ...)
}
\arguments{
  \item{url}{character, url or filename}

  \item{asText}{specifies if url parameter is a
  \code{character}, defaults to TRUE}

  \item{encoding}{specifies local encoding to be used,
  depending on platform}

  \item{...}{Additional parameters for
  \code{\link{htmlTreeParse}}}
}
\description{
\code{extractHTMLStrip} parses an url, character or
filename, reads the DOM tree, removes all HTML tags in the
tree and outputs the source text without markup.
}
\note{
Input text should be enclosed in <html>'TEXT'</html> tags
to ensure correct DOM parsing (issue especially under
.Platform$os.type = 'windows')
}
\author{
Mario Annau
}
\seealso{
\code{\link{xmlNode}}

\code{\link{htmlTreeParse}} \code{\link{encloseHTML}}
}

