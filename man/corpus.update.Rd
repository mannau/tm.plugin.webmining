\name{corpus.update}
\alias{corpus.update}
\alias{corpus.update.WebCorpus}
\title{Update/Extend \code{\link{WebCorpus}} with new feed items.}
\usage{
corpus.update(x, ...)
}
\arguments{
  \item{x}{object of type \code{\link{WebCorpus}}}

  \item{...}{\describe{ \item{fieldname}{name of
  \code{\link{Corpus}} field name to be used as ID,
  defaults to "ID"} \item{retryempty}{specifies if empty
  corpus elements should be downloaded again, defaults to
  TRUE} \item{...}{additional parameters to
  \code{\link{Corpus}} function} }}
}
\description{
The \code{corpus.update} method ensures, that the original
\code{\link{WebCorpus}} feed sources are downloaded and
checked against already included \code{TextDocument}s.
Based on the \code{ID} included in the
\code{TextDocument}'s meta data, only new feed elements are
downloaded and added to the \code{\link{WebCorpus}}. All
relevant information regariding the original source feeds
are stored in the \code{\link{WebCorpus}}' meta data
(\code{\link[tm]{meta}}).
}

