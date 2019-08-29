#!/bin/sh

# inflect-gloss-crk2eng.sh
# (C) Antti Arppe 2018-2019

# Usage:
# cat PARSED-ENGLISH-GLOSS(ES) | ./inflect-gloss-crk2eng.sh Actor Goal Tense/Mood

# Example:

# gawk -F"\t" 'NR>=2 && $3 ~ /^V/ { print $24; }' ~/Google\ Drive/CreeFST/Wolvengrey/Wolvengrey_eng2crk.csv | ./inflect-gloss-crk2eng.sh 1Sg 2SgO Inf

# Input (Parsed-English-Gloss):
# s/he_PRON_SUBJ throws#throw_V s.o._PRON head=first_A ,_ in_PREP bent_A position_N
# (Note: can be applied to multiple glosses).

# Output:
# for <me> <to throw+V+Inf+1Sg> <you (one)> head first, in bent position

# Code:
# Note 1: Inflection of English actors/goals only implemented for verbs as of yet.
# Note 2: Inflections of English verb forms not yet implemented.

gawk -v SUBJ=$1 -v OBJ=$2 -v PRED=$3 -v ENG_FORMS=$4 'BEGIN { FS="\t"; actor=SUBJ; goal=OBJ; verb=PRED; n_tags=split(ANL,anl,"\\t");
  n=split(ENG_FORMS, eng_forms, "|");
   for(i=1; i<=n; i++)
      tags[anl[i]]=i;
   for(i=1; i<=n; i++)
      { split(eng_forms[i], s, ":");
        eng[s[1]]=s[2];
      }
  subj["1Sg"]="I";
  subj["2Sg"]="you (one)";
  subj["3Sg"]="s/he";
  subj["1Pl"]="we";
  subj["12Pl"]="you and we";
  subj["2Pl"]="you all";
  subj["3Pl"]="they";
  subj["4Sg/Pl"]="s/he/they";
  subj["5Sg/Pl"]="s/he/they";
  subj["X"]="someone";

  obj["1SgO"]="me";
  obj["2SgO"]="you (one)";
  obj["3SgO"]="him/her";
  obj["1PlO"]="us";
  obj["12PlO"]="you and us";
  obj["2PlO"]="you all";
  obj["3PlO"]="them";
  obj["4Sg/PlO"]="him/her/them";
  obj["5Sg/PlO"]="him/her/them";
  obj["XO"]="someone";

  refl["1Sg"]="myself";
  refl["2Sg"]="yourself";
  refl["3Sg"]="him/herself";
  refl["1Pl"]="ourselves";
  refl["12Pl"]="your and ourselves";
  refl["2Pl"]="yourselves";
  refl["3Pl"]="themselves";
  refl["4Sg/Pl"]="him/her/themselves";
  refl["5Sg/Pl"]="him/her/themselves";
  refl["X"]="someone";
}
# Processing of lexical entries
{
  # gloss=$24; # Field 23 in CW/AEW source CSV file
  gloss=$0;
  transl="";
  if(verb=="Inf")
    { gloss="for "gloss; gsub(";_ ",";_ for ",gloss); }
  if(verb=="Fut+Cond")
    { gloss="when/if "gloss; gsub(";_ ",";_ when/if ",gloss); }
  if(index(verb,"Imp")!=0)
    gloss=gloss " !";
  if((verb=="Imp+Imm" || verb=="Imp+Del") && match(actor,"^((2Sg)|(2Pl))")==0)
    { gloss="let "gloss; gsub(";_ ",";_ let ",gloss); }
  n_words=split(gloss,f," ")
  for(i=1; i<=n_words; i++)
    { # "Regular" verbs
      if(f[i]=="s/he_PRON_SUBJ" && verb!="Inf" && verb!="Imp+Imm" && verb!="Imp+Del")
        f[i]=subj[actor];
      if(f[i]=="s/he_PRON_SUBJ" && (verb=="Inf" || ((verb=="Imp+Imm" || verb=="Imp+Del") && actor!="2Sg" && actor!="2Pl")))
        f[i]=obj[actor"O"];
      if(f[i]=="s/he_PRON_SUBJ" && (verb=="Imp+Imm" || verb=="Imp+Del") && (actor=="2Sg" || actor=="2Pl"))
        f[i]="["subj[actor]"]";
      # "Subjects" for II verbs
      if(f[i]=="it_PRON_SUBJ" && index(actor,"Sg")!=0)
        f[i]="it";
      if(f[i]=="it_PRON_SUBJ" && index(actor,"Pl")!=0 && verb!="Inf")
        f[i]="they";
      if(f[i]=="it_PRON_SUBJ" && index(actor,"Pl")!=0 && verb=="Inf")
        f[i]="them";
      # Plural-only verbs
      if(f[i]=="they_PRON_SUBJ" && index(actor,"Pl")!=0 && verb!="Inf" && verb!="Imp")
        f[i]=subj[actor];
      if(f[i]=="they_PRON_SUBJ" && index(actor,"Pl")!=0 && verb=="Inf")
        f[i]=obj[actor"O"];
      if(f[i]=="s.o._PRON")
        f[i]=obj[goal];
      if(f[i]=="him/herself_PRON" || f[i]=="themselves_PRON")
        f[i]=refl[actor];
      if(index(f[i],"#")!=0 && index(f[i],"_V")!=0)
        { split(f[i],s,"[#_]"); f[i]=s[2]"+V+"verb"+"actor;
          if(verb=="Fut+Int" && (actor=="3Sg" || actor=="X"))
            f[i]="wants to "f[i];
          if(verb=="Fut+Int" && actor!="3Sg" && actor!="X")
            f[i]="want to "f[i];
          if(verb=="Fut+Def")
            f[i]="will "f[i];
          if(verb=="Inf")
            f[i]="to "f[i];
          if(verb=="Imp+Imm")
            f[i]=f[i]" now";
          if(verb=="Imp+Del")
            f[i]=f[i]" later";
        }
    }
  for(i=1; i<=n_words; i++)
     {
       sub("_.*$","",f[i]);
       transl=transl" "f[i];
     }

  sub("^\\s","",transl);
  gsub("#[^ ]+","",transl);
  gsub("="," ",transl);

  gsub("\\(\\s","(",transl);
  gsub("\\s\\)",")",transl);
  gsub("\\s\\.",".",transl);
  gsub("\\s,",",",transl);
  gsub("\\s\\?","?",transl);
  gsub("\\s!","!",transl);
  gsub("\\s:",":",transl);
  gsub("\\s;",";",transl);
  print transl;
}'
