# Generates all the layout files from the CSVs.
# Double-checks that the paradigms have no duplicates. 
#
# Usage:
#
# 	make
#
# (Yes! That's it!)
#
# Author: Eddie Antonio Santos <easantos@ualberta.ca>

LAYOUTS = $(patsubst %.csv,%,$(wildcard *.layout.csv))
		

all: check layouts

# Depends on all of the layout files, creaated from .csv files.
layouts: $(LAYOUTS)

# Do some sanity checks for the paradigm and layout files.
check: check-paradigms check-layouts

# Fails if there are duplicate entries in any of the paradigm files.
check-paradigms:
	@echo $(wildcard *.paradigm) | xargs -n1 ./ensure-unique-paradigm
	@echo "$$(tput setaf 2)Paradigms files OK!$$(tput sgr0)"

# Fails if there are duplicates or no matches in the layout files.
check-layouts:
	@echo $(wildcard *.paradigm) | xargs -n1 sh ./verify-paradigm-layout.sh
	@echo "$$(tput setaf 2)Layout files OK!$$(tput sgr0)"
	
# Convert a .csv layout file into a forma suitable for NDS/itwêwina.
%.layout: %.layout.csv 
	./paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:

.PHONY: all layouts check
