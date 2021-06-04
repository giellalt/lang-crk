#!/bin/sh

gawk -v FSTNORMANL=$1 '{ fstnormanl=FSTNORMANL; NULL="";
FS="\n"; RS=""; }
NR<3 { print; print ""; }
NR>=3 {
  match($0, "pos=\"[^\"]+\">([^<]+)</l>.*<lc>([^<]+)</lc>", f);
  head=f[1];
  lc=f[2];

  head0=head;
  sub("[!?.,:;]+$","",head0);

  swc=lc;
  sub("-.+","",swc);

  split(swc,c,"");
  gwc=c[1];

  if(!(head0 in keys))
    {
      keys[head0]=head0;
      keys[head0,swc]=head0;
    }
  else
    {
      keys[head0,swc]=head0"-"swc;
    }

  record[NR]=$0;
}
END { for(j=3; j<=NR; j++) 
{

  match(record[j], "pos=\"[^\"]+\">([^<]+)</l>.*<lc>([^<]+)</lc>", f);
  head=f[1];
  lc=f[2];

  head0=head;
  sub("[!?.,:;]+$","",head0);

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
             anlswc="N";
             if(index(anl[2],"+D+")!=0)
               anlswc=anlswc "D";
             if(index(anl[2],"+A+")!=0)
               anlswc=anlswc "A";
             if(index(anl[2],"+I+")!=0)
               anlswc=anlswc "I";
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
         if(((anlwc=="I" && anlwc==gwc) || ((anlwc=="V" || anlwc=="N") && anlswc==swc) || (anlwc=="P" && gwc=="P")) && (nm<maxmorf || f[6]==head0))
           {
             lemma=f[6];
             maxmorf=nm;
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
     paradigms=swc;
#    paradigms="\n        <paradigm>"tolower(swc)"-basic</paradigm>\n        <paradigm>"tolower(swc)"-full</paradigm>\n      ";
  if(index(disamb,"Pron+Pers")!=0)
    paradigms="personal-pronouns";
  if(index(disamb,"Pron+Dem")!=0)
    paradigms="demonstrative-pronouns";

  if((type=="word" || type=="lemma") && lemma!="")
    lemma_key=keys[lemma,swc];
  else
    lemma_key=NULL;

  key=keys[head0,swc];
  sub("</l>","</l>\n      <entry-key>"key"</entry-key>",record[j]);

  newfields="      <entry-type>"type"</entry-type>\n      <general-word-class>"gwc"</general-word-class>\n      <specific-word-class>"swc"</specific-word-class>\n      <fst-analysis>"disamb"</fst-analysis>\n      <fst-lemma>"lemma"</fst-lemma>\n      <lemma-key>"lemma_key"</lemma-key>\n      <paradigms>"paradigms"</paradigms>";
  sub("</lc>", "</lc>\n"newfields,record[j]);

  gsub("lc>","lexical-category>",record[j]);
  sub(" pos=\"[^\"]+\"","",record[j]);
  gsub("l>","entry-head>",record[j]);
  print record[j]; print "";

  # print lemma, disamb, is_lemma, swc, gwc, paradigms;
}
}'

