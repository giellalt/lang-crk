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

layouts: $(LAYOUTS)

# Fails if there are duplicate entries in any of the paradigm files.
check:
	@echo $(wildcard *.paradigm) | xargs -n1 ./ensure-unique-paradigm
	
# Convert a .csv layout file into a forma suitable for NDS/itwêwina.
%.layout: %.layout.csv 
	./paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:

.PHONY: all layouts check
