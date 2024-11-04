#!/bin/sh

# parse-fst-output-string-4-lexicon-and-tag-flags.sh

# Usage:
# 1. cat lexicon.lexc | tools/shellscripts/add-lexicon-and-tag-flags-2-lexc.sh > lexicon_flags.lexc
# 2. foma: read lexc lexicon_flags.lexc
# 3. foma: set show-flags ON
# 4. foma: down nipâw+V+AI+Ind+1Pl => @P.LEXICON.Root@@P.LEXICON.VerbPrefixes@@U.order.indep@@P.LEXICON.INDEPENDENT@@U.person.NI@nit2<@P.LEXICON.VERBPREFIXES@@U.wici.NULL@@P.LEXICON.VERBSTEMS@nipâ@P.LEXICON.VAIae@@P.FSTTAG.+V@@P.FSTTAG.+AI@@P.LEXICON.VAIae_WICI@@U.wici.NULL@@P.LEXICON.VAIae_ORDER@@P.FSTTAG.+Ind@@U.order.indep@@P.LEXICON.VAIae_IND_PERSON@@U.person.NI@@P.LEXICON.VAIw_IND_NI@@P.LEXICON.VAIw_IND_NI_PL_SUFFIX@@P.FSTTAG.+1Pl@>n2ân@P.LEXICON.VERB_ENDLEX@@D.frag.FRAG@@D.cnj.CC@@D.joiner.NULL@
# 5. echo '@P.LEXICON.Root@@P.LEXICON.VerbPrefixes@@U.order.indep@@P.LEXICON.INDEPENDENT@@U.person.NI@nit2<@P.LEXICON.VERBPREFIXES@@U.wici.NULL@@P.LEXICON.VERBSTEMS@nipâ@P.LEXICON.VAIae@@P.FSTTAG.+V@@P.FSTTAG.+AI@@P.LEXICON.VAIae_WICI@@U.wici.NULL@@P.LEXICON.VAIae_ORDER@@P.FSTTAG.+Ind@@U.order.indep@@P.LEXICON.VAIae_IND_PERSON@@U.person.NI@@P.LEXICON.VAIw_IND_NI@@P.LEXICON.VAIw_IND_NI_PL_SUFFIX@@P.FSTTAG.+1Pl@>n2ân@P.LEXICON.VERB_ENDLEX@@D.frag.FRAG@@D.cnj.CC@@D.joiner.NULL@' | tools/shellscripts/parse-fst-output-string-4-lexicon-and-tag-flags.sh

gawk '{
  n=split($0, a, "@P\\.LEXICON\\.[^@]+@", s);
  for(i=1; i<=n-1; i++)
     {
       match(s[i], "@P\\.LEXICON\\.([^@]+)@", f);
       out=a[i+1]; inp=""; clex=f[1];
       while(match(out, "@P\\.FSTTAG.([^@]+)@", ff)!=0)
            {
              gsub("\\+", "\\+", ff[0]);
              gsub("\\.", "\\.", ff[0]);
              sub(ff[0], "", out);
              inp=inp ff[1];
            }

       if(anl=="") anl="0";
       printf "%i\t%s\t%s\t%s\n", i, clex, inp, out;
     }
}' |

gawk -F"\t" 'BEGIN { max1=5; max2=7; max3=5; max4=5; }
{ 
  if(length($1)>max1) max1=length($1);
  if(length($2)>max2) max2=length($2);
  if(length($3)>max3) max3=length($3);
  if(length($4)>max4) max4=length($4);

  for(j=1; j<=NF; j++)
     if($j=="")
       cell[NR, j]="0";
     else
       cell[NR, j]=$j;

}
END {
  delim=sprintf("%" (max1+3 + max2+1 + max3+2 + max4+3) "s", ""); gsub(" ", "-", delim);
  printf "%s\n", delim;
  printf  "%"(max1)"s | %-"(max2+1)"s|%"(max3+1)"s : %-"(max4)"s\n", "INDEX", "CONTLEX", "INPUT", "OUTPUT";
  for(i=1; i<=NR; i++)
     {
       if(cell[i, 1]=="1")
         printf "%s\n", delim;
       printf "%"(max1)"i | %-"(max2+1)"s|%"(max3+1)"s : %-"(max4)"s\n", cell[i, 1], cell[i, 2], cell[i, 3], cell[i, 4];
     }
  printf "%s\n", delim;
}'

