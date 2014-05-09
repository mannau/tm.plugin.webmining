\name{encloseHTML}
\alias{encloseHTML}
\alias{encloseHTML.PlainTextDocument}
\alias{encloseHTML.character}
\title{Enclose Text Content in HTML tags}
\usage{
encloseHTML(x)
}
\arguments{
  \item{x}{object of PlainTextDocument class}
}
\description{
Simple helper function which encloses text content of
character (or \code{\link[tm]{TextDocument}}) in HTML-tags.
That way, HTML content can be easier parsed by
\code{\link[XML]{htmlTreeParse}}
}

