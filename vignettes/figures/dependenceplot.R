
library(diagram)

outpath <- "/home/mario/Dropbox/Private/Diplomarbeit/Annau/Code/sentiment_rforge/pkg/tm.plugin.webmining/vignettes/figures"
outfile <- "dependenceplot.pdf"
outfile.full <- paste(outpath, outfile, sep = "/")

pdf(outfile.full)

labels <- c("tm.plugin.webmining", "tm", "boilerpipeR",  "RCurl" ,"XML", "RJSONIO")
par(mar=c(0,0,0,0))
plot.new()
elpos<-coordinates (c(1,5))
treearrow(from=elpos[1,],to=elpos[2:5,],arr.side=2,arr.pos=0.7,path="H")
treearrow(from=elpos[1,],to=elpos[6,],arr.side=2,arr.pos=0.7,path="H", lty = 2)
textrect (elpos[1,],0.2,0.05,lab=labels[1],cex=1, , shadow.size = 0, font = 2)
for ( i in 2:6){
	textrect (elpos[i,],0.1,0.05,lab=labels[i],cex=1, shadow.size = 0)
} 
dev.off()
