#' @title Read Web Content and respective Link Content from feedurls.
#' @description WebSource is derived from \code{\link[tm]{Source}}. In addition to calling the
#' base \code{\link[tm]{Source}} constructor function it also retrieves the specified
#' feedurls and pre--parses the content with the parser function.
#' The fields \code{$Content}, \code{$Feedurls} \code{$Parser} and \code{$CurlOpts} are finally
#' added to the \code{Source} object.
#' @author Mario Annau
#' @param feedurls urls from feeds to be retrieved
#' @param class class label to be assigned to \code{Source} object, defaults to "WebXMLSource"
#' @param reader function to be used to read content, see also \code{\link{readWeb}}
#' @param parser function to be used to split feed content into chunks, returns list of content elements
#' @param encoding specifies default encoding, defaults to 'UTF-8'
#' @param curlOpts a named list or CURLOptions object identifying the curl options for the handle. Type \code{listCurlOptions()} for all Curl options available.
#' @param postFUN function saved in WebSource object and called to retrieve full text content from feed urls 
#' @param ... additional parameters passed to \code{WebSource} object/structure
#' @return WebSource
#' @export
#' @importFrom XML getNodeSet xmlValue
#' @importFrom RCurl curlOptions
WebSource <- function(feedurls, class = "WebXMLSource", reader, parser, encoding = "UTF-8",
		curlOpts = curlOptions(	followlocation = TRUE, 
				maxconnects = 20,
				maxredirs = 10,
				timeout = 30,
				connecttimeout = 30), postFUN = NULL, ...){
	content_raw <- getURL(feedurls, .opts = curlOpts)
	content_parsed <- unlist(lapply(content_raw, parser), recursive = FALSE)
  structure(list(encoding = encoding, length = length(content_parsed), names = NA_character_,
              position = 0, reader = reader, content = content_parsed, feedurls = feedurls,
              parser = parser, curlOpts = curlOpts, postFUN = postFUN, ...), 
            class = unique(c(class, "WebSource", "SimpleSource")))
}


#' @title Update WebXMLSource/WebHTMLSource/WebJSONSource
#' @description Typically, update is called from \code{link{corpus.update}} and refreshes \code{$Content} in 
#' Source object.
#' @param x Source object to be updated
#' @export source.update
#' @aliases source.update.WebXMLSource source.update.WebHTMLSource source.update.WebJSONSource
source.update <- function(x){
	UseMethod("source.update", x)	
}

#'update WebSource
#' @S3method source.update WebXMLSource
#' @S3method source.update WebHTMLSource
#' @S3method source.update WebJSONSource
#' @noRd
source.update.WebXMLSource <- 
source.update.WebHTMLSource <- 
source.update.WebJSONSource <- 
function(x) {
	content_raw <- getURL(x$feedurls, .opts = x$curlOpts)
	content_parsed <- unlist(lapply(content_raw, x$parser), recursive = FALSE)
	x$content <- content_parsed
	x$position <- 0
	x
}

#' @title Get feed Meta Data from Google Finance. 
#' @description Google Finance provides business and enterprise headlines for many companies. Coverage is 
#' particularly strong for US-Markets. However, only up to 20 feed items can be retrieved.
#' @author Mario Annau
#' @param query ticker symbols of companies to be searched for, see \url{http://www.google.com/finance}.
#' Please note that Google ticker symbols need to be prefixed with the exchange name, e.g. NASDAQ:MSFT
#' @param params additional query parameters
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @seealso \code{\link{WebSource}}
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(GoogleFinanceSource("NASDAQ:MSFT"))
#' }
#' @importFrom XML xmlInternalTreeParse
#' @importFrom XML xpathSApply
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @aliases readGoogle
GoogleFinanceSource <- function(query, params = 
				list( 	hl= 'en', 
						q=query, 
						ie='utf-8', 
						start = 0, 
						num = 20, 
						output='rss'),...){
	feed <- "http://www.google.com/finance/company_news"
	parser <- function(cr){
		tree <- parse(cr, type = "XML")
		xpathSApply(tree, path = "//item")
	}
	fq <- feedquery(feed, params)
  ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, reader = readGoogle, 
      postFUN = getLinkContent, ...)
	ws
}

