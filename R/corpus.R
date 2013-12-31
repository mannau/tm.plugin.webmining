#' @title WebCorpus constructor function.
#' @description \code{WebCorpus} adds further methods and meta data to \code{\link[tm]{Corpus}} and therefore
#' constructs a derived class of \code{\link[tm]{Corpus}}. Most importantly, \code{WebCorpus}
#' calls \code{$PostFUN} on the generated \code{WebCorpus}, which retrieves the main content
#' for most implemented \code{WebSource}s. Thus it enables an efficient retrieval of new feed items
#' (\code{\link{corpus.update}}). All additional WebCorpus fields are added to \code{\link[tm]{CMetaData}}
#' like \code{$Source}, \code{$ReaderControl} and \code{$PostFUN}.
#' @param x object of type Source, see also \code{\link{Corpus}}
#' @param readerControl specifies reader to be used for \code{Source}, defaults to
#' list(reader = x$DefaultReader, language = "en"
#' @param postFUN function to be applied to WebCorpus after web retrieval has been completed,
#' defaults to x$PostFUN
#' @param retryEmpty specifies if retrieval for empty content elements should be repeated, 
#' defaults to TRUE
#' @param ... additional parameters for Corpus function (actually Corpus reader)
#' @export
WebCorpus <- function(x, readerControl = list(reader = x$DefaultReader, language = "en"), 
		postFUN = x$PostFUN, retryEmpty = T, ...){
	corpus <- Corpus(x, readerControl, ...)
	if(!is.null(postFUN)){
		corpus <- postFUN(corpus)
	}
	
	cm <- CMetaData(corpus)
	
	cm$MetaData$Source <- x
	cm$MetaData$ReaderControl <- readerControl
	cm$MetaData$PostFUN <- postFUN
	
	attr(corpus, "CMetaData") <- cm
	class(corpus) <- c("WebCorpus", class(corpus))
	if(retryEmpty){
		corpus <- getEmpty(corpus)
	}
	corpus
	
}

#'@S3method [ WebCorpus
#' @noRd
`[.WebCorpus` <- function(x, i) {
	if (missing(i)) return(x)
	corpus <- tm:::.VCorpus(NextMethod("["), CMetaData(x), DMetaData(x)[i, , drop = FALSE])
	class(corpus) <- c("WebCorpus", class(corpus))
	corpus
}

#' @title Update/Extend \code{\link{WebCorpus}} with new feed items.
#' @description The \code{corpus.update} method ensures, that the original 
#' \code{\link{WebCorpus}} feed sources are downloaded and checked against
#' already included \code{TextDocument}s. Based on the \code{ID} included
#' in the  \code{TextDocument}'s meta data, only new feed elements are
#' downloaded and added to the \code{\link{WebCorpus}}.
#' All relevant information regariding the original source feeds are stored
#' in the \code{\link{WebCorpus}}' meta data (\code{\link[tm]{CMetaData}}).
#' @param x object of type \code{\link{WebCorpus}}
#' @param ... 
#' \describe{
#' \item{fieldname}{name of \code{\link{Corpus}} field name to be used as ID, defaults to "ID"}
#' \item{retryempty}{specifies if empty corpus elements should be downloaded again, defaults to TRUE}
#' \item{...}{additional parameters to \code{\link{Corpus}} function}
#' }
#' @export corpus.update
#' @aliases corpus.update.WebCorpus
corpus.update <- function(x, ...){
	UseMethod("corpus.update", x)	
}

#' Update/Extend \code{\link{WebCorpus}} with new feed items.
#' @S3method corpus.update WebCorpus
#' @param x \code{\link{WebCorpus}}
#' @param fieldname name of \code{\link{Corpus}} field name to be used as ID, defaults to "ID"
#' @param retryempty specifies if empty corpus elements should be downloaded again, defaults to TRUE
#' @param ... additional parameters to \code{\link{Corpus}} function
#' @noRd
corpus.update.WebCorpus <- 
function(x, fieldname = "ID", retryempty = T, verbose = F, ...) {
	cm <- CMetaData(x)
	
	newsource <- source.update(cm$MetaData$Source)
	
	newcorpus <- Corpus(newsource, readerControl = cm$MetaData$ReaderControl, postFUN = NULL, ...)
	#intersect on ID
	id_old <- sapply(x, meta, fieldname)
	if(any(sapply(id_old, length) == 0))
		stop(paste("Not all elements in corpus to update have field '", fieldname, "' defined", sep = ""))

	id_new <- sapply(newcorpus, meta, fieldname)
	if(any(sapply(id_new, length) == 0))
		stop(paste("Not all elements in corpus to update have field '", fieldname, "' defined", sep = ""))
	
	newcorpus <- newcorpus[!id_new %in% id_old]
	
	if(length(newcorpus) > 0){
		if(!is.null(cm$MetaData$PostFUN)){
			newcorpus <- cm$MetaData$PostFUN(newcorpus)
		}
		corpus <- c(x, newcorpus)
		attr(corpus, "CMetaData") <- CMetaData(x)
		class(corpus) <- c("WebCorpus", class(corpus))
	}else{
		corpus <- x
	}
	
	if(retryempty){
		corpus <- getEmpty(corpus)
	}
	
	if(verbose){
		cat(length(newcorpus), " corpus items added.\n")
	}
		
	corpus
}


#' @title Retrieve Empty Corpus Elements through \code{$postFUN}. 
#' @description Retrieve content of all empty (textlength equals zero) corpus elements. If 
#' corpus element is empty, \code{$postFUN} is called (specified in \code{\link{CMetaData}})
#' @param x object of type \code{\link{WebCorpus}}
#' @param ... additional parameters to PostFUN
#' @seealso \code{\link{WebCorpus}}
#' @export getEmpty
#' @aliases getEmpty.WebCorpus
getEmpty <- function(x, ...){
	UseMethod("getEmpty", x)	
}
	

#' @S3method getEmpty WebCorpus
#' @noRd
getEmpty.WebCorpus <- 
function(x, nChar = 0, ...){
	cm <- CMetaData(x)
	noContent <- which(sapply(x, nchar) <= nChar)
	if(length(noContent) > 0){
		corp_nocontent <- x[noContent]
		if(!is.null(cm$MetaData$PostFUN)){
			corp_nocontent <- cm$MetaData$PostFUN(corp_nocontent, ...)
		}
		x[noContent] <- corp_nocontent
	}
	x
}


