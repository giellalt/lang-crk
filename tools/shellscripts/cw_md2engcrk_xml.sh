#!/bin/sh

# Structure of English-to-Cree dictionary entry
# 
# <e>
#    <lg xml:lang="eng">
#        <l pos="V">say</l>
#    </lg>
#    <mg rank="1"> # Rank unused for the moment - later on, should be corpus/lemma-frequency based
#    <tg xml:lang="crk">
#       <re sources="MD">say</re>
#       <re sources="CW">say so, say thus, call (it) so; have such a meaning</re> 
#       <t pos="V" type="AI">itwêw</t>
#          <lc>=VAI-1</lc>
#          <stem>itwê-</stem>
#    </tg>
#    </mg>
# </e>
# 
# 
# 1. English glosses effectively the same for the same Cree lemma
# 
# <e>
#    <lg xml:lang="eng">
#      <l pos="POS">EnglishWord</l>
#    </lg>
#    <mg>
#    <tg xml:lang="crk">
#       <re sources="CW MD">glosses exactly the same</re>
#       <t pos="CRKPOS">CreeWord</t>
#          <lc>SUBTYPE</lc>
#    </tg>
#    </mg>
# </e>
# 
# 2. Overlapping English keywords for same Cree lemma
# 
# <e>
#    <lg xml:lang="eng">
#      <l pos="POS">EnglishWord</l>
#    </lg>
#    <mg>
#    <tg xml:lang="crk">
#       <re sources="CW">glosses similar with key-overlap, but not the same</re>
#       <re sources="MD">glosses similar with key-overlap, but not the same</re>
#       <t pos="CRKPOS">CreeWord</t>
#          <lc>SUBTYPE</lc>
#    </tg>
#    </mg>
# </e>
# 
# 3. No overlapping keywords for the same Cree lemma
# 
# <e>
#    <lg xml:lang="eng">
#      <l pos="POS">EnglishWord1</l>
#    </lg>
#    <mg>
#    <tg xml:lang="crk">
#       <re sources="MD">glosses different</re>
#       <t pos="CRKPOS">CreeWord</t>
#          <lc>SUBTYPE</lc>
#    </tg>
#    </mg>
# </e>
# 
# <e>
#    <lg xml:lang="eng">
#      <l pos="POS">EnglishWord2</l>
#    </lg>
#    <mg>
#    <tg xml:lang="crk">
#       <re sources="CW">glosses different</re>
#       <t pos="CRKPOS">CreeWord</t>
#          <lc>SUBTYPE</lc>
#    </tg>
#    </mg>
# </e>

# 1. CW source CSV file piped through standard input
# 2. (Path to) MD vs. CW comparison file as 1st argument
# 3. (Path to) MD source CV provided as 2nd argument
# 4. (Path to) MD p-o-s coding translation to CW-style provided as 3rd argument
# 5. CW p-o-s code provided as 4th argument

# Usage xample with source files:
# cat ../../Wolvengrey/Wolvengrey_eng2crk.csv | ~/giella/langs/crk/tools/shellscripts/cw_md2engcrk_xml.sh MD_vs_CW_gloss_comparison_full_autonorm_min-morph.txt ../MaskwacisDictionary_RW12345_english_POS-tagged.csv MD_pos_codes.freq_sorted.txt > engcrk_190205.xml

# Primary GAWK code

gawk -v MD_CW_CMP_PATH=$1 -v MD_PATH=$2 -v MD_CLASSES=$3 'BEGIN { FS="\t"; md_classes=MD_CLASSES;
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
#   print ++nr, md_inv[i], md_std[md_inv[i]], cw_md_cmp[md_inv[i]];
# print "END: "nr;

# Reading in the Maskwacîs Dictionary

# MD POS counts (and possible conversions)
# 13140 (punctuation)
# 10521 V
# 10158 PRON
# 9387 N
# 4903 PREP
# 3913 DET
# 2544 ADJ
# 2509 ADV
# 1261 CC
#  562 NUM
#  157 FW
#   77 EX
#   72 POS
#   50 CS
#    2 INTERJ
#    1 ``
#    1 SYM
#    1 ''