#' @title Get feed data from Yahoo! Finance.
#' @description Yahoo! Finance is a popular site which provides financial news and information. It is a large source
#' for historical price data as well as financial news. Using the typical Yahoo! Finance ticker 
#' news items can easily be retrieved. However, the maximum number of items is 20. 
#' @author Mario Annau
#' @param query ticker symbols of companies to be searched for, see \url{http://finance.yahoo.com/lookup}.
#' @param params, additional query parameters, see \url{http://developer.yahoo.com/rss/}
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(YahooFinanceSource("MSFT"))
#' }
#' @seealso \code{\link{WebSource}}
#' @importFrom XML xmlInternalTreeParse
#' @importFrom XML xpathSApply
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @aliases readYahoo
YahooFinanceSource <- function(query, params = 
				list(	s= query, 
						n = 20), ...){
	feed <- "http://finance.yahoo.com/rss/headline"
	
	fq <- feedquery(feed, params)
	parser <- function(cr){
		tree <- parse(cr, type = "XML")
		xpathSApply(tree, path = "//item")
	}
	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, reader = readYahoo, 
      postFUN = getLinkContent, ...)
	ws
}

#' @title Get feed data from Google Blog Search (\url{http://www.google.com/blogsearch}).
#' @description Google Blog Search is a specialized search service/index for web blogs. Since the Googlebots
#' are typically just scanning the blog's RSS feeds for updates they are much faster updating than comparable
#' general purpose crawlers.
#' @author Mario Annau
#' @param query Google Blog Search query
#' @param params, additional query parameters
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @seealso \code{\link{WebSource}}
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(GoogleBlogSearchSource("Microsoft"))
#' }
#' @importFrom XML xmlInternalTreeParse xpathSApply getNodeSet xmlValue newXMLNamespace
#' @importFrom boilerpipeR DefaultExtractor
#' @aliases readGoogleBlogSearch
GoogleBlogSearchSource <- function(query, params = 
				list(	hl= 'en', 
						q = query, 
						ie='utf-8', 
						num = 100, 
						output='rss'), ...){
	feed <- "http://blogsearch.google.com/blogsearch_feeds"

	fq <- feedquery(feed, params)
	parser <- function(cr){
		tree <- parse(cr, type = "XML")
		nodes <- xpathSApply(tree, path = "//item")
		xmlns1 <- lapply(nodes, newXMLNamespace, "http://purl.org/dc/elements/1.1/", "dc")
		nodes
	}
  postFUN = function(x){
    x <- getLinkContent(x, extractor = DefaultExtractor)
  }
	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, reader = readGoogleBlogSearch, 
      postFUN = postFUN, ...)
	ws
}


#' @title Get feed data from Google News Search \url{http://news.google.com/}
#' @description Google News Search is one of the most popular news aggregators on the web. News
#' can be retrieved for any customized user query. Up to 100 can be retrieved per 
#' request.
#' @author Mario Annau
#' @param query Google News Search query
#' @param params, additional query parameters
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @seealso \code{\link{WebSource}}
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(GoogleNewsSource("Microsoft"))
#' }
#' @importFrom XML xmlInternalTreeParse xpathSApply getNodeSet xmlValue newXMLNamespace
GoogleNewsSource <- function(query, params = 
				list(	hl= 'en', 
						q = query, 
						ie='utf-8', 
						num = 100, 
						output='rss'), ...){
	feed <- "http://news.google.com/news"
	fq <- feedquery(feed, params)
	parser <- function(cr){
		tree <- parse(cr, type = "XML")
		nodes <- xpathSApply(tree, path = "//item")
		xmlns1 <- lapply(nodes, newXMLNamespace, "http://purl.org/dc/elements/1.1/", "dc")
		nodes
	}
	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, reader = readGoogle,
      postFUN = getLinkContent, ...)
	ws
}

#' @title Get feed data from Reuters News RSS feed channels. Reuters provides numerous feed 
#' @description channels (\url{http://www.reuters.com/tools/rss}) which can be retrieved through RSS 
#' feeds. Only up to 25 items can be retrieved---therefore an alternative retrieval
#' through the Google Reader API (\code{link{GoogleReaderSource}}) could be considered.
#' @author Mario Annau
#' @param query Reuters News RSS Feed, see \url{http://www.reuters.com/tools/rss} for a list of all feeds provided. Note that only string after 'http://feeds.reuters.com/reuters/' must be given. Defaults to 'businessNews'.
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @seealso \code{\link{WebSource}}
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(ReutersNewsSource("businessNews"))
#' }
#' @importFrom XML xmlInternalTreeParse xpathSApply getNodeSet xmlValue newXMLNamespace
#' @aliases readReutersNews
ReutersNewsSource <- function(query = 'businessNews', ...){
	feed <- "http://feeds.reuters.com/reuters"
	
	fq <- paste(feed, query, sep = "/")
	parser <- function(cr){
		tree <- parse(cr, type = "XML")
		nodes <- xpathSApply(tree, path = "//item")
		xmlns1 <- lapply(nodes, newXMLNamespace, "http://rssnamespace.org/feedburner/ext/1.0", "feedburner")
		nodes
	}

	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, reader = readReutersNews, 
      postFUN = getLinkContent, ...)
	ws
}


