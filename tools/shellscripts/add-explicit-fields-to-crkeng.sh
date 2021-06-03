#!/bin/sh

gawk -v FSTNORMANL=$1 '{ fstnormanl=FSTNORMANL; NULL="";
FS="\n"; RS=""; }
NR<4 { print; print ""; }
NR>=4 {
  match($0, "pos=\"[^\"]+\">([^<]+)</l>.*<lc>([^<]+)</lc>", f);
  head=f[1];
  lc=f[2];

  head0=head;
  sub("[[:punct:]]+$","",head0);

  swc=lc;
  sub("-.+","",swc);

  split(swc,c,"");
  gwc=c[1];
  
  cmd="hfst-optimized-lookup -q "fstnormanl;
  print head0 |& cmd;
  fflush(); close(cmd,"to");
  cmd |& getline fstanls;
  fflush(); close(cmd,"from");

  lemma=NULL; disamb=NULL; maxmorf=100;
  nf=split(fstanls,fstanl,"\n");
  for(i=1; i<=nf; i++)
     if(index(fstanl[i],"+Err")==0 && index(fstanl[i],"+?")==0)
       {
         split(fstanl[i], anl, "\t");
         match(anl[2],"^(((IC)|(Rdpl[WS])|(PV/[^\\+]+))\\+)*([^\\+]+)\\+([^\\+])",f);
         anlwc=f[7];
         if(anlwc=="N")
           {
             if(index(anl[2],"+D+")!=0)
               anlswc=anlwc "D";
             if(index(anl[2],"+A+")!=0)
               anlswc=anlwc "A";
             if(index(anl[2],"+I+")!=0)
               anlswc=anlwc "I";
           }
         if(anlwc=="V")
           {
             if(index(anl[2],"II")!=0)
               anlswc="VII";
             if(index(anl[2],"AI")!=0)
               anlswc="VAI";
             if(index(anl[2],"TI")!=0)
               anlswc="VTI";
             if(index(anl[2],"TA")!=0)
               anlswc="VTA";
           }
         nm=gsub("\\+","+",anl[2]); # print "SWC: "anlswc;
         if(((anlwc=="I" && anlwc==gwc) || ((anlwc=="V" || anlwc=="N") && anlswc==swc) || (anlwc=="P" && gwc=="P")) && nm<maxmorf)
           {
             # split(f[6],ff,"\t");
             # lemma=ff[2];
             lemma=f[6];
             maxmorf=nm;
             # split(anl[i],ff,"\t");
             # disamb=ff[2];
             disamb=anl[2];
           }
       }

  if(lemma==head0)
    is_lemma="TRUE";
  else
    is_lemma="FALSE";

  type="NULL";
  if(lemma==head0 && index(head0," ")==0)
    type="lemma";
  if(lemma!=head0 && index(head0," ")==0 && (swc!="IPV" && swc!="IPN" || swc!="IPP"))
    type="word";
  if(lemma!=head0 && index(head0," ")==0 && (swc=="IPV" || swc=="IPN" || swc=="IPP"))
    type="morpheme";
  if(index(head0," ")!=0)
    type="phrase";

  if(type=="phrase")
    lemma=NULL;
  paradigms=NULL;
  if(type=="lemma" && (gwc=="N" || gwc=="V"))
    paradigms="\n        <paradigm>"tolower(swc)"-basic</paradigm>\n        <paradigm>"tolower(swc)"-full</paradigm>\n      ";
  if(index(disamb,"Pron+Pers")!=0)
    paradigms="personal-pronouns";
  if(index(disamb,"Pron+Dem")!=0)
    paradigms="demonstrative-pronouns";

  newfields="      <type>"type"</type>\n      <gwc>"gwc"</gwc>\n      <swc>"swc"</swc>\n      <anl>"disamb"</anl>\n      <lemma>"lemma"</lemma>\n      <paradigms>"paradigms"</paradigms>";
  sub("</lc>", "</lc>\n"newfields,$0);
  print $0; print "";
  # print lemma, disamb, is_lemma, swc, gwc, paradigms;
}'

