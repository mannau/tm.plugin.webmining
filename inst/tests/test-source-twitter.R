# TODO: Add comment
# 
# Author: mario
###############################################################################
#FIXME: Check at warnings
context("TwitterSource")

test_that("TwitterSource",{
	minlengthcorp <- 1000
		
	testcorp <- WebCorpus(TwitterSource("Microsoft"))
	
	lengthcorp <- length(testcorp)
	# Check Corpus object
	expect_that(length(testcorp) > minlengthcorp, is_true())
	expect_that(class(testcorp), equals(c("WebCorpus","VCorpus","Corpus","list")))
	
	# Check Content
	#expect_that(all(sapply(testcorp, nchar) > 0), is_true())
	contentratio <- length(which(sapply(testcorp, nchar) > 0)) / length(testcorp)
	expect_that(contentratio > 0.5, is_true())
	
	# Check Meta Data
	author <- lapply(testcorp, function(x) meta(x, "Author"))
	expect_that(all(sapply(author, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(author, nchar) > 0), is_true())
			
	datetimestamp <- lapply(testcorp, function(x) meta(x, "DateTimeStamp"))
	expect_that(all(sapply(datetimestamp, function(x) class(x)[1] == "POSIXlt")), is_true())
	
	description <- lapply(testcorp, function(x) meta(x, "Description"))
	expect_that(all(sapply(description, function(x) class(x)[1] == "character")), is_true())
	
	id <- lapply(testcorp, function(x) meta(x, "ID"))
	expect_that(all(sapply(id, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(id, nchar) > 0), is_true())
	
	authoruri <- lapply(testcorp, function(x) meta(x, "AuthorURI"))
	expect_that(all(sapply(authoruri, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(authoruri, nchar) > 0), is_true())
	
	updated <- lapply(testcorp, function(x) meta(x, "DateTimeStamp"))
	expect_that(all(sapply(updated, function(x) class(x)[1] == "POSIXlt")), is_true())
	
	source <- lapply(testcorp, function(x) meta(x, "Source"))
	expect_that(all(sapply(source, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(source, nchar) > 0), is_true())
	
	geo <- lapply(testcorp, function(x) meta(x, "Geo"))
	expect_that(all(sapply(geo, function(x) class(x)[1] == "character")), is_true())
	
	testcorp <- testcorp[1:10]
	testcorp <- corpus.update(testcorp)
	expect_that(length(testcorp) >= lengthcorp, is_true())
	
	cat(" | Contentratio: ", sprintf("%.0f%%", contentratio * 100))
})

