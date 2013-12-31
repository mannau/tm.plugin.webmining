#' Extract Content from HTML Documents
#' @author Mario Annau
#' @param contentsrc list containing source text content to be extracted
#' @param extractor Extractor function to be used, defaults to \code{\link{extractContentDOM}}
#' @param verbose Print messages from extraction process, defaults to TRUE
#' @param ... additional parameters forwarded to extraction function
#' @seealso \code{\link{extractContentDOM}} \code{\link{extractHTMLStrip}}
#' @references 	\url{http://www.elias.cn/En/ExtMainText}, 
#' 				\url{http://ai-depot.com/articles/the-easy-way-to-extract-useful-text-from-arbitrary-html/}
#' 				\cite{Gupta et al., DOM-based Content Extraction of HTML Documents},\url{http://www2003.org/cdrom/papers/refereed/p583/p583-gupta.html}
#' @export
extractContent <- 
		function(contentsrc, extractor = "extractContentDOM", verbose = FALSE, ...){
	content <- c()
	if(!is.null(extractor)){
		if(verbose)
			cat("Extract Content...\n")
		for(i in 1:length(contentsrc)){
			src <- contentsrc[i]
			content[i] <- tryCatch(do.call(extractor, list(src, ...)), 
					error = function(e){
						cat("An Error occured at Content Extraction, index ", i, "\n")
						print(e)
						return("")
					})
			gc()
			if(verbose){
				progress <- floor(i/length(contentsrc)*100)
				cat(progress, "%\r")
			}
		}
		if(verbose)
			cat("Done !\n")
	}else{
		content <- contentsrc
	}
	return(content)
}

