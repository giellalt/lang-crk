#!/bin/sh

# rewrite-rule-test.sh 1: LEXC-form 2: XFSCRIPT rule file (path)

echo "$1" |

gawk -v XFSCRIPT=$2 'BEGIN { xfscript=XFSCRIPT;
  while((getline < xfscript)!=0)
  { if(index($0,"regex")!=0)
      { rx=1; regex=""; }
    if(rx)
      regex=regex" "$0;
    if(index($0,";")!=0)
      rx=0;
  sub("^[ ]*(read )regex.*\\[[ ]*","",regex);
  sub("[ ]*\\].*;.*$","",regex);
  n=split(regex,rule,"[ ]*\\.o\\.[ ]*");
  }
}
{ input=$0; lexc=$0;
  gsub("\\.o\\.","->",regex);
  print "REWRITE RULE SEQUENCE:";
  print regex;
  print "";
  print "0 - "input;
  print "---";
  for(i=1; i<=n; i++)
     { flookup="flookup -q -b -i "rule[i]".foma";
       print input |& flookup;
       flookup |& getline;
       close(flookup);
       if($1==$2)
         diff="-";
       else
         diff="|";
       print i" "diff" "$2" - "rule[i];
       # print i" "diff" "rule[i]": "$1" -> "$2;
       input=$2;
     }
  print "---";
  print "1-"n": "lexc" -> "$2;
  print "";
}'

