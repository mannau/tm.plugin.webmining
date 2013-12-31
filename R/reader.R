#' @title Read content from WebXMLSource/WebHTMLSource/WebJSONSource. 
#' @description \code{readWeb} is a FunctionGenerator which specifies content retrieval from a \code{\link{WebSource}} 
#' content elements. Currently, it is defined for XML, HTML and JSON feeds through \code{readWebXML},
#' \code{readWebHTML} and \code{readWebJSON}. Also content parsers (\code{tm:::xml_content}, \code{json_content})
#' need to be defined.
#' @param spec specification of content reader
#' @param doc document to be parsed
#' @param parser parser function to be used
#' @param contentparser content parser function to be used, see also \code{tm:::xml_content} or \code{json_content}
#' @param freeFUN function to free memory from parsed object (actually only relevant for XML and HTML trees)
#' @return FunctionGenerator
#' @aliases readWebXML readWebHTML readWebJSON json_content 
#' @export
readWeb <- FunctionGenerator(function(spec, doc, parser, contentparser, freeFUN = NULL) {
			
	parser <- parser
	contentparser <- contentparser
	freeFUN <- freeFUN
	spec <- spec
	doc <- doc

	function(elem, language, id) {
		tree <- parser(elem$content)
	
		###Set Content
		Content(doc) <- if ("Content" %in% names(spec)){
							content <- contentparser(tree, spec[["Content"]])
						}
						else{
							character(0)
						}		

		for (n in setdiff(names(spec), "Content")){
				meta(doc, n) <- contentparser(tree, spec[[n]])
			}
			
			if(!is.null(freeFUN)){
				freeFUN(tree)
			}
			doc
		}
})

#' Read content from WebXMLSource
#' @param ... additional parameters to \code{\link{readWeb}}
#' @export
#' @importFrom XML xmlInternalTreeParse
#' @importFrom XML free
#' @noRd 
readWebXML <- function(...){
	parser <- function(x){
		#XML::xmlInternalTreeParse(x, asText = TRUE)
		parse(x, type = "XML")
	} 
	#contentparser <- function(x, cspec) tm:::.xml_content(x, cspec)
	contentparser <- tm:::.xml_content
	freeFUN <- XML:::free
	readWeb(parser = parser, contentparser = contentparser, freeFUN = freeFUN, ...)
}

#' Read content from WebHTMLSource
#' @param ... additional parameters to \code{\link{readWeb}}
#' @export
#' @importFrom XML htmlTreeParse
#' @importFrom XML free
#' @noRd 
readWebHTML <- function(...){
	#parser <- function(x) XML::htmlTreeParse(x, asText = TRUE, useInternalNodes = TRUE)
	parser <- function(x) parse(x, type = "HTML", useInternalNodes = TRUE)
	contentparser <- function(x, cspec) tm:::.xml_content(x, cspec)
	freeFUN <- XML:::free
	readWeb(parser = parser, contentparser = contentparser, freeFUN = freeFUN, ...)
}

#' Read content from WebJSONSource
#' @param ... additional parameters to \code{\link{readWeb}}
#' @export
#' @noRd 
readWebJSON <- function(...){
	parser <- function(x) identity(x)
	contentparser <- function(x, cspec) json_content(x, cspec)
	freeFUN <- rm
	readWeb(parser = parser, contentparser = contentparser, freeFUN = freeFUN, ...)
}


#' Read content from JSONSource
#' @param doc list object from which content should be retrieved
#' @param spec list field name as character
#' @export
#' @noRd 
json_content <- 
function (doc, spec) 
{
	type <- spec[[1]]
	fun <- switch(type, field = identity, node = identity)
	if (identical(type, "unevaluated")) 
		spec[[2]]
	else if (identical(type, "function") && is.function(spec[[2]])) 
		spec[[2]](doc)
	else{
		as.character(sapply(doc[[spec[[2]]]], 
						fun))
	} 
}

#' Read content from NYTimesSource
#' @noRd
#' @export
readNYTimes <- readWebJSON(spec = list(
#		Author = list("field", "byline"),
		Description = list("field", "body"),
		DateTimeStamp = list("function", function(node)
					strptime(node[["date"]],
							format = "%Y%m%d",
							tz = "GMT")),
		Heading = list("field", "title"),
		Origin = list("field", "url"),
		Language = list("unevaluated", "en"),
		ID = list("field", "url")),
	doc = PlainTextDocument())


#' Read content from TwitterSource
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readTwitter <- readWebXML(spec = list(
		Author = list("node", "//author/name"),
		AuthorURI = list("node", "//author/uri"),
		Content = list("node", "//content"),
		DateTimeStamp = list("function", function(node)
					strptime(sapply(getNodeSet(node, "//published"), xmlValue),
							format = "%Y-%m-%dT%H:%M:%S",
							tz = "GMT")),
		Updated = list("function", function(node)
					strptime(sapply(getNodeSet(node, "//updated"), xmlValue),
							format = "%Y-%m-%dT%H:%M:%S",
							tz = "GMT")),
		Source = list("node", "//twitter:source"),
		Language = list("node", "//twitter:lang"),
		Geo = list("node", "//twitter:geo"),
		ID = list("node",  "//id")),
	doc = PlainTextDocument())


#' Read content from Google...Source
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readGoogle <- readWebXML(spec = list(
		Heading = list("node", "//title"),
		DateTimeStamp = list("function", function(node){
					loc <- Sys.getlocale("LC_TIME")
					Sys.setlocale("LC_TIME", "C")
					val <- sapply(getNodeSet(node, "//pubDate"), xmlValue)
					time <- strptime(val,format = "%a, %d %b %Y %H:%M:%S",tz = "GMT")
					Sys.setlocale("LC_TIME", loc)
					time
				}),
		Origin = list("node", "//link"),
		Description = list("function", function(node){
					val <- sapply(getNodeSet(node, "//item/description"), xmlValue)
					extractHTMLStrip(sprintf("<html>%s</html>", val), asText = T)
				}),
		ID = list("node",  "//guid")),
	doc = PlainTextDocument())

#' Read content from Yahoo RSS Source
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @seealso \code{\link{YahooFinanceSource}} \code{\link{YahooNewsSource}}
#' @noRd
#' @export
readYahoo <- readWebXML(spec = list(
		Heading = list("node", "//title"),
		DateTimeStamp = list("function", function(node){
					loc <- Sys.getlocale("LC_TIME")
					Sys.setlocale("LC_TIME", "C")
					val <- sapply(getNodeSet(node, "//pubDate"), xmlValue)
					time <- strptime(val,format = "%a, %d %b %Y %H:%M:%S",tz = "GMT")
					Sys.setlocale("LC_TIME", loc)
					time
				}),
		Origin = list("node", "//link"),
		Description = list("node", "//item/description"),
		ID = list("node",  "//guid")),
	doc = PlainTextDocument())


#' Read content from GoogleBlogSearchSource
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readGoogleBlogSearch <- readWebXML(spec=list(
		Heading = list("node", "//title"),
		DateTimeStamp = list("function", function(node){
					loc <- Sys.getlocale("LC_TIME")
					Sys.setlocale("LC_TIME", "C")
					val <- sapply(getNodeSet(node, "//dc:date"), xmlValue)
					time <- strptime(val,format = "%a, %d %b %Y %H:%M:%S",tz = "GMT")
					Sys.setlocale("LC_TIME", loc)
					time
				}),
		Origin = list("node", "//link"),
		ID = list("node", "//link"),
		Description = list("node", "//item/description"),
		Publisher = list("node","//dc:publisher"),
		Author = list("node","//dc:creator")),
	doc = PlainTextDocument())


#' Read content from YahooInplaySource
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readYahooInplay <- readWebHTML(spec = list(
		Heading = list("node", "//b[1]"),
		ID = list("node", "//b[1]"),
		Content = list("node", "//p"),
		DateTimeStamp = list("function", function(node){
					val <- unlist(getNodeSet(node, "//b[1]", fun = xmlValue))
					substr(val, 1, regexpr("\\s", val)-1)
				}),
		Ticker  = list("node", "//p/b/a")),
	doc = PlainTextDocument())




#' Read content from ReutersNewsSource
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readReutersNews <- readWebXML(spec = list(
				Heading = list("node", "//title"),
				DateTimeStamp = list("function", function(node){
							loc <- Sys.getlocale("LC_TIME")
							Sys.setlocale("LC_TIME", "C")
							val <- sapply(getNodeSet(node, "//pubDate"), xmlValue)
							time <- strptime(val,format = "%a, %d %b %Y %H:%M:%S",tz = "GMT")
							Sys.setlocale("LC_TIME", loc)
							time
						}),
				Origin = list("node", "//link"),
				Description = list("function", function(node){
							val <- sapply(getNodeSet(node, "//item/description"), xmlValue)
							extractHTMLStrip(sprintf("<html>%s</html>", val), asText = T)
						}),
				ID = list("node",  "//guid"),
				Category = list("node", "//category")),
		doc = PlainTextDocument())


#' Read content from GoogleReaderSource
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readGoogleReader <- readWebXML(spec = list(
				Heading = list("node", "//entry/title"),
				DateTimeStamp = list("function", function(node){
							val <- sapply(getNodeSet(node, "//entry/published"), xmlValue)
							time <- strptime(val,format = "%Y-%m-%dT%H:%M:%S",tz = "GMT")
							time
						}),
				Author = list("node", "//entry/author/name"),
				Origin = list("attribute", "//entry/link[@rel='alternate']/@href"),
				Description = list("function", function(node){
							val <- sapply(getNodeSet(node, "//entry/content"), xmlValue)
							tryCatch(extractHTMLStrip(sprintf("<html>%s</html>", val), asText = T), error = function(e) "")
						}),
				Source = list("node", "//entry/source/title"),
				ID = list("node",  "//entry/id")),
		doc = PlainTextDocument())