# @title Get feed data from Twitter Search API (\url{https://dev.twitter.com/docs/api/1/get/search}). 
# @description The microblogging and social networking service twitter provides text based messages
# of up to 140 characters which can be searched and retrieved through the Twitter Search API. 
# Up to 1500 tweets are provided per request and no external content retrieval is necessary. 
# However, it should be noted that tweets contain special character formats and are quite 
# challenging for text mining tasks (therefore require specialized toolset).
# @author Mario Annau
# @param query Google Blog Search query
# @param n number of results, defaults to 1500
# @param params, additional query parameters, see \url{http://search.twitter.com/api/}
# @param ... additional parameters to \code{\link{WebSource}}
# @return WebXMLSource
# @seealso \code{\link{WebSource}}
# @export
# @examples
# \dontrun{
# corpus <- Corpus(TwitterSource("Microsoft"))
# }
# @importFrom XML xmlInternalTreeParse xpathSApply getNodeSet xmlValue newXMLNamespace
# @importFrom tm tm_map
# @aliases readTwitter
#TwitterSource <- function(query, n = 1500, params = 
#				list(lang = 'en'),...){
#	feed <- "http://search.twitter.com/search.atom"
#
#	if(is.null(params[["q"]])) params[["q"]] <- query
#	if(is.null(params[["rpp"]])) params[["rpp"]] <- 100
#	if(is.null(params[["page"]])) params[["page"]] <- seq(1,ceiling(n/params[["rpp"]]), by = 1)
#
#	parser <- function(cr){
#		namespaces = c(	"google" = "http://base.google.com/ns/1.0", 
#				"openSearch" = "http://a9.com/-/spec/opensearch/1.1/",  
#				"georss"="http://www.georss.org/georss", 
#				"a" = "http://www.w3.org/2005/Atom", 
#				"twitter"="http://api.twitter.com/")
#		
#		tree <- parse(cr, type = "XML")
#		nodes <- xpathSApply(tree, path = "///a:entry", namespaces = namespaces)
#		#to surpress namespace warnings while parsing
#		xmlns1 <- lapply(nodes, newXMLNamespace, "http://api.twitter.com/", "twitter")
#		xmlns2 <- lapply(nodes, newXMLNamespace, "http://www.georss.org/georss", "georss")
#		nodes
#	}
#	
#	fq <- feedquery(feed, params)
#	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, ...)
#	ws$DefaultReader <- readTwitter
#	#TODO: error with extractHTMLStrip, need tryCatch or whatever
#	enc <- switch(.Platform$OS.type,
#						unix = "UTF-8", 
#						windows = "latin1")
#			
#	ws$PostFUN <- function(x){
#		x <- tm_map(x, encloseHTML)
#		tm_map(x, extract, extractor = extractHTMLStrip, encoding = enc)
#	}
#	
#	ws
#  stop("Not implemented yet")
#}


#' @title Get feed data from Yahoo! News (\url{http://news.yahoo.com/}).
#' @description Yahoo! News is a large news aggregator and provides a customizable RSS feed. 
#' Only a maximum of 20 items can be retrieved.
#' @author Mario Annau
#' @param query words to be searched in Yahoo News, multiple words must be separated by '+'
#' @param params, additional query parameters, see \url{http://developer.yahoo.com/rss/}
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebXMLSource
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(YahooNewsSource("Microsoft"))
#' }
#' @seealso \code{\link{WebSource}}
#' @importFrom XML xmlInternalTreeParse
#' @importFrom XML xpathSApply
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
YahooNewsSource <- function(query, params = 
				list(	p= query, 
						n = 20,
						ei = "UTF-8"), ...){
	feed <- "http://news.search.yahoo.com/rss"
	
	fq <- feedquery(feed, params)
	parser <- function(cr){
		tree <- parse(cr, type = "XML")
		xpathSApply(tree, path = "//item")
	}
	ws <- WebSource(feedurls = fq, class = "WebXMLSource", parser = parser, reader = readYahoo, 
      postFUN = getLinkContent, ...)
	ws
}


