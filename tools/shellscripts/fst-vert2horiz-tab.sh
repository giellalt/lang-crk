#!/bin/sh

# cat ~/altlab/crk/corpora/ahenakew_wolfart.vrt | egrep -v '^<' | hfst-optimized-lookup -q src/analyser-gt-norm.hfstol |

gawk 'BEGIN { FS="\n"; RS=""; }
{ split($1,f,"\t");
  printf "%s", f[1];
  if(f[3]=="+?")
    printf "\t%s%s", f[2], f[3];
  else
    for(i=1; i<=NF; i++)
       { split($i,f,"\t");
         printf "\t%s", f[2];
       }
  printf "\n";
}'

