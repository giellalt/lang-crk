#!/bin/sh

# wolvengrey-toolbox2fst-tsv.sh

# input: ~/Google\ Drive/CreeFST/Wolvengrey/Wolvengrey_crk2eng_191017.tsv
# output: ~/Google\ Drive/CreeFST/Wolvengrey/Wolvengrey_crk2eng_191017_altlab.tsv

# Postprocess TSV version of CW database to incorporate FST-appropriate stems

gawk -F"\t" '{ lemma=$1; stem=$7;
sub("[-][ ]*$","",stem);
sub("^[ ]*[-]","",stem);
if(match(stem,"w$")!=0 && length(stem)==length(lemma)+1)
  { lemma_vs_stem=stem;
    sub(lemma,"_",lemma_vs_stem);
  }
else
  { lemma_vs_stem=lemma;
    sub(stem,"_",lemma_vs_stem);
  }
for(i=1; i<=7; i++)
   printf "%s\t", $i;
if(NR==1)
  printf "\\fststem";
else
  if(match($3,"^[NV]")!=0 && match(lemma_vs_stem,"(^.+)_",s)!=0 && index(lemma," ")==0)
    if(index($3,"D")==0) # Exclude dependent nouns
      printf "%s%s-", s[1], stem;
     else
       printf "-%s-", stem;
#    else;
  else
    if(match($3,"^[NV]")!=0 && index(lemma_vs_stem,"_")==0 && index(lemma," ")==0)
      printf "@%s@", lemma_vs_stem;
    else
      printf "";
for(i=8; i<=NF; i++)
  printf "\t%s", $i; printf "\n";
}'
