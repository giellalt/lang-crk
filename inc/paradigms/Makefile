# Generates all the layout files from the CSVs.
#
# Usage:
#
# 	make
#
# (Yes! That's it!)
#
# Author: Eddie Antonio Santos <easantos@ualberta.ca>

LAYOUTS = \
	noun-in-basic.layout \
	noun-in-full.layout \
	noun-an-basic.layout \
	noun-an-extended.layout \
	noun-an-full.layout \
	noun-in-basic.layout \
	noun-in-extended.layout \
	noun-in-full.layout \
	verb-ta-full.layout \
	verb-ta-basic.layout \
	verb-ta-basic2.layout \
	verb-ta-extended.layout
		

all: $(LAYOUTS)

%.layout: %.layout.csv 
	./paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:
