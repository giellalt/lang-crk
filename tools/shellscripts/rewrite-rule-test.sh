#!/bin/sh

# rewrite-rule-test.sh 1: XFSCRIPT rule file (path)

# LEXC forms from standard input, so multiple words can be processed
# Input must have one LEXC form per line to be processed,
# as well as an optional second space-separated form representing the
# final outcome.

gawk -v XFSCRIPT=$1 -v REPORT=$2 'BEGIN { xfscript=XFSCRIPT;
report=REPORT;
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
  if(report=="long")
    { print "REWRITE RULE SEQUENCE:";
      print regex;
      print "";
      print "0 - "input;
      print "---";
    }
    for(i=1; i<=n; i++)
       { flookup="flookup -q -b -i "rule[i]".foma";
         print input |& flookup;
         fflush(); close(flookup, "to");
         flookup |& getline;
         fflush(); close(flookup, "from");
         if($1==$2)
           diff="-";
         else
           diff="|";
         if(report=="long")
           print i" "diff" "$2" - "rule[i];
       # print i" "diff" "rule[i]": "$1" -> "$2;
         input=$2;
       }
     if(report=="long")
       print "---";
  output=$2;
  gsub("[<>]","",output);
  if(target!="")
    if(output==target)
      { success="(=)";
        n_success++;
      }
    else
      { success="(<> "target")";
        n_fail++;
      }
  else
      { success="";
        n_other++;
      }
  print NR": 1-"n": "lexc" -> "$2" "success;
  if(report=="long")
    print "";
}
END { printf "SUMMARY - SUCCESS: %i/%i - FAIL: %i/%i - OTHER: %i/%i\n", n_success, NR, n_fail, NR, n_other, NR;
}'

