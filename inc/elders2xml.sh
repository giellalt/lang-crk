#!/bin/sh

# elders2xml.sh 1:CLASS

# E.g. elders2xml.sh N
# chooses only those that are grouped together as nouns

# 2450 (vta)
# 1877 (vti)
# 1712 (vai)
#  635 (vii)
#   70 (vii) or (vai)
#   17 (vai) or (vii)
#    3 (vta) or (vti)
#    1 (vti) or (vta)
#    1 (vti) (Conj. mode)

# 2270 (ni)
#  966 (na)
#    6 (ob.) (na)
#    5 (ni) or (na)
#    2 ni)
#    2 (nda)
#    2 (na) or (ni)
#    1 n

#  330 (ipc)

#   17 (ln)
#   10 (pr)
#    5 (dpr)
#    2 (ip)
#    1 (ipr)
#    1 (VIA)
#    1 (TII)
#    1 (IP)

gawk -v CLASS=$1 'BEGIN { class=CLASS; FS="\t";
print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
print "<?xml-stylesheet type=\"text/css\" href=\"../../scripts/gt_dictionary.css\"?>"
print ""
print "<!DOCTYPE r"
print "PUBLIC \"-//DivvunGiellatekno//DTD Dictionaries//Multilingual\" \"../../scripts/gt_dictionary.dtd\">"
print "<r>";
print ""; }

NR>=1 { CRK=$1; ENG=$5; POS=$4; 
gsub("[\\(\\)]+","",POS); gsub(" or "," ## ",POS); POS=toupper(POS); gsub(" ## "," or ",POS); 
gsub("\\.$","",ENG); gsub("\"","",ENG);
gsub("!"," (excl.)",ENG); gsub("\\?"," (quest.)",ENG);

pos="";
if(match(POS,"^V")!=0) pos="v";
if(match(POS,"^N")!=0) pos="n";
if(POS=="IPC") pos="part";

if(pos==class || class=="")
 {
  print "<e src=\"Alberta Elders Cree Dictionary\">";
  print "   <lg>";
  print "      <l pos=\""pos"\">"CRK"</l>";
  print "      <lc>"POS"</lc>";
  print "   </lg>";
  print "   <mg>";
  print "   <tg xml:lang=\"eng\">";
  n=split(ENG,eng,"; ");
  for(i=1; i<=n; i++)
     { m=split(eng[i],char,""); char[1]=tolower(char[1]); s="";
       for(j=1; j<=m; j++)
          s=s""char[j];
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
