#!/bin/sh

# verify-layout-tooltips.sh

# Usage:
#     verify-layout-tooltips.sh LAYOUT_FILE
#     E.g.
#     verify-layout-tooltips.sh verb-ta.full.layout

cat $1 |

gawk 'BEGIN { body=0; tooltips=0; err=0; }
{ if(index($0,"eng:")!=0)
    tooltips=1;
#  if(match($0,"\"[^\"]+\":[ \t]+\"[^[\"]+\"]")!=0)
   if(tooltips)
    { split($0,f,":[ \t]+");
      sub("^[ \t]+","",f[1]);
      sub(":$","",f[1]);
      if(f[1] in tt)
        print "Duplicate tooltip - line: #"NR": "$0;
      else
        tt[f[1]]=f[2];
    }
  if(body)
    { # for(t in tt)
      #    print t, tt[t];
      nf = split($0,f,"[ \t]*\\|[ \t]*");
      for(i=1; i<=nf; i++)
         { # sub("^[:space:]*[:][:space:]*","",f[i]); 
           # sub("[:space:]*[:][:space:]*$","",f[i]);
           sub("^[ \t]*:[ \t]*","",f[i]);
           sub("[ \t]*:[ \t]*$","",f[i]);
           # print i, length(f[i]), f[i];
           if(index(f[i],"\"")!=0 && length(f[i])>0)
             if(!(f[i] in tt))
               { err++;
                 printf "Potentially missing tooltip - line: #%i : %s", NR, f[i];
                 n_quotes=gsub("\"","\"",f[i]);
                 if(match(f[i],"^\"[^\"]+\"$")==0 || index(n_quotes/2,".5")!=0)
                   printf " + Unmatched double quotes (n=%i)", n_quotes*1;
                 printf "\n";
               }
         }
    }
  if(match($0,"^[-][-]")!=0)
    { body=1; tooltips=0; }
}'