while((getline < md_path)!=0)
     { md_lex[$1]=$1;
       md_gloss[$1]=$4;
       md_pos[$1]=$3;
       md_gloss_parsed[$1]=$7;
       md_gloss_short[$1]=$8;
       
       gsub("\"","\\&quot;",md_gloss_short[$1]);

       # Creating key string with selected parts-of-speech
       nk=split($7,key," "); delete keys; md_key_string="";
       for(i=1; i<=nk; i++)
          { # Recoding some of the POS suffixes
            sub("_ADJ$","_A",key[i]); # ADJ -> A
            sub("_CC$","_CONJ",key[i]); # CC -> CONJ
            sub("^.+#","",key[i]); # Leaving out only lemma, when identified for an inflecting word
            # Selecting keys for MD lexical entry
            if(match(key[i],"((he)|(it))_PRON_SUBJ")==0 && match(key[i],"^(([Aa])|([Aa]n)|([Tt]he))_DET")==0 && match(key[i],"_((N)|(V)|(PRON)|(DET)|(PREP)|(ADJ)|(ADV)|(CC)|(NUM)|(POS)|(CS)|(INTERJ))$")!=0)
              if(key[i]!="do_V" && key[i+1]!="not_ADV")
                { keys[key[i]]++;
                  md_key_string=md_key_string" "key[i];
                }
          }

        sub("^ ","",md_key_string);
        md_keys[$1]=md_key_string;

        # Temporary code for examining keys
        # print md_key_string, $8;
     }

# Temporary code for checking input validity
# for(i in md_lex)
#    if(!(i in md_std))
#       { print i; nr++; }
# print "END: ", nr;

# for(i in md_lex)
#    if(i in md_std)
#      yes++;
#    else
#      no++;
# print "YES: "yes" - NO:"no;

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
}

# Start going through CW through standard input

NR>=2 { gsub("ý","y"); # Normalizing dialectal <y>

# Setting generally rank=1 for everything.
# To be replacad by corpus-based lemma ranking.
rank=1;

CRK=$1; CRKPOS=$3;
if($16!="")
  stem=$16;
else
  stem=$15;

cw_gloss_short=$23;
gsub("\"","\\&quot;",cw_gloss_short);

gsub("^[ ]*","",ENG); gsub("\"","",ENG);
gsub("^[ ]*","",CRKPOS);
n=split(ENG, eng, " ;; ");

# Identifying general word-classes based on CW p-o-s codes
crkpos="";
if(match(CRKPOS,"^V")!=0) crkpos="V"
if(match(CRKPOS,"^N")!=0) crkpos="N"
if(CRKPOS=="PrA" || CRKPOS=="PrI" || CRKPOS=="PR") crkpos="Pron"
if(CRKPOS=="IPN") crkpos="Ipc" # Adjectival/adverbial pre-noun elements
if(CRKPOS=="IPC ;; IPJ") crkpos="Ipc"; # 
if(CRKPOS=="IPH") crkpos="Ipc" # Multiword particles
if(CRKPOS=="INM") crkpos="N" # Proper/Place names
if(CRKPOS=="IPC" || CRKPOS=="IPJ" || CRKPOS=="IPP") crkpos="Ipc"
if(CRKPOS=="IPV") crkpos="Ipc" # Pre-verb elements

# CW POS codes with conversions
# 26262 PRON
# 20406 N
# 18488 V
# 17178 
# 8206 PREP
# 6743 ADV
# 6607 A
# 4765 DET
# 1302 EN -> V
# 1107 ING -> V
#  904 CC
#  481 INFMARK> -> (to be ignored)
#  440 NUM
#  239 ABBR -> (to be ignored)
#  145 <Ex> -> ??
#  136 NEG-PART -> ??
#  132 CS
#   61 INTERJ
#    6 Heur -> (to be ignored)
#    1 ) -> (to be ignored)
#    1 ( -> (to be ignored)

  nk=split($24, key, " "); delete keys; cw_key_string="";
  for(i=1; i<=nk; i++)
     {
       # Recoding some of the POS suffixes
       sub("^.+#","",key[i]); # Leaving out only lemma, when identified for an inflecting word
       sub("_((EN)|(ING))$","_V",key[i]); # Grouping verbal participles under Verbs
       sub("_INFMARK>$","_PREP",key[i]); # Grouping infinitival 'to' with Prepositions
       sub("_NEG-PART$","_ADV",key[i]); # Grouping negative particle under Adverbs
       # sub("_<Ex>$","_ADV",key[i]); # Grouping existential 'there' under Adverbs
       sub("_CC$","_CONJ",key[i]); # Recoding CC as CONJ
       sub("_N_SUBJ$","_N",key[i]); # Removing Subject marker for nouns

       # Creating unique keys for a sentences, ignoring duplicates
       if(!(key[i] in keys))
         { if(match(key[i],"((s/he)|(he)|(it))_PRON_SUBJ")==0 && index(key[i],"s.t.")==0 && index(key[i],"s.o.")==0 && match(key[i],"_DET$")==0 && index(key[i],"_<Ex>")==0 && match(key[i],"_$")==0)
             { sub("_SUBJ$","",key[i]); keys[key[i]]++; cw_key_string=cw_key_string" "key[i]; }
         }
     }
  sub("^ ","",cw_key_string);

  # Temporary code for printing out keys
  # print cw_key_string, $23;

###### Aggregating keys over both MD and CW #####
# Format of output columns (tab-separated):
# 1: English key POS
# 2. Cree word rank
# 3: Cree word word-class (N, V, etc.)
# 4. Cree word POS (NA-1, VTA-1, etc.)
# 5. CW Cree lexical entry
# 6. MD vs. CW comparison (from eng->crk viewpoint)
# 7. MD shortened English gloss
# 8. CW shortened English gloss

# Dictionary entry only in CW and not in MD

  if(!(CRK in md_inv))
    {
      nk=split(cw_key_string, key, " ");
      for(i=1; i<=nk; i++)
         printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "CW-only", "", cw_gloss_short;
    }

# Dictionary entry in both CW and MD, and glosses classified as "same" or "equivalent"
# => Single dictionary entry + single gloss (from CW),
# with source attribution to both CW and MD
# and indexing with combination of MD and CW glosses

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="same" || cw_md_cmp[md_inv[CRK]]=="equivalent"))
    { 
      delete keys;
      common_key_string=cw_key_string" "md_keys[md_inv[CRK]]
      nk=split(common_key_string,key," ");
      for(i=1; i<=nk; i++)
         if(!(key[i] in keys))
           printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "MD-CW-same/equivalent", "", cw_gloss_short;
         else
           keys[key[i]]++;
    }

