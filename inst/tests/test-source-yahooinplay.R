# TODO: Add comment
# 
# Author: mario
###############################################################################

context("YahooInPlaySource")

test_that("YahooInPlaySource",{
	
	minlengthcorp <- 1
		
	testcorp <- WebCorpus(YahooInplaySource())
	lengthcorp <- length(testcorp)
	# Check Corpus object
	expect_that(length(testcorp) >= minlengthcorp, is_true())
	expect_that(class(testcorp), equals(c("WebCorpus","VCorpus","Corpus","list")))
	
	# Check Content
	#expect_that(all(sapply(testcorp, nchar) > 0), is_true())
	contentratio <- length(which(sapply(testcorp, nchar) > 0)) / length(testcorp)
	expect_that(contentratio > 0.5, is_true())
	
	# Check Meta Data
	datetimestamp <- lapply(testcorp, function(x) meta(x, "DateTimeStamp"))
	#FIXME: Date should be fixed
	expect_that(all(sapply(datetimestamp, function(x) class(x)[1] == "character")), is_true())
	
	heading <- lapply(testcorp, function(x) meta(x, "Heading"))
	expect_that(all(sapply(heading, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(heading, nchar) > 0), is_true())
	
	id <- lapply(testcorp, function(x) meta(x, "ID"))
	expect_that(all(sapply(id, function(x) class(x)[1] == "character")), is_true())
	expect_that(all(sapply(id, nchar) > 0), is_true())
	
	testcorp <- testcorp[1:length(minlengthcorp)]
	testcorp <- corpus.update(testcorp)
	expect_that(length(testcorp) >= lengthcorp, is_true())
	
	cat(" | Contentratio: ", sprintf("%.0f%%", contentratio * 100))
})

