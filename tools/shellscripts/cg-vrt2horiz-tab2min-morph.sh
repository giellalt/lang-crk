#!/bin/sh

# cg-vrt2horiz-tab@min-morph.sh

# 4. Converting multiline CG analysis results to our prior single-line format

# Converting multiline CG analysis structure to one form per line, with
# (multiple) analyses separated by tabs (and feature tags with spaces)                                                                                           
gawk '$0 ~ /^</ && NR!=1 { printf "\n%s", $0; }                                                                                                       
      $0 ~ /^</ && NR==1 { print; }                                                                                                                   
      $0 ~ /^\"</ { sub("\"<",""); sub(">\"",""); printf "\n%s", $0; }                                                                                
      $0 ~ /^[ \t]+/ { sub("^[ \t]+\"",""); sub("\"$",""); sub("\"[ \t]+"," "); printf "\t%s", $0; }                                                  
END { print "\n"; }' | # less; exit 0;                                                                                                                

# 5. Removing extra double-quotes (that CG may creates for features associated with non-Cree words)

gawk 'BEGIN { FS="\t"; OFS="\t"; }                                                                                                                    
      $0 ~ /^</                                                                                                                                       
      $0 ~ /^[^<]/ { if($1!="\"") gsub("\"",""); print; }' | # less; exit 0;                                                                          

# 5. Post-CG heuristic disambiguation

# Heuristic for post-CG disambiguation based on smallest morpheme count                                                                               
# In the case of multiple analyses with the same feature count, a forced                                                                              
# disambiguation is implemented so that the analysis encountered first will be selected                                                               

gawk 'BEGIN { FS="\t"; }                                                                                                                              
{ min=100; imin=2; printf "%s", $1;                                                                                                                   
  for(i=2; i<=NF; i++)                                                                                                                                
     { if(gsub(" "," ",$i)<min);                                                                                                                      
         imin=i;                                                                                                                                      
#       if(index($i,"@")!=0)                                                                                                                          
#         { min=0; imin=i; }                                                                                                                          
     }                                                                                                                                                
  printf "\t%s\n", $imin;                                                                                                                             
}' | less; exit 0;

# [It is here we would have a fork for turning the results into CWB/Korp format, now having CG-disambiguated results and surface-syntactic tagging]
