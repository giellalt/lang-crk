#!/bin/sh

# wolvengrey2csv.sh

# Takes as input AEW CW content in Toolbox format, 
# with records separated by spaces and fields per
# individual lines, and fields labeled as \xxx,
# and converts that in CSV format, with one
# record per line, and fields separated by tabs.

# cat CreeDict-x |

# Removal of possible MS/Win CR characters.

tr -d '\r' |

gawk 'BEGIN { FS="\n"; RS=""; OFS="\t"; ORS="\n"; }
NR>=2 { for(i=1; i<=NF; i++)
           { n=split($i,f," "); value="";
             for(j=2; j<=n-1; j++)
                value=value f[j]" ";
             if(n>1)
                value=value f[n];
             if(!(f[1] in cols))
               { cols[f[1]]=f[1];
                 col[++ncol]=f[1];
               }
             if(cw[NR, f[1]]!="")
               cw[NR, f[1]]=cw[NR, f[1]]" ;; "value;
             else
               cw[NR, f[1]]=value;
           }
} END { for(j=1; j<ncol; j++)
           printf "%s\t", col[j];
        printf "%s\n", col[ncol];
           for(i=2; i<=NR; i++)
              { for(j=1; j<ncol; j++)
                   printf "%s\t", cw[i, col[j]];
                printf "%s\n", cw[i, col[ncol]];
              }
}'

# Last output CSV version of AEW CW source file.

#  > Wolvengrey_crk2eng_191017.csv


