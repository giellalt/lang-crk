#!/bin/sh

# maskwacis2xml.sh 1:CLASS

# E.g. maskwacis2xml.sh N
# chooses only those that are grouped together as nouns

# 4265 vp
# 1880 n
#  897 vc
#  779 v
#  406 v phrase
#  312 IPC
#  132 v command
#   53 pron
#   46 prefix
#   45 loc
#   32 n pl
#   25 ques
#   14 
#    9 pron pl
#    9 excl
#    6 preverb
#    5 v phrase pl
#    4 vfp
#    4 v pl
#    4 phrase
#    4 Reduplicative prefix
#    3 reduplicative prefix
#    3 n sg
#    3 interj
#    3 fvp
#    3 exclamation
#    2 vgp
#    2 vcp
#    2 v sg
#    2 pron sing
#    2 a reply
#    2 a prefix
#    1 vpq
#    1 vp pl.
#    1 vc pl
#    1 v comb
#    1 suffix
#    1 reduplicative
#    1 reduplicatgive prefix
#    1 question
#    1 pron plural
#    1 prefix denoting something happen
#    1 prefis/preverb
#    1 ph
#    1 particle denoting the past tense
#    1 nWeightlifting.
#    1 interjection
#    1 inan pl pron
#    1 gvp
#    1 fv
#    1 expr.
#    1 expr
#    1 bp
#    1 anim/refix
#    1 ani pl pron
#    1 an exclamation
#    1 a reply meaning
#    1 Reduplicative Prfefix
#    1 N
#    1 He is alone.

gawk -v CLASS=$1 'BEGIN { class=CLASS; FS="\t";
print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
print "<?xml-stylesheet type=\"text/css\" href=\"../../scripts/gt_dictionary.css\"?>"
print ""
print "<!DOCTYPE r"
print "PUBLIC \"-//DivvunGiellatekno//DTD Dictionaries//Multilingual\" \"../../scripts/gt_dictionary.dtd\">"
print "<r>";
print ""; }

NR>=1 { CRK=$1; ENG=$4; POS=$3; 
gsub("[\\(\\)]+","",POS); gsub(" or "," ## ",POS); POS=toupper(POS); gsub(" ## "," or ",POS); 
gsub("\\.$","",ENG); gsub("\"","",ENG);
gsub("!"," (excl.)",ENG); gsub("\\?"," (quest.)",ENG);

pos="";
if(match(POS,"^v")!=0) pos="v";
if(match(POS,"^n")!=0) pos="n";
if(POS=="pron") pos="part";
if(POS=="IPC") pos="part";

if(pos==class || class=="")
 {
  print "<e src=\"Maskwacis Cree Dictionary\">";
  print "   <lg>";
  print "      <l pos=\""pos"\">"CRK"</l>";
  print "      <lc>"POS"</lc>";
  print "   </lg>";
  print "   <mg>";
  print "   <tg xml:lang=\"eng\">";
  n=split(ENG,eng,"; ");
#  n=split(ENG,eng,"(; )|([0-9]+\\. )");
  for(i=1; i<=n; i++)
     { gsub("\\.[ ]+$","",eng[i]); m=split(eng[i],char,""); char[1]=tolower(char[1]); s="";
       for(j=1; j<=m; j++)
          s=s""char[j];
       if(s!="")
         print "       <t pos=\""pos"\">"s"</t>";
     }
  print "   </tg>";
  print "   </mg>";
  print "</e>";
  print "";
 }
}

END { print "</r>"; }'

#   <e>
#      <lg>
#         <l pos="Po">uten</l>
#      </lg>
#      <mg>
#         <tg xml:lang="sma">
#            <re>om flere</re>
#            <t pos="Po">bieleli</t>
#            <xg>
#               <x>Jeg klarer meg ikke uten barna mine.</x>
#               <xt>Im bearkedh mov maanaj bieleli.</xt>
#            </xg>
#         </tg>
#      </mg>
#   </e>
#   <e>
