\name{getLinkContent}
\alias{getLinkContent}
\title{Get main content for corpus items, specified by links.}
\usage{
getLinkContent(corpus, links = sapply(corpus, meta, "origin"),
  timeout.request = 30, chunksize = 20, verbose = getOption("verbose"),
  curlOpts = curlOptions(verbose = FALSE, followlocation = TRUE, maxconnects =
  5, maxredirs = 10, timeout = timeout.request, connecttimeout =
  timeout.request, ssl.verifyhost = FALSE, ssl.verifypeer = FALSE, useragent =
  "R"), retry.empty = 3, sleep.time = 3, extractor = ArticleExtractor,
  .encoding = integer(), ...)
}
\arguments{
  \item{corpus}{object of class \code{\link[tm]{Corpus}}
  for which link content should be downloaded}

  \item{links}{character vector specifyinig links to be
  used for download, defaults to sapply(corpus, meta,
  "Origin")}

  \item{timeout.request}{timeout (in seconds) to be used
  for connections/requests, defaults to 30}

  \item{curlOpts}{curl options to be passed to
  \code{\link{getURL}}}

  \item{chunksize}{Size of download chunks to be used for
  parallel retrieval, defaults to 20}

  \item{verbose}{Specifies if retrieval info should be
  printed, defaults to getOption("verbose")}

  \item{retry.empty}{Specifies number of times empty
  content sites should be retried, defaults to 3}

  \item{sleep.time}{Sleep time to be used between chunked
  download, defaults to 3 (seconds)}

  \item{extractor}{Extractor to be used for content
  extraction, defaults to extractContentDOM}

  \item{...}{additional parameters to \code{\link{getURL}}}

  \item{.encoding}{encoding to be used for
  \code{\link{getURL}}, defaults to integer()
  (=autodetect)}
}
\value{
corpus including downloaded link content
}
\description{
\code{getLinkContent} downloads and extracts content from
weblinks for \code{\link[tm]{Corpus}} objects. Typically it
is integrated and called as a post-processing function
(field:\code{$postFUN}) for most \code{\link{WebSource}}
objects. \code{getLinkContent} implements content download
in chunks which has been proven to be a stabler approach
for large content requests.
}
\seealso{
\code{\link{WebSource}} \code{\link[RCurl]{getURL}}
\code{\link[boilerpipeR]{Extractor}}
}

