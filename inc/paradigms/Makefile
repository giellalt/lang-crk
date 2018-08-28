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
	nouns-an-basic.layout \
	nouns-an-extended.layout \
	nouns-an-full.layout \
	nouns-in-basic.layout \
	nouns-in-extended.layout \
	nouns-in-full.layout \
	verb-ta-full.layout \
	verbs-ta-basic.layout \
	verbs-ta-basic2.layout \
	verbs-ta-extended.layout
		

all: $(LAYOUTS)

%.layout: %.layout.csv 
	./paradigm-csv2layout.sh $< >$@


# ./paradigm-csv2layout.sh might fail, so delete failed results.
.DELETE_ON_ERROR:
