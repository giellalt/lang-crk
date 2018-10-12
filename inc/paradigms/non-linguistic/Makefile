# Generates all the layout files from the CSVs.
#
# Usage:
#
# 	make
#
# This is $GTLANG_crk/inc/paradigms/Makefile
# Derived from  $GTLANG_crk/inc/paradigms/non-linguistic/Makefile
#
# Author: Eddie Antonio Santos <easantos@ualberta.ca>

LAYOUTS = $(patsubst %.layout.csv,%.non-linguistic.layout,$(wildcard *.layout.csv))

XARGS = xargs -t

all: layouts

# Depends on all of the layout files, created from .csv files.
layouts: $(LAYOUTS)

# WARNING! This really only works on Eddie's laptop :/
copy: $(LAYOUTS)
	cp -f $^ ~/Projects/itwewina/neahtta/configs/language_specific_rules/paradigms/crk/

# Convert a .csv layout file into a forma suitable for NDS/itwêwina.
%.non-linguistic.layout: %.layout.csv
	../paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:

.PHONY: all layouts copy
