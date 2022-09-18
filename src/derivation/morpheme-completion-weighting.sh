#!/bin/sh

cat ~/altlab2/crk/generated/ahenakew_wolfart_bloomfield.fst+cg.freq-sorted.txt | # head -1000 | # less; exit 0;

# Exclude non-Cree-word types
    
grep -v '+?' | grep -v '+PUNCT' | grep -v '+CLB' | grep -v '+Quant' | grep -v '+Prop' | grep -v '?' | grep -v 'Iph' |

# Output FST-analyses (Column #8) for word form types replicated by frequency (column #6).

gawk -F"\t" 'NR>=2 { for(i=1; i<=$6; i++) print $8; }' | # less; exit 0;

# Use the normative generator FST outputting (inflectional) morpheme boundaries.

# hfst-optimized-lookup -q ../crk-strict-generator-with-morpheme-boundaries.hfstol |
hfst-optimized-lookup -q ../crk-strict-generator-with-morpheme-boundaries-giellaltbuild.hfstol | # less; exit 0;

gawk 'NF!=0 && index($0,"+?")==0 { form=$2; newform=$2;
  sub(">","|",form);
  gsub(">","",form);
  sub("\\|",">",form);
  gsub("[</]","&|",form);
  gsub(">","|&",form);
  nm=split(form,m,"\\|");
  newform=m[1];
  for(i=2; i<=nm; i++)
     {
       morf=m[i]; gsub("[<>/]","",morf); # print m[i], morf, length(morf);
       if(length(morf)<=2)
         newform=newform morf;
       else
         newform=newform m[i];
     }
  print newform"$";
}' | # less; exit 0;

# less > /dev/null; # exit 0;
# echo 'ê-<nipâkwêsimo>hk' |
# echo 'aa<bb<cccc>dd>ee$' |

gawk -F"\t" -v PREFIXTYPE=$1 '{ prefixtype=PREFIXTYPE;
  if(NR/1000==int(NR/1000)) printf "[%i]", NR > "/dev/stderr";
#   print $8 |& "hfst-optimized-lookup -q /Users/arppe/giellatekno/lang-crk/src/crk-strict-generator-with-morpheme-boundaries-giellaltbuild.hfstol";
#   "hfst-optimized-lookup -q /Users/arppe/giellatekno/lang-crk/src/crk-strict-generator-with-morpheme-boundaries-giellaltbuild.hfstol" |& getline line;
  # Select wordforms with both a prefix and suffix
  if(match($0,"^(.+<)([^<>]+)(>.+)$",m)!=0)
    { sep="_"; stem=m[2];
      if(prefixtype=="char")
        {
          gsub("[<>/]","",m[1]);
          gsub("[<>/]","",m[3]);
          nc=split(m[3],c,"");
        }
      else
        {
          sub("^>","",m[3]);
          nc=split(m[3],c,"[<>/]");
        }
      Ntot++;
      # Generate prefix + character-by-character prefixes of the suffix
      for(i=1; i<=nc; i++)
         { 
           infl=m[1] sep;
           gsub("<","",infl);
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
        {
          fststem=m[1] m[2] ">" m[3];
          if(prefixtype=="char")
            {
              gsub("[<>/]","",fststem)
              nc=split(fststem,c,"");
            }
          else
            nc=split(fststem,c,"[<>/]");
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
    {
      if(prefixtype=="char")
        {
          gsub("[<>/]","",$0);
          nc=split($0,c,"");
        }
      else
        nc=split($0,c,"[<>/]");
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
END { printf "[INPUT COMPLETE]\n" > "/dev/stderr";
  file="circumfix_weighting.lexc";
  # file="/dev/stdout"
  print "LEXICON Root" > file;
  PROCINFO["sorted_in"]="@val_num_desc";
  # Calculation of maximum/minimum stem frequency
  for(w in N)
     {
       ++nr;
       if(nr/1000==int(nr/1000))
         printf "[%i]", nr > "/dev/stderr";
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
  printf "[CIRCUMFIX OUTPUT COMPLETE]\n" > "/dev/stderr";

  file="prefix_weighting.lexc";
  # file="/dev/stdout"
  print "LEXICON Root" > file;
  PROCINFO["sorted_in"]="@val_num_desc";
  # Output prefixes with weights
  nr=0;
  for(w in P)
     {
       ++nr;
       if(nr/1000==int(nr/1000))
         printf "[%i]", nr > "/dev/stderr";
       printf "%s # \"weight: %f\" ;\n", w, -log(P[w]/Ntot) > file;
     }
  printf "[PREFIX OUTPUT COMPLETE]\n" > "/dev/stderr";
}'
