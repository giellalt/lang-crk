#!/bin/sh

# toolbox2tsv.sh

# Input: CreeDict-x
# Output: ~/Google\ Drive/CreeFST/Wolvengrey/Wolvengrey_crk2eng_200123.csv

# Removing Windows CR characters

tr -d '\r' |

# Turning Toolbox field-per-line format to TSV format

gawk 'BEGIN { FS="\n"; RS=""; }
NR>=2 { for(i=1; i<=NF; i++) # Excluding the first record from the CW source
           if(index($i,"\\")==1) # Toolbox field/line starting with back-slash
             { split($i,s," "); # s[1] is Toolbox label for field
               sub("^[^ ]+[ ]?","",$i);
               if(f[NR-1, s[1]]!="")
                 f[NR-1, s[1]]=f[NR-1, s[1]]" ;; "$i;
               else
                 f[NR-1, s[1]]=$i;
               if(!(s[1] in fff))
                 { fff[s[1]]=++nf;;
                   ff[nf]=s[1];
                 }
             }
           else # Toolbox field/line not starting with back-slash, belonging to the previous line
             f[NR-1, s[1]]=f[NR-1, s[1]]" "$i;
      }
END { for(j=1; j<=nf-1; j++)
         printf "%s\t", ff[j];
      printf "%s\n", ff[nf];
      for(i=1; i<=NR-1; i++)
         { for(j=1; j<=nf-1; j++)
              printf "%s\t", f[i, ff[j]];
           printf "%s\n", f[i, ff[nf]];
         }
}'
