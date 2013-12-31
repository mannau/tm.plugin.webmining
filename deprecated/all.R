# TODO: Add comment
# 
# Author: mario
###############################################################################

#To run all examples of this demo, please set the folling variables with
#according Application-ID values:
#nytimes_appid,  bing_appid
#TODO use testit to run test appropriately

library(tm.plugin.webmining)
#### retrieve corpus from Google Finance News for Microsoft stock
test1corp <- WebCorpus(GoogleFinanceSource("NASDAQ:MSFT"))
test1corp <- test1corp[1:10]
test1corp <- corpus.update(test1corp)

#inspect first 10 elements of retrieved corpus
inspect(test1corp[1:10])

#check meta data of first element in the corpus
meta(test1corp[[1]])


#### retrieve corpus from Twitter Search API for the search Term 'Microsoft'
#update ok, strange warning
test2corp <- WebCorpus(TwitterSource("Microsoft"))
test2corp <- test2corp[1:10]
test2corp <- corpus.update(test2corp)


#check meta data of first element in the corpus
meta(test1corp[[1]])


#test ok
test3corp <- WebCorpus(NYTimesSource("Microsoft", appid = nytimes_appid))
test3corp <- test3corp[1:10]
test3corp <- corpus.update(test3corp)


#test ok
test4corp <- WebCorpus(YahooInplaySource())
test4corp <-  test4corp[1:10]
test4corp <- corpus.update(test4corp)


#test ok
test5corp <- WebCorpus(YahooFinanceSource("MSFT"))
test5corp <-  test5corp[1:10]
test5corp <- corpus.update(test5corp)


#test ok
test6corp <- WebCorpus(GoogleBlogSearchSource("Microsoft"))
test6corp <-  test6corp[1:10]
test6corp <- corpus.update(test6corp)

#test ok
test7corp <- WebCorpus(BingSource("Microsoft", appid = bing_appid))
test7corp <-  test7corp[1:10]
test7corp <- corpus.update(test7corp)


#test ok
test8corp <- WebCorpus(YahooNewsSource("Microsoft"))
test8corp <-  test8corp[1:10]
test8corp <- corpus.update(test8corp)


#test ok
test9corp <- WebCorpus(GoogleNewsSource("Microsoft"))
test9corp <-  test9corp[1:10]
test9corp <- corpus.update(test9corp)


#test ok
test10corp <- WebCorpus(ReutersNewsSource("businessNews"))
test10corp <-  test10corp[1:5]
test10corp <- corpus.update(test10corp)

