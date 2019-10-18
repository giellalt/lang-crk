#!/bin/sh

# add-cw-lemma-derivation.sh

# cat ~/giella/art/corp/crk/ahenakew_wolfart_MGS_tab-sep-anls_freq-sorted.txt |
# Input: Morphosyntactically analyzed and disambiguated file, with a single
# analysis in the third column.

# Extracting the lemma and printing that

gawk '{ match($3,"([^\\+]+)\\+V",s); if(s[1]!="") print s[1]; }'  |

# Removing duplicates

uniq |

# The file: Wolvengrey_crk2eng_191017.csv
# contains the latest contents of CW in a CSV format.
# The file/name can be updated as needed.

gawk -F"\t" 'BEGIN { while((getline < "Wolvengrey_crk2eng_191017.csv")!=0)
   { if(index($0,"\\mrp")!=0)
       for(i=1; i<=NF; i++)
          if($i=="\\mrp")
            mrp_col=i;
     gsub("ý","y",$1);
     gsub("[ ]*;;[ ]*"," ",$mrp_col);
     gsub("/","",$mrp_col); drv[$1]=$mrp_col;
   }
}
{ if($1 in drv)
    { n=split(drv[$1],mrf," ");
      if(!($1 in lemma))
        lemma[$1]=$1;
      for(i=1; i<=n; i++)
         { if(!(mrf[i] in mrfs))
             mrfs[mrf[i]]=mrf[i];
           if(lemma_drv[$1, mrf[i]]*1==0)
             lemma_drv[$1, mrf[i]]=1;
         }
    }
}
END { printf "LEMMA";
   for(j in mrfs)
      printf "\t%s", mrfs[j];
    printf "\n";
    for(i in lemma)
       { printf "%s", i;
         for(j in mrfs)
            printf "\t%i", lemma_drv[i, j]*1;
         printf "\n";
       }
}'