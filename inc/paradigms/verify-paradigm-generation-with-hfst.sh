#!/bin/sh

# Usage:
#     verify-paradigm-generation-with-hfst.sh verb-ta.paradigm wâpamêw PATH-to-NORMATIVE-GENERATOR-HFST

cat $1 |
gawk -v LEMMA=$2 'BEGIN { lemma=LEMMA; }
$0 ~ /\{\{ lemma \}\}/ { sub("\\{\\{ lemma \\}\\}",lemma,$0); print; }' | # less; exit 0;

hfst-lookup -q $3 |

gawk -v PARADIGM_FILE=$1 -v FST_FILE=$3 'BEGIN { FS="\n"; RS=""; err=0;
  print "PARADIGM FILE: "PARADIGM_FILE" - HFST: "FST_FILE; }
index($0,"+?")!=0 { err++; print "Illformed - form #"NR": ",$0; }
END { if(err==0)
        { print "Able to generate: all "NR" form(s).";
          exit 0;
        }
      else
        { print "Unable to generate: "err" out of "NR" form(s).";
          exit 1;
        }
}'
