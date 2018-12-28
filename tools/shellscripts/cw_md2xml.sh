#!/bin/sh

# Usage:

# 1. CW source CSV file piped through standard input
# 2. (Path to) MD vs. CW comparison file as 1st argument
# 3. (Path to) MD source CV provided as 2nd argument
# 4. (Path to) MD p-o-s coding translation to CW-style provided as 3rd argument
# 5. CW p-o-s code provided as 4th argument
#    Specifying p-o-s code as empty string '' selects all dictionary entries

# Example:
# cat ../../Wolvengrey/Wolvengrey_eng2crk.csv |
# ~/giella/langs/crk/tools/shellscripts/cw_md2xml.sh MD_vs_CW_gloss_comparison_full_autonorm_min-morph.txt ../MaskwacisDictionary_RW12345.csv MD_pos_codes.freq_sorted.txt '' 
# > crkeng_cw_md_181219-2.xml

# Conversion of quotes to #-mark to allow for easier conversion within GAWK code
tr "'" '#' |

# Primary GAWK code

gawk -v MD_CW_CMP_PATH=$1 -v MD_PATH=$2 -v MD_CLASSES=$3 -v CLASS=$4 'BEGIN { FS="\t"; class=CLASS; md_classes=MD_CLASSES;
md_cw_cmp_path=MD_CW_CMP_PATH;
md_path=MD_PATH;

# Reading in the Maskwacîs Dictionary vs. Cree Words comparison file (which has been preprocessed
# Format:
#
# 1:achahkos 2:1: acâhkos 3:A star. 4:star 5:same
# 1:achihtin 2:1: âcihtin 3:It does not fit through. 4:it catches in the corners so as to be blocked or stuck 5:similar
# 1:achim 2:1: âcim 3:Tell about him. 4:"s/he tells about s.o., s/he talks about s.o.; s/he narrates about s.o." 5:conjugation
# 1:achimew 2:1: âcimêw 3:He is telling a story about him. 4:"s/he tells about s.o., s/he talks about s.o.; s/he narrates about s.o." 5:equivalent
# 1:achimewak 2:1: âcimêwak 3:They are telling a story about him or them. 4:"s/he tells about s.o., s/he talks about s.o.; s/he narrates about s.o." 5:conjugation

# Statistics on MD vs. CW dictionary entry comparison (indicating 3 apparent errors)
# cut -f5 MD_vs_CW_gloss_comparison_full_autonorm_min-morph.txt | sort | uniq -c | sort -nr
# 1485 narrow
# 1333 similar
#  917 equivalent
#  685 conjugation
#  452 same
#  148 broad
#   55 different
#   21 dialect
#    2 
#    1 Err/Orth

while((getline < md_cw_cmp_path)!=0)
   if(index($2,"1: ")!=0) # Add MD element only if single standardized form
     { sub("^1: ","",$2); # Editing standardized form
       gsub("\"","",$4);
       md_std[$1]=$2; # Standard form for MD dictionary entry
       md_inv[$2]=$1; # MD dictionary entry corresponding to standard form
       md_cmp_gloss[$1]=$3; # MD gloss particular to a comparison line (to ensure that gloss is relevant for the particular comparison)
       cw_cmp_gloss[$1]=$4; # CW gloss particular to a comparison line
       cw_md_cmp[$1]=$5; # Comparison assessment of MD form
     }


# Temporary code for checking input validity
# print md_inv["minahik"], md_std[md_inv["minahik"]], cw_md_cmp[md_inv["minahik"]];
# print md_inv["wîtaskîwinihk"], md_std[md_inv["wîtaskîwinihk"]], cw_md_cmp[md_inv["wîtaskîwinihk"]];

# for(i in md_inv)
#   print md_inv[i], md_std[md_inv[i]], cw_md_cmp[md_inv[i]];

# Reading in the Maskwacîs Dictionary

while((getline < md_path)!=0)
     { md_lex[$1]=$1;
       md_gloss[$1]=$4;
       md_pos[$1]=$3;
     }

# Temporary code for checking input validity
# for(i in md_lex)
#    if(!(i in md_std))
#       { print i; nr++; }
# print "END: ",nr;

# Reading in the Maskwacîs Dictionary reclassification scheme

# Source code and comparative checking here below (with single-quotes removed):
# cat ../MaskwacisDictionary_RW12345.csv | cut -f3 | sort | uniq -c | sort -nr |
# gawk { printf "%-i\t", $1; for(i=2; i<NF; i++) printf "%s ",$i; printf "%s\n", $NF; } |
# gawk BEGIN { FS="\t"; while((getline < "MD_pos_codes.freq_sorted.txt")!=0)
#                             { md_pos[$2]=$2; n_pos[$2]=$1; }
# }
# { if($2 in md_pos && n_pos[$2]==$1) print "+: "$0;
#   else if(!($2 in md_pos)) print "/: "$0;
#        else if(n_pos[$2]!=$1) print "-:"n_pos[$2]" "$0;
# }

while((getline < md_classes)!=0)
     { conv=$3;
       n=split(conv,s,":");
       md_cw_pos[$2]=s[1];
       if(s[2]!="")
         md_cw_lctype[$2]=s[2];
       if($4!="")
         md_pos_comment[$2]=$4;
     }

# PRINT XML PREAMBLE

print "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
print "<r>";
print "<!-- The dictionary sources -->";
print "   <source id=\"CW\">";
print "      <title>Cree : Words / nēhiyawēwin : itwēwina</title>";
print "   </source>";
print "   <source id=\"MD\">";
print "      <title>Maskwacîs Cree Dictionary</title>";
print "   </source>";
print "";
print "<!-- Dictionary entries from Cree Words and joint with Maskwacîs Dictionary -->";
}

