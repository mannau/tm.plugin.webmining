
library(tm.plugin.webmining)
library(testthat)


#testcorp <- WebCorpus(GoogleBlogSearchSource("Microsoft")) # should fail


xmlparse <- function(...){
	encoding <- switch(.Platform$OS.type,
					unix = "UTF-8",
					windows = "latin1")
	xmlInternalTreeParse(..., encoding = encoding)
}


query <- "Microsoft"
params = list(hl = "en", q = query, ie = "utf-8", num = 100, output = "rss")
feed <- "http://blogsearch.google.com/blogsearch_feeds"
fq <- feedquery(feed, params)

curlOpts = curlOptions(	followlocation = TRUE, 
		maxconnects = 20,
		maxredirs = 10,
		timeout = 30,
		connecttimeout = 30)

test <- getURL(fq, .opts = curlOpts)


#zz <- file("virtual", "w")  # open an output file connection
#cat("TITLE extra line", "2 3 5 7", "", "11 13 17", file = zz, sep = "\n")
#cat("One more line\n", file = zz)
#close(zz)

tree <- xmlparse(test, asText = T)

#better

#tree <- xmlInternalTreeParse(test, asText = T, encoding = "latin1")

#Encoding(x)
#Encoding(x) <- value
#enc2native(x)
#enc2utf8(x)



