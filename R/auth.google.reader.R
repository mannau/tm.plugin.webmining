#' @title Authentification and token retrieval from the Google Reader web service
#' @description Function to retrieve token string for the Google Reader web service. 
#' String can subsequently be used with \code{\link{GoogleReaderSource}} 
#' @param email email address, e.g. <firstname.lastname@@gmail.com>
#' @param password password for Google Account
#' @param get.curl.opts determines if RCurl options object (\code{\link{curlOptions}}) should be returned.
#' @return Character if get.curl.opts is FALSE or curlOpts if get.curl.opts is TRUE
#' @seealso \code{\link{GoogleReaderSource}}
#' @export 
auth.google.reader <- function(email = readline("Email:"), password= readline("Password:"), get.curl.opts = F){
	curlHandle = getCurlHandle(cookiefile="rcookies", ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
	x = postForm("https://www.google.com/accounts/ClientLogin",
			accountType="GOOGLE",
			service="reader",
			Email=email,
			Passwd=password,
			source="tm.plugin.webmining",
			curl = curlHandle)
	gtoken = unlist(strsplit(x, "\n"))
	parsed.gtoken <- unlist(strsplit(gtoken[3], "Auth="))
	
	auth.token <- ""
	if (length(parsed.gtoken) >= 2) {
		auth.token <- unlist(strsplit(gtoken[3], "Auth="))[[2]]
	} else {
		stop("Authentication failed.")
	}
	
	if(get.curl.opts){
		google.auth <- paste("GoogleLogin auth=", auth.token, sep='')
		curlOpts <- curlOptions(	
				followlocation = TRUE, 
				httpheader=c("Authorization"=google.auth),
				maxconnects = 1,
				maxredirs = 10,
				timeout = 120,
				connecttimeout = 30,
				ssl.verifyhost=FALSE, 
				ssl.verifypeer=FALSE)
		return(curlOpts)
	}else{
		return(auth.token)
	}
}
