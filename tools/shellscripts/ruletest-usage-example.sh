#!/bin/sh

# Script for testing the application of a sequence of rewrite rules

# Creating the FOMA FSTs for each rule

echo "/Users/arppe/giella/langs/crk/src/fst/phonology.xfscript" | gawk '{ xfscript=$0; while((getline < xfscript)!=0) { if(index($0,"regex")!=0) { rx=1; regex=""; } if(rx) regex=regex" "$0; if(index($0,";")!=0) rx=0; } sub("^[ ]*(read )regex.*\\[[ ]*","",regex); sub("[ ]*\\].*;.*$","",regex); n=split(regex,rule,"[ ]*\\.o\\.[ ]*"); cmd="-e \"source "xfscript"\" -e \"clear stack\""; for(i=1; i<=n; i++) cmd=cmd" -e \"push "rule[i]"\" -e \"save stack "rule[i]".foma\""; } END { system("foma "cmd" -e \"quit\""); }'

# egrep '^def(ine) .*->.*;' ../../src/fst/phonology.xfscript | gawk 'BEGIN { cmd="-e \"source /Users/arppe/giella/langs/crk/src/fst/phonology.xfscript\" -e \"clear stack\""; } { cmd=cmd" -e \"push "$2"\" -e \"save stack "$2".foma\""; } END { system("foma "cmd" -e \"quit\""); }'

# Running a string through a sequence of rewrite rules

echo "nit2<maskw>i2m" | gawk 'BEGIN { while((getline < "/Users/arppe/giella/langs/crk/src/fst/phonology.xfscript")!=0) { if(index($0,"regex")!=0) { rx=1; regex=""; } if(rx) regex=regex" "$0; if(index($0,";")!=0) rx=0; } } { sub("^[ ]*(read )regex.*\\[[ ]*","",regex); } { input=$0; sub("[ ]*\\].*;.*$","",regex); n=split(regex,rule,"[ ]*\\.o\\.[ ]*"); gsub("\\.o\\.","->",regex); print "REWRITE RULE SEQUENCE:"; print regex; print "";  for(i=1; i<=n; i++) { flookup="flookup -q -b -i "rule[i]".foma"; print input |& flookup; flookup |& getline; close(flookup); if($1==$2) diff="-"; else diff="|"; print i" "diff" "rule[i]": "$1" -> "$2; input=$2; } print ""; }' | less
