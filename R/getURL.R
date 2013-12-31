#' @title Copy of RCurl:::getURL() including a little bugfix for the .encoding parameter.
#' @description For the full description of getURL refer to \code{\link[RCurl]{getURL}}.
#' @param url see \code{\link[RCurl]{getURL}}
#' @param .opts see \code{\link[RCurl]{getURL}}
#' @param write see \code{\link[RCurl]{getURL}}
#' @param curl see \code{\link[RCurl]{getURL}}
#' @param async see \code{\link[RCurl]{getURL}}
#' @param .encoding see \code{\link[RCurl]{getURL}}
#' @param .mapUnicode see \code{\link[RCurl]{getURL}}
#' @param ... see \code{\link[RCurl]{getURL}}
#' @seealso \code{\link[RCurl]{getURL}}
#' @export 
getURL <- 
function(url, ..., .opts = list(), write = basicTextGatherer(.mapUnicode = .mapUnicode), curl = getCurlHandle(),
		async = length(url) > 1, .encoding = integer(), .mapUnicode = TRUE)
{
#    write = getNativeSymbolInfo("R_curl_write_data", PACKAGE = "RCurl")$address
	
	url = as.character(url)
	
	if(async) {
		if(missing(write))
			write = multiTextGatherer(url)
		# FIXME: Parameter .encoding inserted!
		return(getURIAsynchronous(url, ..., .opts = .opts, write = write, curl = curl, .encoding = .encoding)) 
	}
	
	if(length(url) > 1) {
		# typically will go to async. But if async is explicitly set to FALSE
		# then the caller wants to use a serialized sequence of requests and collect
		# the results into a single string if write is specified and as a character vector
		# of strings otherwise.
		
		# If write wasn't specified, then
		dupWriter = FALSE
		if(missing(write))
			dupWriter = TRUE
		return(sapply(url, function(u) {
							if(dupWriter)
								write = basicTextGatherer()
							getURI(u, ..., .opts = .opts, write = write, curl = curl, async = FALSE, .encoding = .encoding)
						}))
	}
	
	returnWriter = FALSE
	if(missing(write) || inherits(write, "RCurlCallbackFunction")) {
		writeFun = write$update
	} else {
		writeFun = write
		returnWriter = TRUE
	}
	
	# Don't set them, just compute them.
	opts = curlOptions(URL = url, writefunction = writeFun, ..., .opts = .opts)
	
	status = curlPerform(curl = curl, .opts = opts, .encoding = .encoding)
	
	if(returnWriter)
		return(write)
	
	write$value()
}

