# Makefile

PACKAGE_NAME="tm.plugin.webmining"
SOURCE_FILES=DESCRIPTION R/*.R inst/*

GENERATED_BY_ROXYGEN=NAMESPACE *.Rd
PACKAGE_VERSION:=$(shell cat DESCRIPTION | sed -n -e 's/Version: //p')
R_LIBRARY_PATH:=$(shell echo "invisible(cat(.libPaths()[1],sep='','\n'))" | R --vanilla --slave)
BUILT_PACKAGE:=$(PACKAGE_NAME)_$(PACKAGE_VERSION).tar.gz
INSTALLED_PACKAGE:=$(R_LIBRARY_PATH)/$(PACKAGE_NAME)

.PHONY: check install install-dependencies uninstall clean ci

all: $(BUILT_PACKAGE)

check: $(BUILT_PACKAGE)
	@R CMD check --no-manual --no-multiarch $(BUILT_PACKAGE)

install: $(INSTALLED_PACKAGE)

install-dependencies:
	@installFromCRAN tm RCurl XML
	@# macxResearch is used in examples for plotting
	@# macxAccount needs to be installed, since macxResearch depends on it.
	@ installFromRepo opensource/boilerpipeR

uninstall:
	@if [ -d $(INSTALLED_PACKAGE) ]; then \
	R CMD REMOVE -l $(R_LIBRARY_PATH) $(PACKAGE_NAME); fi

clean:
	@rm -f NAMESPACE
	@rm -rf man
	@rm -rf build.log
	@rm -f $(PACKAGE_NAME)*.tar.gz
	@rm -rf $(PACKAGE_NAME).Rcheck

$(GENERATED_BY_ROXYGEN):
	@# We generate all help pages with roxygen and do not mix generated and manually
	@# created pages. Thus, we remove all help pages prior to running roxygen,
	@# in order to remove 'dead' pages which were dropped or have been renamed.
	@rm -rf NAMESPACE man/*
	@echo 'library("roxygen2"); roxygenize(".", roclets=c("namespace","rd"))' | R --slave --vanilla

$(BUILT_PACKAGE): $(GENERATED_BY_ROXYGEN) $(SOURCE_FILES)
	@R CMD build .

$(INSTALLED_PACKAGE): $(BUILT_PACKAGE)
	@R CMD INSTALL --no-multiarch $(BUILT_PACKAGE)


# executed by jenkins (continuous integration server) after every commit
ci:
	@echo "\n***** UNINSTALL"; make uninstall
	@echo "\n***** CLEAN"; make clean
	@echo "\n***** INSTALL DEPENDENCIES"; make install-dependencies
	@echo "\n***** INSTALL"; make install
	@echo "\n***** CHECK"; make check 2>&1 | tee build.log
	@# If a check fails, R CMD check prints the words WARNING or ERROR to the
	@# console, but does not throw an error. Thus we have to throw an error
	@# manually to let the ci server know that the make target failed.
	@if grep -s -w 'WARNING\|ERROR' build.log; then echo 'WARNING|ERROR occurred'; exit 1; fi