#' @title Get feed data from NYTimes Article Search (\url{http://developer.nytimes.com/docs/read/article_search_api}). 
#' @description Excerpt from the website: "With the NYTimes Article Search API, you can search New York Times articles 
#' from 1981 to today, retrieving headlines, abstracts, lead paragraphs, links to associated multimedia 
#' and other article metadata. Along with standard keyword searching, the API also offers faceted searching. 
#' The available facets include Times-specific fields such as sections, taxonomic classifiers and controlled 
#' vocabulary terms (names of people, organizations and geographic locations)."
#' Feed retrieval is limited to 100 items.
#' @author Mario Annau
#' @param query character specifying query to be used to search NYTimes articles
#' @param n number of results defaults to 100
#' @param count number of results per page, defaults to 10
#' @param appid Developer App id to be used, obtained from \url{http://developer.nytimes.com/}
#' @param params additional query parameters, specified as list, see \url{http://developer.nytimes.com/docs/read/article_search_api}
#' @param ... additional parameters to \code{\link{WebSource}}
#' @seealso \code{\link{WebSource}}, \code{\link{readNYTimes}} 
#' @export
#' @examples
#' \dontrun{
#' #nytimes_appid needs to be specified
#' corpus <- WebCorpus(NYTimesSource("Microsoft", appid = nytimes_appid))
#' }
#' @export
#' @importFrom RJSONIO fromJSON
#' @importFrom boilerpipeR ArticleExtractor
#' @aliases readNYTimes
NYTimesSource <- function(query, n = 100, count = 10, appid, params = 
		list(	format="json",
				query = query,
				offset=seq(0, n-count, by = count),
				"api-key" = appid),...){
	feed <- "http://api.nytimes.com/svc/search/v1/article"
	fq <- feedquery(feed, params)
	
	parser <- function(cr){
		json <- parse(cr, type = "JSON")
		json$results
	}
	
	# Changing number of maxredirs to 20 for better contentratio
	curlOpts = curlOptions(	verbose = FALSE,
			followlocation = TRUE, 
			maxconnects = 5,
			maxredirs = 20,
			timeout = 30,
			connecttimeout = 30,
			ssl.verifyhost= FALSE,
			ssl.verifypeer = FALSE,
			useragent = "R")
	
	#linkreader <- function(tree) tree[["url"]]
	
	ws <- WebSource(feedurls = fq, class = "WebJSONSource", parser = parser, reader = readNYTimes, 
      postFUN = getLinkContent, curlOpts = curlOpts, ...)
#	ws$DefaultReader <- readNYTimes
#	ws$PostFUN <- function(x){
#		x <- getLinkContent(x, extractor = ArticleExtractor, curlOpts = curlOpts)
#		#tm_map(x, extract, extractor = ArticleExtractor)
#	}
	ws
}



#' @title Get News from Yahoo Inplay.
#' @description Yahoo Inplay lists a range of company news provided by Briefing.com. Since Yahoo Inplay
#' does not provide a structured XML news feed, content is parsed directly from the HTML page.
#' Therefore, no further Source parameters can be specified. The number of feed items per 
#' request can vary substantially.  
#' @author Mario Annau
#' @param ... additional parameters to \code{\link{WebSource}}
#' @return WebHTMLSource
#' @export
#' @examples
#' \dontrun{
#' corpus <- Corpus(YahooInplaySource())
#' }
#' @importFrom XML htmlTreeParse
#' @importFrom XML xpathSApply
#' @aliases readYahooInplay
YahooInplaySource <- function(...){
	url <- "http://finance.yahoo.com/marketupdate/inplay"
	parser <- function(cr){
		tree <- parse(cr, useInternalNodes = T, type = "HTML")
		xp_expr = "//div[@class= 'body yom-art-content clearfix']/p"
		paragraphs = xpathSApply(tree, xp_expr)
	}
	
	ws <- WebSource(feedurls = url, class = "WebHTMLSource", parser = parser, reader = readYahooInplay, ...)
	ws
}

#' @S3method getElem WebXMLSource
#' @S3method getElem WebHTMLSource
#' @importFrom XML saveXML
#' @noRd
getElem.WebXMLSource <- 
getElem.WebHTMLSource <- function(x) {
	list(content = saveXML(x$content[[x$position]]), linkcontent = NULL, uri = NULL)
}

#' @S3method getElem WebJSONSource
#' @noRd
getElem.WebJSONSource <- function(x) {
	list(content = x$content[[x$position]], linkcontent = NULL, uri = NULL)
}

# @importFrom tm getElem eoi
# @S3method eoi WebSource
# @noRd
#eoi.WebSource <- 
#function(x) length(x$content) <= x$position


# @importFrom tm stepNext
# @S3method stepNext WebSource
# @noRd
#stepNext.WebSource <- 
#function(x){
#  x$position <- x$position + 1
#  x
#}


#reader <- function(x)
#  UseMethod("reader", x)
# @S3method reader WebSource
# @importFrom tm reader
# @noRd
#reader.WebSource <- function(x) {
#  x$reader
#}
