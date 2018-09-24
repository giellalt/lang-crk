#!/bin/sh

# wolvengrey2xml.sh 1:CLASS

# E.g. wolvengrey2xml.sh N
# chooses only those that are grouped together as nouns

tr "'" '#' |
gawk -v CLASS=$1 'BEGIN { class=CLASS; FS="\t";
print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
print "<?xml-stylesheet type=\"text/css\" href=\"../../scripts/gt_dictionary.css\"?>"
print ""
print "<!DOCTYPE r"
print "PUBLIC \"-//DivvunGiellatekno//DTD Dictionaries//Multilingual\" \"../../scripts/gt_dictionary.dtd\">"
print "<r>";
print ""; }

NR>=2 { gsub("ý","y"); gsub("#","\\&apos;");
CRK=$1; ENG=$4; POS=$3;
if($16!="")
  stem=$16;
else
  stem=$15;
gsub("^[ ]*","",ENG); gsub("\"","",ENG);
gsub("^[ ]*","",POS);
n=split(ENG, eng, " ;; ");

pos="";
if(match(POS,"^V")!=0) pos="V"
if(match(POS,"^N")!=0) pos="N"
if(POS=="PrA" || POS=="PrI" || POS=="PR") pos="Pron"
if(POS=="IPN") pos="Ipc" # Adjectival/adverbial pre-noun elements
if(POS=="IPC ;; IPJ") pos="Ipc"; # 
if(POS=="IPH") pos="Ipc" # Multiword particles
if(POS=="INM") pos="N" # Proper/Place names
if(POS=="IPC" || POS=="IPJ" || POS=="IPP") pos="Ipc"
if(POS=="IPV") pos="Ipc" # Pre-verb elements

if(pos==class || class=="")
 {
  print "<e src=\"nêhiyawêwin : itwêwina / Cree : Words\">";
  print "   <lg>";
  print "      <l pos=\""pos"\">"CRK"</l>";
  print "      <lc>"POS"</lc>";
  print "      <stem>"stem"</stem>";
  print "   </lg>";
  print "   <mg>";
  print "   <tg xml:lang=\"eng\">";
  for(i=1; i<=n; i++)
     print "       <t pos=\""pos"\">"eng[i]"</t>";
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
