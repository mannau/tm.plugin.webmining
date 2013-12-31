# TODO: Add comment
# 
# Author: mario
###############################################################################


#' Get Feed Meta Data from Bing Live Search API
#' @author Mario Annau
#' @param query character specifying query to be used to search tweets
#' @param n number of results (curr. max is ?), defaults to 100
#' @param count number of results per page, defaults to 10
#' @param appid Developer App id to be used obtained from \url{http://www.bing.com/developers}
#' @param sources, source type, defaults to "news", see \url{http://msdn.microsoft.com/en-us/library/dd250847.aspx} for additional source types
#' @param params additional query parameters, see \url{http://msdn.microsoft.com/en-us/library/dd251056.aspx}
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @seealso \code{\link{WebSource}}, \code{\link{readBing}} 
#' @export
#' @examples
#' \dontrun{
#' #set appid, obtained from http://www.bing.com/developers
#' corpus <- Corpus(BingSource("Microsoft", appid = appid))
#' }
#' @importFrom XML xmlInternalTreeParse
#' @importFrom XML xpathSApply
#' @importFrom XML newXMLNamespace
#' @aliases readBing
BingSource <- function(query, n = 100, count = 10, appid,  sources = "news", params = 
				list(	Appid = appid,
						query = query,
						sources=sources,
						market = "en-US"), ...){
	
	params[[paste(sources, ".offset", sep = "")]] <- seq(0, n-count, by = count)
	params[[paste(sources, ".count", sep = "")]] <- count
	
	feed <- "http://api.search.live.net/xml.aspx"
	
	parser <- function(cr){
		namespaces = c(	"news" = "http://schemas.microsoft.com/LiveSearch/2008/04/XML/news")
		
		tree <- xmlInternalTreeParse(cr, asText = TRUE)
		nodes <- xpathSApply(tree, path = "//news:NewsResult", namespaces = namespaces)
		#to surpress namespace warnings while parsing
		xmlns1 <- lapply(nodes, newXMLNamespace, "http://schemas.microsoft.com/LiveSearch/2008/04/XML/news", "news")
		nodes
	}
	
	fq <- feedquery(feed, params)
	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, ...)
	ws$DefaultReader <- readBing
	ws$PostFUN = function(x){
		x <- getLinkContent(x)
		#tm_map(x, extract, extractor = ArticleExtractor)
	}
	ws
}

#SECEdgarSource <- function(query, n=100, filetype = "10", ...){
#	feed <- "http://www.sec.gov/cgi-bin/browse-edgar"
#	params <- list(action="getcompany", 
#				   `match=&CIK`=query,
#				   type = filetype,
#				   `type=&dateb=&owner` = "exclude",
#				   start=0, 
#				   count=n, 
#				   output = "atom")
#	fq <- feedquery(feed, params)
#	parser <- function(cr){
#		namespaces = c(	"xmlns" = "http://www.w3.org/2005/Atom")
#		tree <- xmlInternalTreeParse(cr, asText = TRUE)
#		xpathSApply(tree, path = "//xmlns:entry", namespaces = namespaces)
#	}
#	
#	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, ...) 
#	ws$DefaultReader <- readSECEdgar
#	ws$PostFUN = function(x){
#		urls <- getURL(sapply(x, meta, "Origin"), async = F)
#		for(i in 1:length(x)){
#			html <- tryCatch(htmlTreeParse(urls[i], asText = T, useInternalNodes = T),error = function(e) e)
#			if(class(html)[1] == "simpleError"){
#				meta(x[[i]],"SubmissionFile") <- ""
#				next
#			}
#			all.links <- xpathSApply(html, "//a", xmlGetAttr, "href") 
#			textlink <- grep("^/Archives/edgar/data.*?\\.txt$", all.links, value = T)
#			textlink <- textlink[length(textlink)]
#			textlink <- paste("http://www.sec.gov",textlink,sep = "")
#			meta(x[[i]],"SubmissionFile") <- textlink
#			Content(x[[i]]) <- getURL(textlink)
#		}
#	}
#	ws
#	
#}