NR>=2 { gsub("ý","y"); gsub("#","\\&apos;");
CRK=$1; ENG=$4; POS=$3;
if($16!="")
  stem=$16;
else
  stem=$15;
gsub("^[ ]*","",ENG); gsub("\"","",ENG);
gsub("^[ ]*","",POS);
n=split(ENG, eng, " ;; ");

# Identifying general word-classes based on CW p-o-s codes
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

# Variants of dictionary entries in Cree Words (CW) and with some established
# relationship with dictionary entries in Maskwacîs Cree Dictionary (MD).

if(pos==class || class=="")
{
  print "<e>";
  print "   <lg>";
  print "      <l pos=\""pos"\">"CRK"</l>";
  print "      <lc>"POS"</lc>";
  print "      <stem>"stem"</stem>";
  print "   </lg>";

# Dictionary entry only in CW and not in MD

  if(!(CRK in md_inv))
    { print "   <mg>";
      print "   <tg xml:lang=\"eng\">";
      for(i=1; i<=n; i++)
         print "       <t pos=\""pos"\" sources=\"CW\">"eng[i]"</t>";
      print "   </tg>";
      print "   </mg>";
    }

# Dictionary entry in both CW and MD, and glosses classified as "same" or "equivalent"
# => Single dictionary entry + single gloss (from CW),
# with source attribution to both CW and MD

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="same" || cw_md_cmp[md_inv[CRK]]=="equivalent"))
    { print "   <mg>";
      print "   <tg xml:lang=\"eng\">";
      for(i=1; i<=n; i++)
         print "       <t pos=\""pos"\" sources=\"MD CW\">"eng[i]"</t>";
      print "   </tg>";
      print "   </mg>";
    }

# Dictionary entry in both CW and MD, and glosses classified as "similar"
# => Single dictionary entry + combined single-line  gloss from both MD and CW,
# with source attribution to both. 

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="similar"))
    { print "   <mg>";
      print "   <tg xml:lang=\"eng\">";
      print "       <t pos=\""pos"\" sources=\"MD\">"md_cmp_gloss[md_inv[CRK]]"</t>";
      print "   </tg>";
      print "   <tg xml:lang=\"eng\">";
      for(i=1; i<=n; i++)
         print "       <t pos=\""pos"\" sources=\"CW\">"eng[i]"</t>";
      print "   </tg>";
      print "   </mg>";
    }

# dictionary entry in both CW and MD, and classified as "broad" or "narrow"
# or "different" or "dialect"
# => Single dictionary entry + two separate glosses on their own lines,
# each with separate source attributions.

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="broad" ||  cw_md_cmp[md_inv[CRK]]=="narrow" || cw_md_cmp[md_inv[CRK]]=="different" || cw_md_cmp[md_inv[CRK]]=="dialect"))
    { 
      print "   <mg>";
      print "   <tg xml:lang=\"eng\">";
      print "       <t pos=\""pos"\" sources=\"MD\">"md_cmp_gloss[md_inv[CRK]]"</t>";
      print "   </tg>";
      print "   </mg>";

      print "   <mg>";
      print "   <tg xml:lang=\"eng\">";
      n=split(cw_cmp_gloss[md_inv[CRK]], eng, " ;; ");
      for(i=1; i<=n; i++)
         print "       <t pos=\""pos"\" sources=\"CW\">"eng[i]"</t>";
      print "   </tg>";
      print "   </mg>";
    }

# Lexical entey in both CW and MD, and MD form classified as "conjugation",
# i.e. an inflected form of a base-form lemma (either in CW or MD or both)
# => Single dictionary entry for CW lemma, with gloss and source attribution to CW
# MD inflected form not output here, but separately as part of non-CW MD content below.

  if(CRK in md_inv && cw_md_cmp[md_inv[CRK]]=="conjugation")
    { 
      print "   <mg>";
      print "   <tg xml:lang=\"eng\">";
      for(i=1; i<=n; i++)
         print "       <t pos=\""pos"\" sources=\"CW\">"eng[i]"</t>";
      print "   </tg>";
      print "   </mg>";

    }

  print "</e>";
  print "";
 }
}

END { print "<!--Beginning of Masckwacîs Dictionary content -->";

# Dictionary entries only in MD and not in CW, or inflected forms of base-form
# lemmas presented in MD as their separate dictionary entries.
# => Single dictionary entry from MD, with gloss and source attribution to CW.
# MD part-of-speech converted to CW/crk-FST ones to the extent possible
# Some MD p-o-s codes appended to glosses as comments.

  for(lex in md_lex)
     if(!(lex in md_std) || (lex in md_std && cw_md_cmp[lex]=="conjugation"))
        { md_lex_std=lex;
          gsub("ch","c",md_lex_std);
          print "<e>";
          print "   <lg>";
          print "      <l pos=\""md_cw_pos[md_pos[lex]]"\">"md_lex_std"</l>";
          print "      <lc>"md_cw_lctype[md_pos[lex]]"</lc>";
          print "      <stem>-</stem>";
          print "   </lg>";

          print "   <mg>";
          print "   <tg xml:lang=\"eng\">";
#          for(i=1; i<=n; i++)
          if(md_pos_comment[md_pos[lex]]!="")
             print "       <t pos=\""md_cw_pos[md_pos[lex]]"\" sources=\"MD\">"md_gloss[lex]" ["md_pos_comment[md_pos[lex]]"]</t>";
          else
             print "       <t pos=\""md_cw_pos[md_pos[lex]]"\" sources=\"MD\">"md_gloss[lex]"</t>";
          print "   </tg>";
          print "   </mg>";
          print "</e>";
          print "";
        }

# End of entire crkeng dictionary record in XML format.

  print "</r>";
}'
