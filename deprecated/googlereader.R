# TODO: Add comment
# 
# Author: mario
###############################################################################




token <- auth.google.reader()
feed <- "http://feeds.feedburner.com/RBloggers"
test <- WebCorpus(GoogleReaderSource(feed, auth.token = token, params = list(n = 100)))
