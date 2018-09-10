#!/bin/sh

# Script for extracting lemma frequencies from disambiguated Ahenakew-Wolfart corpus

cat ~/Google\ Drive/CreeFST/Wolfart/WolfartAhenakew_GS161220_cg170525.vrt |
~/giella/langs/crk/inc/crk-postprocess-cg.sh |
cut -f2- |
tr '\t' '\n' |
cut -f2 -d" " |
gawk '{ gsub("(^\")|(\"$)","");
        print;
}' |
sort |
uniq -c |
sort -nr > ~/Google\ Drive/CreeFST/Wolfart/WolfartAhenakew_GS161220_cg170525_lemma_freqs.txt