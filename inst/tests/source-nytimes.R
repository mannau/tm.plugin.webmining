# TODO: Add comment
# 
# Author: mario
###############################################################################

context("NYTimesSource")

test_that("NYTimesSource",{
	
	lengthcorp <- 100
	
	if(!exists(as.character(substitute(nytimes_appid)))){
		cat("No Variable nytimes_appid provided. Skipping Test...\n")
		return()
	}
	
	
	testcorp <- WebCorpus(NYTimesSource("Microsoft", appid = nytimes_appid))
	# Check Corpus object
	expect_that(length(testcorp), equals(lengthcorp))
	expect_that(class(testcorp), equals(c("WebCorpus","VCorpus","Corpus","list")))
	
	# Check Content
	#expect_that(all(sapply(testcorp, nchar) > 0), is_true())
	contentratio <- length(which(sapply(testcorp, nchar) > 0)) / length(testcorp)
	expect_that(contentratio > 0.5, is_true())
	
	# Check Meta Data
	datetimestamp <- lapply(testcorp, function(x) meta(x, "DateTimeStamp"))
	expect_that(all(sapply(datetimestamp, function(x) class(x)[1] == "POSIXlt")), is_true())
	
	description <- lapply(testcorp, function(x) meta(x, "Description"))
	expect_that(all(sapply(description, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(description, nchar) > 0), is_true())
	
	heading <- lapply(testcorp, function(x) meta(x, "Heading"))
	expect_that(all(sapply(heading, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(heading, nchar) > 0), is_true())
	
	id <- lapply(testcorp, function(x) meta(x, "ID"))
	expect_that(all(sapply(id, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(id, nchar) > 0), is_true())
	
	language <- lapply(testcorp, function(x) meta(x, "Language"))
	expect_that(all(sapply(language, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(language, nchar) > 0), is_true())
	
	origin <- lapply(testcorp, function(x) meta(x, "Origin"))
	expect_that(all(sapply(origin, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(origin, nchar) > 0), is_true())
	
	testcorp <- testcorp[1:10]
	testcorp <- corpus.update(testcorp)
	expect_that(length(testcorp) >= lengthcorp, is_true())
	
	cat(" | Contentratio: ", sprintf("%.0f%%", contentratio * 100))
})

