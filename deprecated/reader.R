# TODO: Add comment
# 
# Author: mario
###############################################################################


#' Read content from BingSource
#' @importFrom XML getNodeSet
#' @importFrom XML xmlValue
#' @noRd
#' @export
readBing <- readWebXML(spec = list(Heading = list("node", "/*/news:Title"),
				Origin = list("node", "/*/news:Url"),
				DateTimeStamp = list("function", function(node)
							strptime(sapply(getNodeSet(node, "/*/news:Date"), xmlValue),
									format = "%Y-%m-%dT%H:%M:%SZ",
									tz = "GMT")),
				Author = list("node", "/*/news:Source"),
				Description = list("node", "/*/news:Snippet"),
				BreakingNews = list("node", "/*/news:BreakingNews"),
				ID = list("node", "/*/news:Url")),
		doc = PlainTextDocument())

#readSECEdgar <- readWebXML(spec = list(
#				Heading = list("node", "//title"),
#				DateTimeStamp = list("function", function(node)
#							strptime(sapply(getNodeSet(node, "//updated"), xmlValue),
#									format = "%Y-%m-%dT%H:%M:%S",
#									tz = "GMT")),
#				Origin = list("attribute", "//link/@href"),
#				Description = list("function", function(node){
#							val <- sapply(getNodeSet(node, "//summary"), xmlValue)
#							extractHTMLStrip(val, asText = TRUE)
#						}),
#				ID = list("node",  "//id")),
#		doc = PlainTextDocument())
