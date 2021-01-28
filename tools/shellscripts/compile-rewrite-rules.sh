#!/bin/sh

# compile-rewrite-rules.sh 1: XFSCRIPT (path to)

# echo /Users/arppe/giella/langs/crk/src/fst/phonology.xfscript |

echo '' |
    
gawk -v XFSCRIPT=$1 'BEGIN { xfscript=XFSCRIPT; 
while((getline < xfscript)!=0)
  { if(index($0,"regex")!=0)
      { rx=1; regex=""; }
    if(rx)
      regex=regex" "$0;
    if(index($0,";")!=0)
      rx=0;
  }
sub("^[ ]*(read )regex.*\\[[ ]*","",regex);
sub("[ ]*\\].*;.*$","",regex);
n=split(regex,rule,"[ ]*\\.o\\.[ ]*");
cmd="-e \"source "xfscript"\"";
for(i=1; i<=n; i++)
   cmd=cmd" -e \"clear stack\" -e \"push "rule[i]"\" -e \"save stack "rule[i]".foma\"";
}
END { system("foma "cmd" -e \"quit\""); }'
