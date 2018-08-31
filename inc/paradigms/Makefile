# Generates all the layout files from the CSVs.
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

check:
	@echo $(wildcard *.paradigm) | xargs -n1 ./ensure-unique-paramdigm
	
# Convert a .csv layout file into a forma suitable for NDS/itwêwina.
%.layout: %.layout.csv 
	./paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:

.PHONY: all layouts check