# Dictionary entry in both CW and MD, and glosses classified as "similar"
# => Single dictionary entry + combined single-line  gloss from both MD and CW,
# with source attribution to both separately. 
# and indexing with a combination of MD and CW glosses

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="similar"))
    { 
      delete keys;
      nk=split(cw_key_string" "md_keys[md_inv[CRK]],key," ");
      for(i=1; i<=nk; i++)
         if(!(key[i] in keys))
           printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "MD-CW-similar", md_gloss_short[md_inv[CRK]], cw_gloss_short;
         else
           keys[key[i]]++;
    }

# dictionary entry in both CW and MD, and classified as "broad" or "narrow"
# => Single dictionary entry + two separate glosses on their own lines,
# each with separate source attributions.
# and indexing with a combination of MD and CW glosses

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="broad" ||  cw_md_cmp[md_inv[CRK]]=="narrow"))
    { 
      delete keys;
      nk=split(cw_key_string" "md_keys[md_inv[CRK]],key," ");
      for(i=1; i<=nk; i++)
         if(!(key[i] in keys))
           printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "MD-CW-broad/narrow", md_gloss_short[md_inv[CRK]], cw_gloss_short;
         else
           keys[key[i]]++;
    }

# dictionary entry in both CW and MD, and classified as "different" or "dialect"
# => Two dictionary entries + with their own glosses,
# each with separate source attributions.
# and indexing separately with MD and CW glosses

  if(CRK in md_inv && (cw_md_cmp[md_inv[CRK]]=="different" || cw_md_cmp[md_inv[CRK]]=="dialect"))
    { 
      # MD-specific entry
      delete keys;
      nk=split(md_keys[md_inv[CRK]], key, " ");
      for(i=1; i<=nk; i++)
         if(!(key[i] in keys))
           printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "MD-only", md_gloss_short[md_inv[CRK]], "";
         else
           keys[key[i]]++;

      # CW-specific entry
      delete keys;
      nk=split(cw_key_string, key, " ");
      for(i=1; i<=nk; i++)
         if(!(key[i] in keys))
           printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "CW-only", "", cw_gloss_short;
         else
           keys[key[i]]++;
    }

# Lexical entry in both CW and MD, and MD form classified as "conjugation",
# i.e. an inflected form of a base-form lemma (either in CW or MD or both)
# => Single dictionary entry for CW lemma, with gloss and source attribution to CW
# and indexing according to CW gloss.
# MD inflected form not output here, but separately as part of non-CW MD content below.

  if(CRK in md_inv && cw_md_cmp[md_inv[CRK]]=="conjugation")
    { 
      nk=split(cw_key_string, key, " ");
      for(i=1; i<=nk; i++)
         printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, crkpos, CRKPOS, CRK, "CW-only", "", cw_gloss_short;
    }
    
