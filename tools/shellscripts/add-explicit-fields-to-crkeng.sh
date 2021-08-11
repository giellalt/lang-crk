#!/bin/sh

gawk -v FSTNORMANL=$1 '{ fstnormanl=FSTNORMANL; NULL="";
# Specifying records as consisting of entire lines as fields, and records separated by empty lines
FS="\n"; RS=""; }
# print XML preamble
NR<3 { print; print ""; }
# process actual dictionary content, aka crkeng.xml aggregating CW and MD
NR>=3 {
  # extract head <l pos="...">...</l> and inflectional category <lc>...</lc>
  match($0, "pos=\"[^\"]+\">([^<]+)</l>.*<lc>([^<]+)</lc>", f);
  head=f[1];
  lc=f[2];

  # remove non-word/non-hyphen punctuation at the end of the entry head -> head0
  # nôhkô! -> nôhkô
  head0=head;
  sub("[!?.,:;]+$","",head0);

  # define specific word-class <swc> for the entry, equaling the <lc> field without the hyphenated code
  # VTA-1 -> VTA, NA-4w -> NA
  swc=lc;
  sub("-.+","",swc);

  # define general word-class <gwc> for the entry (which is the first letter of <swc>)
  # VII, VAI, VTI, VTA -> V; NA, NI, NDA, NDI -> N; PrA, PrI -> P, IPC, IPJ, IPR, INM, ... -> I
  split(swc,c,"");
  gwc=c[1];

  # incremenentally define unique keys for entries
  # use <swc>, if entry head (without final punctuation) already a key
  if(!(head0 in keys))
    {
      keys[head0]=head0;
      keys[head0,swc]=head0;
    }
  else
    {
      keys[head0,swc]=head0"-"swc;
    }

  # store record from stdin into dynamic array, using current NR as index
  record[NR]=$0;
}
# Go through all entry records again, now that unique keys have been established
END { for(j=3; j<=NR; j++) 
{

  # repeat of above
  match(record[j], "pos=\"[^\"]+\">([^<]+)</l>.*<lc>([^<]+)</lc>", f);
  head=f[1];
  lc=f[2];

  head0=head;
  sub("[!?.,:;]+$","",head0);
  
  swc=lc;
  sub("-.+","",swc);

  split(swc,c,"");
  gwc=c[1];

  # output entry head without final punctuation to normative FST analyzer
  # multiple analyses will result in multiple lines
  # acâhkos -> FST
  # acâhkos\tacâhkos+N+A+Sg
  # acâhkos\tatähk+N+A+Der/Dim+N+A+Sg
  cmd="hfst-optimized-lookup -q "fstnormanl;
  print head0 |& cmd;
  fflush(); close(cmd,"to");
  cmd |& getline fstanls;
  fflush(); close(cmd,"from");

  # set default values (null lemma and analysis, plus bogud maximum number of tags/features)
  lemma=NULL; disamb=NULL; maxmorf=100;
  # cycle through each FST analysis (each on its own line)
  nf=split(fstanls,fstanl,"\n");
  for(i=1; i<=nf; i++)
     # exclude FST analyses with +Err/... tag or +? code indicating no succcessful analysis
     if(index(fstanl[i],"+Err")==0 && index(fstanl[i],"+?")==0)
       {
         # split individual FST analysis into 1) wordform and 2) analysis including lemma
         split(fstanl[i], anl, "\t");
         # extract general word-class according to FST-analysis
         match(anl[2],"^(((IC)|(Rdpl[WS])|(PV/[^\\+]+))\\+)*([^\\+]+)\\+([^\\+])",f);
         # anlwc: first post-lemma tag
         # acähkos+N+A+Sg -> N
         anlwc=f[7];
         # construct specific word-class according to FST-analysis but formatted according to CW
         if(anlwc=="N")
           { # FST: +N+A+D -> CW: NDA
             anlswc="N";
             if(index(anl[2],"+D+")!=0)
               anlswc=anlswc "D";
             if(index(anl[2],"+A+")!=0)
               anlswc=anlswc "A";
             if(index(anl[2],"+I+")!=0)
               anlswc=anlswc "I";
           }
         if(anlwc=="V")
           { # FST: +V+II -> CW: VII
             if(index(anl[2],"II")!=0)
               anlswc="VII";
             if(index(anl[2],"AI")!=0)
               anlswc="VAI";
             if(index(anl[2],"TI")!=0)
               anlswc="VTI";
             if(index(anl[2],"TA")!=0)
               anlswc="VTA";
           }
         # calculate number of tags/morphemes
         nm=gsub("\\+","+",anl[2]); # print "SWC: "anlswc;
         # Logic for disambiguation of FST analyses and FST-lemma selection
         # 1. select analyses for which the FST-lemma equals the entry head
         # 2. If no analyses have an FST-lemma that equals the entry head, consider other analyses and their FST-lemmas
         # 3. among these analyses/lemmas, select the ones for which the GWC (and maybe) SWC from FST analysis matches with DB values    
         # 4. among these analyses/lemmas, select the one which has the fewest number of tags.
         if(((anlwc=="I" && anlwc==gwc) || ((anlwc=="V" || anlwc=="N") && anlswc==swc) || (anlwc=="P" && gwc=="P")) && (nm<maxmorf || f[6]==head0))
           {
             lemma=f[6];
             maxmorf=nm;
             disamb=anl[2];
           }
       }
  # determine whether entry is a lemma or not
  if(lemma==head0)
    is_lemma="TRUE";
  else
    is_lemma="FALSE";

  # determine type of entry as: lemma, word, morpheme, or phrase
  type="NULL";
  if(lemma==head0 && index(head0," ")==0)
    type="lemma";
  if(lemma!=head0 && index(head0," ")==0 && (swc!="IPV" && swc!="IPN" || swc!="IPP"))
    type="word";
  if(lemma!=head0 && index(head0," ")==0 && (swc=="IPV" || swc=="IPN" || swc=="IPP"))
    type="morpheme";
  if(index(head0," ")!=0)
    type="phrase";

  # determine paradigm (layout), or lack thereof
  paradigms=NULL;
  if(type=="phrase")
    lemma=NULL;
  # dynamic paradigms: N or V
  if(type=="lemma" && (gwc=="N" || gwc=="V"))
     paradigms=swc;
  # static paradigms: P
  # this requires the latest crk FST
  if(index(disamb,"Pron+Pers")!=0)
    paradigms="personal-pronouns";
  if(index(disamb,"Pron+Dem")!=0)
    paradigms="demonstrative-pronouns";

  # determine unique key matching FST lemma with entry head, only for lemma and word entries
  if((type=="word" || type=="lemma") && lemma!=NULL)
    lemma_key=keys[lemma,swc];
  else
    lemma_key=NULL;

  # XML formatting of keys
  key=keys[head0,swc];
  sub("</l>","</l>\n      <entry-key>"key"</entry-key>",record[j]);

  # XML formatting of other new fields
  newfields="      <entry-type>"type"</entry-type>\n      <general-word-class>"gwc"</general-word-class>\n      <specific-word-class>"swc"</specific-word-class>\n      <fst-analysis>"disamb"</fst-analysis>\n      <fst-lemma>"lemma"</fst-lemma>\n      <lemma-key>"lemma_key"</lemma-key>\n      <paradigms>"paradigms"</paradigms>";
  sub("</lc>", "</lc>\n"newfields,record[j]);

  # revise or remove obsolete XML code
  gsub("lc>","lexical-category>",record[j]);
  sub(" pos=\"[^\"]+\"","",record[j]);
  gsub("l>","entry-head>",record[j]);
  # output record with revised or new XML fields
  print record[j]; print "";

  # outputting fields for diagnostic purposes
  # print lemma, disamb, is_lemma, swc, gwc, paradigms;
}
}'

