# TODO: Add comment
# 
# Author: mario
###############################################################################


library(tm.plugin.webmining)
outdir <- "/data/Research/google_large_scale"
constituents.nasdaq.yahoo <- 
		c(
				"AAPL",
				"ADBE",
				"ADP",
				"ADSK",
				"AKAM",
				"ALTR",
				"ALXN",
				"AMAT",
				"AMGN",
				"AMZN",
				"APOL",
				"ATVI",
				"AVGO",
				"BIDU",
				"BIIB",
				"BMC",
				"CA",
				"CELG",
				"CERN",
				"CHKP",
				"CHRW",
				"CMCSA",
				"COST",
				"CSCO",
				"CTRP",
				"CTSH",
				"CTXS",
				"DELL",
				"DLTR",
				"DTV",
				"EA",
				"EBAY",
				"ESRX",
				"EXPD",
				"EXPE",
				"FAST",
				"FFIV",
				"FISV",
				"FLEX",
				"FOSL",
				"FSLR",
				"GILD",
				"GMCR",
				"GOLD",
				"GOOG",
				"GRMN",
				"HANS",
				"HSIC",
				"INFY",
				"INTC",
				"INTU",
				"ISRG",
				"KLAC",
				"LIFE",
				"LINTA",
				"LLTC",
				"LRCX",
				"MAT",
				"MCHP",
				"MRVL",
				"MSFT",
				"MU",
				"MXIM",
				"MYL",
				"NFLX",
				"NTAP",
				"NUAN",
				"NVDA",
				"NWSA",
				"ORCL",
				"ORLY",
				"PAYX",
				"PCAR",
				"PCLN",
				"PRGO",
				"QCOM",
				"RIMM",
				"ROST",
				"SBUX",
				"SHLD",
				"SIAL",
				"SIRI",
				"SNDK",
				"SPLS",
				"SRCL",
				"STX",
				"SYMC",
				"TEVA",
				"VMED",
				"VOD",
				"VRSN",
				"VRTX",
				"WCRX",
				"WFM",
				"WYNN",
				"XLNX",
				"XRAY",
				"YHOO")

constituents.nasdaq.yahoo <- paste("NASDAQ", constituents.nasdaq.yahoo, sep = ":")

const <- constituents.nasdaq.yahoo[1]

for(const in constituents.nasdaq.yahoo){
	cat("Retrieving ", const, " ... \n")
	outfile <- paste(outdir, "/", const, ".rda", sep = "")
	if(!file.exists(outfile)){
		corpus <- WebCorpus(GoogleFinanceSource(const))
		save(corpus, file = outfile)
	}else{
		load(file = outfile)
		tryCatch({	corpus <- corpus.update(corpus, retryempty = F)
					save(corpus, file = outfile)
					#cat("Done\n")
				},error = function(e) print(e))
	}
}



