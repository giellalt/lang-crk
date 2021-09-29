#!/bin/sh

# cat ~/altlab2/crk/generated/ahenakew_wolfart_bloomfield.fst+cg.freq-sorted.txt|

# Exclude non-Cree-word types
    
grep -v '+?' | grep -v '+PUNCT' | grep -v '+CLB' | grep -v '+Quant' | grep -v '+Prop' | grep -v '?' | grep -v 'Iph' |

# Output FST-analyses (Column 3) for word form types replicated by frequency (column 1).

gawk '{ for(i=1; i<=$1; i++) print $3; }' |

# Use the normative generator FST outputting (inflectional) morpheme boundaries.

hfst-optimized-lookup -q ../crk-strict-generator-with-morpheme-boundaries.hfstol |

gawk 'NF!=0 && index($0,"+?")==0 { print $2; }' |

# less > /dev/null; exit 0;
# echo 'ê-<nipâkwêsimo>hk' |

gawk '{
  # Select wordforms with both a prefix and suffix
  if(match($0,"^(.+)<([^>]+)>(.+)$",m)!=0)
    { sep="_"; stem=m[2]
      gsub("[<>/]","",m[3]);
      nc=split(m[3],c,"");
      Ntot++;
      # Generate prefix + character-by-character prefixes of the suffix
      for(i=1; i<=nc; i++)
         { 
           infl=m[1] sep;
           gsub("[<>/]","",infl);
           for(j=1; j<=i; j++)
              infl=infl c[j];
           # Increase the count for the prefix-suffix combination
           N[infl]++;
           # Increase the counts for the stems associated with the prefix-suffix combo
           NN[infl][stem]++;
         }
      # As long as there is a prefix, generate character-by-character prefixes
      # for the entire wordform
      if(m[1]!="")
        { fststem=m[1] m[2] m[3];
          gsub("[<>/]","",fststem)
          nc=split(fststem,c,"");
          for(i=1; i<=nc; i++)
             { prefix="";
               for(j=1; j<=i; j++)
                  prefix=prefix c[j];
               P[prefix]++;
             }
        }
    }
   # Alternative when the wordform does not have both a prefix and suffix,
   # i.e. has only a prefix or only a suffix or only a stem.
   else
    { gsub("[<>/]","",$0);
      nc=split($0,c,"");
      Ntot++
      # Generate character-by-character prefixes for the entire wordform
      for(i=1; i<=nc; i++)
         { prefix="";
           for(j=1; j<=i; j++)
              prefix=prefix c[j];
           P[prefix]++;
         }
    }
}
END { file="circumfix_weighting.lexc";
  # file="/dev/stdout"
  print "LEXICON Root" > file;
  PROCINFO["sorted_in"]="@val_num_desc";
  # Calculation of maximum/minimum stem frequency
  for(w in N)
     {
       # Calculate prefix-suffix-specific maxima/minima for stem frequencies
       max=0; min=1000000000000;
       for(s in NN[w])
          { if(NN[w][s]>max) max=NN[w][s] ;
            if(NN[w][s]<min) min=NN[w][s] ;
          }
       r=w; # gsub(""," ",r); sub("_", "?+",r);
       # Output circumfixes with weights
       # using maximum frequency of combo-specific stems
       printf "%s # \"weight: %f\" ;\n", r, -log(max/Ntot) > file;
     }

  file="prefix_weighting.lexc";
  # file="/dev/stdout"
  print "LEXICON Root" > file;
  PROCINFO["sorted_in"]="@val_num_desc";
  # Output prefixes with weights
  for(w in P)
     printf "%s # \"weight: %f\" ;\n", w, -log(P[w]/Ntot) > file;
}'

