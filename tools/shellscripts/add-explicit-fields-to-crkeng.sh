#!/bin/sh

gawk -v FSTNORMANL=$1 '{ fstnormanl=FSTNORMANL;
FS="\n"; RS=""; }
NR<4 { print; print ""; }
NR>=4 {
  match($0, "pos=\"[^\"]+\">([^<]+)</l>.*<lc>([^<]+)</lc>", f);
  head=f[1];
  lc=f[2];

  swc=lc;
  sub("-.+","",swc);

  split(swc,c,"");
  gwc=c[1];
  
  cmd="hfst-optimized-lookup -q "fstnormanl;
  print head |& cmd;
  fflush(); close(cmd,"to");
  cmd |& getline anls;
  fflush(); close(cmd,"from");

  lemma="NULL"; disamb="NULL"; maxmorf=100;
  nf=split(anls,anl,"\n");
  for(i=1; i<=nf; i++)
     if(index(anl[i],"+Err")==0 && index(anl[i],"+?")==0)
       { 
         match(anl[i],"^(((IC)|(Rdpl[WS])|(PV/[^\\+]+))\\+)*([^\\+]+)\\+([^\\+])",f);
         anlwc=f[7];
         if(anlwc=="N")
           {
             if(index(anl[i],"+D+")!=0)
               anlswc=anlwc "D";
             if(index(anl[i],"+A+")!=0)
               anlswc=anlwc "A";
             if(index(anl[i],"+I+")!=0)
               anlswc=anlwc "I";
           }
         if(anlwc=="V")
           {
             if(index(anl[i],"II")!=0)
               anlswc="VII";
             if(index(anl[i],"AI")!=0)
               anlswc="VAI";
             if(index(anl[i],"TI")!=0)
               anlswc="VTI";
             if(index(anl[i],"TA")!=0)
               anlswc="VTA";
           }
         nm=gsub("\\+","+",anl[i]); # print "SWC: "anlswc;
         if(((anlwc=="I" && anlwc==gwc) || ((anlwc=="V" || anlwc=="N") && anlswc==swc) || (anlwc=="P" && gwc=="P")) && nm<maxmorf)
           {
             split(f[6],ff,"\t");
             lemma=ff[1];
             maxmorf=nm;
             split(anl[i],ff,"\t");
             disamb=ff[2];
           }
       }

  if(lemma==head)
    is_lemma="TRUE";
  else
    is_lemma="FALSE";

  type="NULL";
  if(lemma==head && index(head," ")==0)
    type="lemma";
  if(lemma!=head && index(head," ")==0 && (swc!="IPV" && swc!="IPN" || swc!="IPP"))
    type="word";
  if(lemma!=head && index(head," ")==0 && (swc=="IPV" || swc=="IPN" || swc=="IPP"))
    type="morpheme";
  if(index(head," ")!=0)
    type="phrase";

  paradigms="NULL";
  if(type=="lemma" && (gwc=="N" || gwc=="V"))
    paradigms=tolower(swc)"-basic.layout, "tolower(swc)"-full.layout";
  if(index(disamb,"Pron+Pers")!=0)
    paradigms="pronoun-personal.layout";
  if(index(disamb,"Pron+Dem")!=0)
    paradigms="pronoun-demonstrative.layout";

  newfields="      <type>"type"</type>\n      <swc>"swc"</swc>\n      <anl>"disamb"</anl>\n      <lemma>"lemma"</lemma>\n      <paradigms>"paradigms"</paradigms>";
  sub("</lc>", "</lc>\n"newfields,$0);
  print $0; print ""; # print lemma, disamb, is_lemma, swc, gwc, paradigms;
}'

