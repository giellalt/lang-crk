#!/bin/sh

# rewrite-rule-test.sh 1: XFSCRIPT rule file (path)

# LEXC forms from standard input, so multiple words can be processed
# Input must have one LEXC form per line to be processed,
# as well as an optional second space-separated form representing the
# final outcome.

gawk -v XFSCRIPT=$1 'BEGIN { xfscript=XFSCRIPT;
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
{ input=$1; lexc=$1;
  gsub("0","",input);
  if($2!="")
    { target=$2;
      gsub("0","",target);
    }
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
  output=$2;
  gsub("[<>]","",output);
  if(target!="")
    if(output==target)
      success="(=)";
    else
      success="(<> "target")";
  else
      success="";
  print "1-"n": "lexc" -> "$2" "success;
  print "";
}'

