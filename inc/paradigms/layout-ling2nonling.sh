#!/bin/sh

# ling2eng.sh

# Usage:

# cat linguistic-layout-file.csv | ling2nonling.sh > non linguistic-layout-file.csv

# N.B.1 Intended for the CSV layout source file
# N.B.2 Focuses now on actors, goals and possessors
# N.B.3 Tenses, modes, diminitives excluded now

gawk 'BEGIN { FS="\t"; OFS="\t"; }
# Determination of paradigm part-of-speech class/subclass
NR==2 { if(index($0,"verb-ta")!=0)
          pos="VTA";
        if(index($0,"verb-ti")!=0 || index($0,"verb-ai")!=0)
          pos="VAI/VTI";
        if(index($0,"verb-ii")!=0)
          pos="VII";
        if(index($0,"noun")!=0)
          pos="NOUN";
  print;
}
NR!=2 {
  { # TA verbs
  if(pos=="VTA")
  { 
    sub("1p →","we →")
    sub("1s →","I →")
    sub("21 →","you and we →")
    sub("2p →","you (all) →")
    sub("2s →","you (one) →")
    sub("3p →","they →")
    sub("3s →","s/he →")
    sub("4 →","s/he/they (further) →")
    sub("5 →","s/he/they (furthest) →")
    sub("X →","someone →")
    sub("→ 1p","→ us")
    sub("→ 1s","→ me")
    sub("→ 21","→ you and us")
    sub("→ 2p","→ you (all)")
    sub("→ 2s","→ you (one)")
    sub("→ 3p","→ them")
    sub("→ 3s","→ him/her")
    sub("→ 4","→ him/her/them (further)")
    sub("→ 5","→ him/her/them (furthest")
  }

  # TI, AI verbs
  if(pos=="VAI/VTI")
  { 
    sub("1p","we")
    sub("1s","I")
    sub("21","you and we")
    sub("2p","you (all)")
    sub("2s","you (one)")
    sub("3p","they")
    sub("3s","s/he")
    sub("4s","s/he (further)")
    sub("4p","they (further)")
    sub("4","s/he/they (further)")
    sub("5","s/he/they (furthest)")
    sub("X","someone")
  }

  # II verbs
  if(pos=="VII")
  { 
    sub("3p","they")
    sub("3s","it")
    sub("4s","it (further)")
    sub("4p","they (further)")
  }

  # Nouns
  if(pos=="NOUN")
  { 
    sub("1p","our")
    sub("1s","my")
    sub("21","your and our")
    sub("2p","your (all)")
    sub("2s","your (one)")
    sub("3p","their")
    sub("3s","his/her")
    sub("4","his/her/their (further)")
    sub("5","his/her/their (furthest)")
    sub("X","someone£s")
  }

# Output modified and nonmodified lines
  print;
}
}' |

# Convert place-holder to apostrophe for: someone's
tr "£" "'"

