\name{WebSource}
\alias{WebSource}
\title{Read Web Content and respective Link Content from feedurls.}
\usage{
WebSource(feedurls, class = "WebXMLSource", reader, parser,
  encoding = "UTF-8", curlOpts = curlOptions(followlocation = TRUE,
  maxconnects = 20, maxredirs = 10, timeout = 30, connecttimeout = 30),
  postFUN = NULL, ...)
}
\arguments{
  \item{feedurls}{urls from feeds to be retrieved}

  \item{class}{class label to be assigned to \code{Source}
  object, defaults to "WebXMLSource"}

  \item{reader}{function to be used to read content, see
  also \code{\link{readWeb}}}

  \item{parser}{function to be used to split feed content
  into chunks, returns list of content elements}

  \item{encoding}{specifies default encoding, defaults to
  'UTF-8'}

  \item{curlOpts}{a named list or CURLOptions object
  identifying the curl options for the handle. Type
  \code{listCurlOptions()} for all Curl options available.}

  \item{postFUN}{function saved in WebSource object and
  called to retrieve full text content from feed urls}

  \item{...}{additional parameters passed to
  \code{WebSource} object/structure}
}
\value{
WebSource
}
\description{
WebSource is derived from \code{\link[tm]{Source}}. In
addition to calling the base \code{\link[tm]{Source}}
constructor function it also retrieves the specified
feedurls and pre--parses the content with the parser
function. The fields \code{$Content}, \code{$Feedurls}
\code{$Parser} and \code{$CurlOpts} are finally added to
the \code{Source} object.
}
\author{
Mario Annau
}

