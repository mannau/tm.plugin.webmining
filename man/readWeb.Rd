\name{readWeb}
\alias{json_content}
\alias{readWeb}
\alias{readWebHTML}
\alias{readWebJSON}
\alias{readWebXML}
\title{Read content from WebXMLSource/WebHTMLSource/WebJSONSource.}
\usage{
readWeb(spec, doc, parser, contentparser, freeFUN = NULL)
}
\arguments{
  \item{spec}{specification of content reader}

  \item{doc}{document to be parsed}

  \item{parser}{parser function to be used}

  \item{contentparser}{content parser function to be used,
  see also \code{tm:::xml_content} or \code{json_content}}

  \item{freeFUN}{function to free memory from parsed object
  (actually only relevant for XML and HTML trees)}
}
\value{
FunctionGenerator
}
\description{
\code{readWeb} is a FunctionGenerator which specifies
content retrieval from a \code{\link{WebSource}} content
elements. Currently, it is defined for XML, HTML and JSON
feeds through \code{readWebXML}, \code{readWebHTML} and
\code{readWebJSON}. Also content parsers
(\code{xml_content}, \code{json_content}) need to be
defined.
}