# Dictionary entries only in MD and not in CW, or inflected forms of base-form
# lemmas presented in MD as their separate dictionary entries.
# => Single dictionary entry from MD, with gloss and source attribution to MD.
# MD part-of-speech converted to CW/crk-FST ones to the extent possible
# and indexing according to MD gloss.
# No detailed POS provided.
  
} END {
  for(lex in md_lex)
     if(!(lex in md_std) || (lex in md_std && cw_md_cmp[lex]=="conjugation"))
        { md_lex_std=lex;
          gsub("ch","c",md_lex_std);
          gsub(" ","-",md_lex_std);

          nk=split(md_keys[lex], key, " ");
          for(i=1; i<=nk; i++)
             printf "%s\t%2.1f\t%s\t%s\t%s\t%s\t%s\t%s\n", key[i], rank, md_cw_pos[md_pos[lex]], "", md_lex_std, "MD-only", md_gloss_short[lex], "";
        }
}' | # less; exit 0;

sort -k1 -k5 | uniq | # less; exit 0;

gawk 'BEGIN { FS="\t";

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
print "<!-- Dictionary entries from Cree Words and Maskwacîs Dictionary -->";

eng="";

}
{

###### Aggregating keys over both MD and CW #####
# Format of output columns (tab-separated):
# 1: English key and POS (word_POS)
# 2. Cree word rank
# 3: Cree word word-class (N, V, etc.)
# 4. Cree word POS (NA-1, VTA-1, etc.)
# 5. CW Cree lexical entry
# 6. MD vs. CW comparison (from eng->crk viewpoint)
# 7. MD shortened English gloss
# 8. CW shortened English gloss

# print $0;
  if(eng!=$1)
    { if(eng!="")
        print "</e>";

      eng=$1;
      split($1,s,"_");
      ENGLEX=s[1];
      ENGPOS=s[2];

      print "<e>";
      print "   <lg xml:lang=\"eng\">";
      print "      <l pos=\""ENGPOS"\">"ENGLEX"</l>";
      print "   </lg>";
    } 

  rank=$2;      
  CRKLEX=$5;
  CRKPOS=$3;
  LCTYPE=$4;
  md_cw_cmp=$6;
  md_short_gloss=$7;
  cw_short_gloss=$8;

  print "   <mg>";
  print "   <tg xml:lang=\"crk\">";
      
  if(md_cw_cmp=="CW-only")
    { print "      <re sources=\"CW\">"cw_short_gloss" ᶜᵂ</re>";
      print "      <re2 sources=\"CW\">"cw_short_gloss" ᶜᵂ</re2>";
    }
    
  if(md_cw_cmp=="MD-CW-same/equivalent")
    { print "      <re sources=\"MD CW\">"cw_short_gloss" ᴹᴰ ᶜᵂ</re>";
      print "      <re2 sources=\"MD CW\">"cw_short_gloss" ᴹᴰ ᶜᵂ</re2>";
    }
    
  if(md_cw_cmp=="MD-CW-similar")
    { print "      <re sources=\"MD\">"md_short_gloss" ᴹᴰ "cw_short_gloss" ᶜᵂ</re>";
      print "      <re2 sources=\"MD\">"md_short_gloss" ᴹᴰ "cw_short_gloss" ᶜᵂ</re2>"; 
    }
    
  if(md_cw_cmp=="MD-CW-broad/narrow")
    { print "      <re sources=\"MD\">"md_short_gloss" ᴹᴰ</re>";
      print "      <re2 sources=\"MD\">"md_short_gloss" ᴹᴰ</re2>";
      print "      <re sources=\"CW\">"cw_short_gloss" ᶜᵂ</re>";
      print "      <re2 sources=\"CW\">"cw_short_gloss" ᶜᵂ</re2>";
    }

  if(md_cw_cmp=="MD-only")
    { print "      <re sources=\"MD\">"md_short_gloss" ᴹᴰ</re>";
      print "      <re2 sources=\"MD\">"md_short_gloss" ᴹᴰ</re2>";
    }

  print "      <t rank=\""rank"\" pos=\""CRKPOS"\">"CRKLEX"</t>"
  print "   </tg>";
  print "   </mg>";

}
END { print "</e>";
  print "</r>";
}'    

# <e>
#    <lg xml:lang="eng">
#      <l pos="POS">EnglishWord</l>
#    </lg>
#    <mg>
#    <tg xml:lang="crk">
#       <re sources="CW">glosses similar with key-overlap, but not the same</re>
#       <re sources="MD">glosses similar with key-overlap, but not the same</re>
#       <t pos="CRKPOS">CreeWord</t>
#          <lc>SUBTYPE</lc>
#    </tg>
#    </mg>
# </e>


