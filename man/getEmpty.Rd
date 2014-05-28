\name{getEmpty}
\alias{getEmpty}
\alias{getEmpty.WebCorpus}
\title{Retrieve Empty Corpus Elements through \code{$postFUN}.}
\usage{
getEmpty(x, ...)
}
\arguments{
  \item{x}{object of type \code{\link{WebCorpus}}}

  \item{...}{additional parameters to PostFUN}
}
\description{
Retrieve content of all empty (textlength equals zero)
corpus elements. If corpus element is empty,
\code{$postFUN} is called (specified in \code{\link{meta}})
}
\seealso{
\code{\link{WebCorpus}}
}

