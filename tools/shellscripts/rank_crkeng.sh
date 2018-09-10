#!/bin/sh

# Script for ranking Wolvengrey-based crk2eng dictionary source XML

cat ~/giella/art/dicts/crk/Wolvengrey/crkeng.xml |
gawk 'BEGIN { while((getline < "WolfartAhenakew_GS161220_cg170525_lemma_freqs.txt")!=0)
                   rank[$2]=++nr; }
{ if(match($0,"l pos.*>([^<]+)", s)!=0)
     if(s[1] in rank)
       sub(">"," rank=\""rank[s[1]]"\">");
     else
       sub(">"," rank=\""10000"\">");
  print; }' > ~/giella/art/dicts/crk/Wolvengrey/crkeng_ranked.xml