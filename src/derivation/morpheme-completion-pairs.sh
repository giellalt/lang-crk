#!/bin/sh

# cat ~/altlab2/crk/generated/ahenakew_wolfart_bloomfield.fst+cg.freq-sorted.txt |

# Exclude non-Cree-word types
    
grep -v '+?' | grep -v '+PUNCT' | grep -v '+CLB' | grep -v '+Quant' | grep -v '+Prop' | grep -v '?' | grep -v 'Iph' |

# Output FST-analyses (Column 3) for word form types replicated by frequency (column 1).

gawk '{ for(i=1; i<=$1; i++) print $3; }' |

# Use the normative generator FST outputting (inflectional) morpheme boundaries.

hfst-optimized-lookup -q ../crk-strict-generator-with-morpheme-boundaries.hfstol |

gawk 'NF!=0 && index($0,"+?")==0 { print $2; }' |

# less > /dev/null; exit 0;
# echo 'ê-<nipâkwêsimo>hk' |

gawk '{ gsub("-","-/",$0); gsub("-/<","-<",$0);
nm=split($0,m,"[<>/]");
pref_compl="";
pref="";
for(i=1; i<=nm; i++)
   { 
     pref_compl=pref_compl m[i];
     nc=split(m[i],c,"");
     for(j=0; j<=nc-1; j++)
        {
          pref=pref c[j]
          if(pref!="")
            printf "%s\t%s\n", pref, pref_compl;
        }
     pref=pref c[nc];
     printf "%s\t%s\n", pref, pref_compl;
   }
}' | # less; exit 0;

gawk -F"\t" '{ a=$1; b=$2;
na=split(a,ca,"");
nb=split(b,cb,"");
for(i=1; i<=nb-1; i++)
   {
     if(ca[i]=="")
       printf "@0@:%s ", cb[i];
     else
       printf "%s ", cb[i];
   }
if(ca[nb]=="")
  printf "@0@:%s\n", cb[nb];
else
  printf "%s\n", ca[nb];
}'


