#!/bin/sh

# wolvengrey2lexc

# transforms Wolvengrey's dictionary content to the lexc format

# LEXICON STEMLIST
# @LEXNAME@ for nouns getting prefixes ni-, ki-, o- \\

# Sorted alphabetically
# asikan ANDECL ; !Wolv: NA1
# askekin:askekinw INDECL ; !Wolv: NI3
# askihk:askihkw ANimDECL ; !Wolv: NA3
# astotin INDECL ; !Wolv: NI1
# ayapiy ANDECL ; !Wolv: NA2
# cîmân INDECL ; !Wolv: NI1
# esa ANimDECL ; !Wolv: NA4
# ihkwa:ihkw ANimDECLw ; !Wolv: NA4w
# kihcôkiniy ANDECL ; !Wolv: NA2
# masinahikanâhtik:masinahikanâhtikw ANDECL ; !Wolv: NA3
# maskisin INDECLis ;
# mihko:mihk INimDECLw-ONESYLL-SG ; !Wolv: NI4w
# mîkisasâkay INDECL ; !Wolv: NI2
# niska ANimDECLis ; !Wolv: NA4
# oskasâkay INDECL ; !Wolv: NI2
# oskâyi INimDECL ; !Wolv: NI4
# ôsi:ô INDECLosi ; !Wolv: NI4 irr. stem
# pahkwêsikan ANimDECL ; !Wolv: NA1
# pahkêkin:pahkêkinw INDECL ; !Wolv: NI3
# wâhkwa:wâhkw ANimDECLw ; !Wolv: NA4w
# wâwi INimDECL ; !Wolv: NI4

# Sorted according to Wolvengrey POS
# maskisin INDECLis ;
# asikan ANDECL ; !Wolv: NA1
# pahkwêsikan ANimDECL ; !Wolv: NA1
# ayapiy ANDECL ; !Wolv: NA2
# kihcôkiniy ANDECL ; !Wolv: NA2
# askihk:askihkw ANimDECL ; !Wolv: NA3
# masinahikanâhtik:masinahikanâhtikw ANDECL ; !Wolv: NA3
# esa ANimDECL ; !Wolv: NA4
# niska ANimDECLis ; !Wolv: NA4
# ihkwa:ihkw ANimDECLw ; !Wolv: NA4w
# wâhkwa:wâhkw ANimDECLw ; !Wolv: NA4w
# astotin INDECL ; !Wolv: NI1
# cîmân INDECL ; !Wolv: NI1
# mîkisasâkay INDECL ; !Wolv: NI2
# oskasâkay INDECL ; !Wolv: NI2
# askekin:askekinw INDECL ; !Wolv: NI3
# pahkêkin:pahkêkinw INDECL ; !Wolv: NI3
# oskâyi INimDECL ; !Wolv: NI4
# wâwi INimDECL ; !Wolv: NI4
# mihko:mihk INimDECLw-ONESYLL-SG ; !Wolv: NI4w
# ôsi:ô INDECLosi ; !Wolv: NI4 irr. stem

# STEM VARIATION CASES

# askihk:askihkw ANimDECL ; !Wolv: NA3
# masinahikanâhtik:masinahikanâhtikw ANDECL ; !Wolv: NA3
# ihkwa:ihkw ANimDECLw ; !Wolv: NA4w
# wâhkwa:wâhkw ANimDECLw ; !Wolv: NA4w
# askekin:askekinw INDECL ; !Wolv: NI3
# pahkêkin:pahkêkinw INDECL ; !Wolv: NI3
# mihko:mihk INimDECLw-ONESYLL-SG ; !Wolv: NI4w
# ôsi:ô INDECLosi ; !Wolv: NI4 irr. stem


tr -d '"' |

gawk 'BEGIN { FS="\t"; print "LEXICON STEMLIST"; print ""; }
NR>1 { lex=$1; pos=$3; gloss=$4; stem=$15; clex="";
gsub("^[ ]*","",stem); gsub("-$","",stem);
gsub("[ ]*","",pos); gsub("^[ ]*","",gloss);
if(pos=="NA-1" || pos=="NA-2") clex="ANDECL";
if(pos=="NA-3") clex="ANimDECL";
if(pos=="NA-4") clex="ANimDECL";
if(pos=="NA-4w") clex="ANimDECLw";
if(pos=="NI-1" || pos=="NI-2")  clex="INDECL";
if(pos=="NI-3") clex=="INDECL";
if(pos=="NI-4") { clex="INimDECL"; gloss=gloss" ! NI-4"; }
if(pos=="NI-4w") { clex="INimDECLw-ONESYLL-SG"; gsub(".$","",stem); }
if(clex!="" && lex!=stem && (pos=="NA-3" || pos=="NA-4w" || pos=="NI-3" || pos=="NI-4w"))
   printf "%s:%s %s \"%s\" ;\n", lex, stem, clex, gloss;
else
  if(clex!="")
    printf "%s %s \"%s\" ;\n", lex, clex, gloss;
}'
