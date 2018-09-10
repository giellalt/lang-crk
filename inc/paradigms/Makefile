# Generates all the layout files from the CSVs.
#
# Usage:
#
# 	make
#
# (Yes! That's it!)
#
#
# Tests paradigm and layout files for a cavalcade of potential issues.
#
# Usage:
#
# 	make check
#
# Author: Eddie Antonio Santos <easantos@ualberta.ca>

LAYOUTS = $(patsubst %.csv,%,$(wildcard *.layout.csv))

XARGS = xargs -t

all: layouts

# Depends on all of the layout files, created from .csv files.
layouts: $(LAYOUTS)

# Do some sanity checks for the paradigm and layout files.
check: check-paradigms check-layouts
check-all: check check-paradigm-generation

check-paradigms: check-paradigm-uniqueness
check-layouts: check-layout-matches check-tooltips

# Fails if there are duplicate entries in any of the paradigm files.
check-paradigm-uniqueness:
	@echo $(wildcard *.paradigm) | $(XARGS) -n1 ./ensure-unique-paradigm
	@echo "$$(tput setaf 2)Paradigm files OK!$$(tput sgr0)"

# Fails if there are missing tooltips in the paradigm files.
check-tooltips:
	@echo $(wildcard *.layout.csv) | $(XARGS) -n1 ./verify-layout-tooltips.sh
	@echo "$$(tput setaf 2)Satisfactory tooltips defined in all layout files!$$(tput sgr0)"

# Fails if there are duplicates or no matches in the layout files.
check-layout-matches:
	@echo $(wildcard *.paradigm) | $(XARGS) -n1 ./verify-paradigm-layout.sh
	@echo "$$(tput setaf 2)All entries in the paradigms match exactly one cell!$$(tput sgr0)"

check-paradigm-generation: GTLANG_crk=$(shell realpath ../../)
check-paradigm-generation:
	./verify-all-paradigm-generation paradigm-test-pairs.tsv $(wildcard *.paradigm)
	@echo "$$(tput setaf 2)Succesfully generated all cells!$$(tput sgr0)"

# WARNING! This really only works on Eddie's laptop :/
copy: $(wildcard *.layout) $(wildcard *.paradigm)
	cp -f $^ ~/Projects/itwewina/neahtta/configs/language_specific_rules/paradigms/crk/

# Convert a .csv layout file into a forma suitable for NDS/itwêwina.
%.layout: %.layout.csv
	./paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:

.PHONY: all layouts check check-paradigms check-layouts check-all copy
