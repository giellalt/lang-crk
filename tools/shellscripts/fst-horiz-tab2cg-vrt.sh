#!/bin/sh

# (FST) anl2cg.sh

# 1. Convert horizontal representation of analyses
# with 1:surface form 2-n: analyses with lemma
# into a vertical CG format
# with surface form on its own line,
# followed by each analysis on its own line, after an initial tab.

gawk '$0 ~ /^</ { print; }
$0 ~ /^[^<]/ { printf "\"<%s>\"\n", $1;
  for(i=2; i<=NF; i++)
     { n=split($i,f,"\\+");
       printf "\t";

# Identify lemma -> whatever is after any sequence of initial change, preverbs, prenouns, and reduplication

       lemma=0; j=0;
       while(!lemma)
          { ++j;
            if(index(f[j],"PV/")==0 && index(f[j],"Rdpl")==0 && index(f[j],"PN/")==0 && index(f[j],"IC")==0)
              { f[j]="\"" f[j] "\"";
                lemma=1;
              }
          }

# Print out analyses with features separated by spaces
# Print lemma within double quotes, without making it precede all features (incl. prefixes).

       for(j=1; j<=n-1; j++)
          printf "%s ", f[j];
       printf "%s\n", f[j]; 
     }
}' | # less; exit 0;

# N.B. CG currently requires the lemma to precede all features, even prefixal ones.

# 2. Making the lemma first and putting all feature tags according to CG syntax after the lemma (even though the FST outputs preverbs and reduplicative elements before):

# Preprocessing the file to prepare for CG disambiguation and analysis                                                                                

gawk '{ if(index($0,"#")!=0)
          { sub("#",""); sub("\"","&#"); }
        gsub("@","%");
        if(match($0,"((P[NV]/[^ ]+ )|(Rdpl[SW] )|(IC ))+",p)!=0)
          { sub(p[0],"");
            sub("\" ","&"p[0]); }
        print;
}' # | less; exit 0;
