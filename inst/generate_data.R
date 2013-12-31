# TODO: Add comment
# 
# Author: mario
###############################################################################

library(tm.plugin.webmining)

yahoonews <- WebCorpus(YahooNewsSource("Microsoft"))
yahoonews <- tm_map(yahoonews, removeNonASCII)
save(yahoonews, file = "/home/mario/Dropbox/Private/workspace/sentiment/pkg/tm.plugin.webmining/data/yahoonews.rda")

# email and password must first be set
token <- auth.google.reader(email="<username>@gmail.com", password="<password>")
rbloggers <- WebCorpus(GoogleReaderSource("http://feeds.feedburner.com/RBloggers", token, params = list(n = 1000)), 
		postFUN = NULL)
rbloggers <- tm_map(rbloggers, removeNonASCII)
save(rbloggers, file = "/home/mario/Dropbox/Private/workspace/sentiment/pkg/tm.plugin.webmining/data/rbloggers.rda")
