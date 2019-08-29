#!/bin/sh

# translate-paradigm-crk2eng.sh
# (C) Antti Arppe 2019

# Usage:
# cat CRK-DICTIONARY-SOURCE-CSV | translate-paradigm-crk2eng.sh LEXEME PARADIGM_FILE
# Note: makes use of 'inflect-gloss-eng2crk.sh

# Example:
# cat ~/Google\ Drive/CreeFST/Wolvengrey/Wolvengrey_eng2crk.csv | ./translate-paradigm-crk2eng.sh wâpamêw verb-ta.paradigm

# Selected output:
# {# IND-PRESENT-TENSE-SAP #}
#    
# wâpamêw+V+TA+Ind+Prs+2Sg+1SgO: you (one) see+V+Prs+2Sg me, you (one) witness+V+Prs+2Sg me
# wâpamêw+V+TA+Ind+Prs+2Sg+1PlO: you (one) see+V+Prs+2Sg us, you (one) witness+V+Prs+2Sg us
# wâpamêw+V+TA+Ind+Prs+2Pl+1PlO: you all see+V+Prs+2Pl us, you all witness+V+Prs+2Pl us
# wâpamêw+V+TA+Ind+Prs+2Pl+1SgO: you all see+V+Prs+2Pl me, you all witness+V+Prs+2Pl me

gawk -v LEX=$1 -v PARADIGM=$2 'BEGIN { FS="\t"; lex=LEX; paradigm_file=PARADIGM;
  while((getline < paradigm_file)!=0)
       p_line[++p_nr]=$0;
}
$1==lex {
  pos=$3;
  gloss=$24;
  gloss="\""gloss"\"";
  # gsub("[\\(\\)]","",gloss);
  # print lex, pos, gloss;
  for(p=1; p<=p_nr; p++)
     { 
       actor=""; goal=""; pred="";
       if(index(p_line[p],"{{ lemma }}")!=0)
         {
           n=split(p_line[p],f,"\\+");
           for(i=1; i<=n; i++)
              { if(match(f[i],"((Sg)|(Pl)|(Sg/Pl)|(X))$")!=0)
                  actor=f[i];
                if(match(f[i],"((Sg)|(Pl)|(Sg/Pl)|(X))O$")!=0)
                  goal=f[i];
              }
           if(index(p_line[p],"Prs")!=0)
             pred="Prs";
           if(index(p_line[p],"Prt")!=0)
             pred="Prt";
           if(index(p_line[p],"Fut+Def")!=0)
             pred="Fut+Def";
           if(index(p_line[p],"Fut+Int")!=0)
             pred="Fut+Int";
           if(index(p_line[p],"Fut+Cond")!=0)
             pred="Fut+Cond";
           if(match(p_line[p],"PV/((ta)|(ka))")!=0)
             pred="Inf";
           if(index(p_line[p],"Imp+Imm")!=0)
             pred="Imp+Imm";
           if(index(p_line[p],"Imp+Del")!=0)
             pred="Imp+Del";
         }
       fst_form=p_line[p];
       sub("{{ lemma }}",lex,fst_form);
       if(pred!="")
         { printf "%s: ", fst_form;
           if(goal=="") goal="-";
           system("echo "gloss" | ./inflect-gloss-crk2eng.sh "actor" "goal" "pred);
           fflush();
         }
       else
         print p_line[p];
         # printf "\n";
     }
}'
