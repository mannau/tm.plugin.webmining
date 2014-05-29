\name{WebCorpus}
\alias{WebCorpus}
\title{WebCorpus constructor function.}
\usage{
WebCorpus(x, readerControl = list(reader = reader(x), language = "en"),
  postFUN = x$postFUN, retryEmpty = TRUE, ...)
}
\arguments{
  \item{x}{object of type Source, see also
  \code{\link{Corpus}}}

  \item{readerControl}{specifies reader to be used for
  \code{Source}, defaults to list(reader = x$DefaultReader,
  language = "en"}

  \item{postFUN}{function to be applied to WebCorpus after
  web retrieval has been completed, defaults to x$PostFUN}

  \item{retryEmpty}{specifies if retrieval for empty
  content elements should be repeated, defaults to TRUE}

  \item{...}{additional parameters for Corpus function
  (actually Corpus reader)}
}
\description{
\code{WebCorpus} adds further methods and meta data to
\code{\link[tm]{Corpus}} and therefore constructs a derived
class of \code{\link[tm]{Corpus}}. Most importantly,
\code{WebCorpus} calls \code{$PostFUN} on the generated
\code{WebCorpus}, which retrieves the main content for most
implemented \code{WebSource}s. Thus it enables an efficient
retrieval of new feed items (\code{\link{corpus.update}}).
All additional WebCorpus fields are added to \code{tm$meta}
like \code{$source}, \code{$readerControl} and
\code{$postFUN}.
}

