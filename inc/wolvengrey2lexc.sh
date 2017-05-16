#!/bin/sh

# wolvengrey2lexc.sh

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

# Wolvengrey verb classes
#
# 4474  VAI-v
# 1468  VTI-1
# 1176  VTA-1
#  826  VII-v
#  626  VII-n
#  570  VTA-2
#  360  VTI-2
#  340  VTA-3
#  324  VTA-4
#  191  VAI-n
#    6  VTI-3
#   4  VTA-5

# Arok -> FST
# VII-v -> VIIw
# VII-v (singular) -> VIIw_SG
# VII-v (plural) -> VIIw_PL
# VII-n -> VIIn
# VII-n (singular) -> VIIn_SG
# VII-n (plural) -> VIIn_PL

# VAI-n -> VAIn 
# VAI-n (plural) -> VAIn_PL 
# VAI-v (plural) -> VAIw
# VAI-v -> VAIw_PL

# VTI-1 -> VTI
# VTI-1 (plural) -> VTI_PL
# VTI-2 -> VAIw 
# VTI-3 -> VAIw

# VTA-1 -> VTA
# VTA-2 -> VTAvw w- > w2 (except kiskinohamawêw)
# VTA-2 (plural) -> VTAvw_PL
# VTA-3 -> VTAcw
# VTA-4 -> VTAt; t- > t3
# VTA-5 (ahêw, [wîhkistêw]) -> VTAi (i- > i2)
# VTA-5 (ay-itêw) -> VTAti

tr -d '"' |

gawk -v CLASS=$1 'BEGIN { FS="\t"; class=CLASS; print "LEXICON STEMLIST"; print ""; }
NR>1 { lex=$1; pos=$3; gloss=$4; note1=$10; note2=$11; stem=$16; clex="";
gsub("ý","y",lex); gsub("[ ]*$","",lex); gsub("[!?]","",lex);
gsub("^[ ]*","",stem); gsub("[ ]*$","",stem); gsub("[-]$","",stem); gsub("ý","y",stem);
gsub("[ ]*","",pos); gsub("^[ ]*","",gloss);
gsub("^[ ]*","",note1); gsub("^[ ]*","",note2);

if(class=="N")
{
  if(pos=="NA-1" || pos=="NA-2" || pos=="NA-3" || pos=="NA-4") clex="ANDECL";
  # if(pos=="NA-3") clex="ANimDECL";
  # if(pos=="NA-4") clex="ANimDECL";
  if(pos=="NA-4w") clex="ANimDECLw";
  if(pos=="NI-1" || pos=="NI-2" || pos=="NI-3")  clex="INDECL";
  if(pos=="NI-4") { clex="INimDECL"; note2=note2" NI-4" }
  if(pos=="NI-4w") { clex="INimDECLw-ONESYLL-SG"; gsub(".$","",stem); }
  #if(clex!="" && match(lex,"[aeiouâêîôAEIOUÂÊÎÔ]$")!=0)
  #  clex=clex"isis";
  if(pos=="NI-4" && match(lex,"^(.+[-])*ôsi$")!=0)
    { clex="INDECLosi"; stem=lex; gsub("ôsi$","ô",stem); }
  
  if(clex!="" && lex!=stem && (pos=="NA-3" || pos=="NA-4w" || pos=="NI-3" || pos=="NI-4w" || clex=="INDECLosi"))
    printf "%s:%s %s \"%s\" ;", lex, stem, clex, gloss;
  else
    if(clex!="")
      printf "%s %s \"%s\" ;", lex, clex, gloss;
  if(clex!="")
    if(note1!="" || note2!="")
       printf " ! %s %s\n", note1, note2;
    else
      printf "\n";
}

if(class=="V")
{
# if(pos=="VAI-n" || pos=="VAI-v")
#  { if(stem!=lex && match(lex,"w$")!=0)
#      clex="IACONJw";
#    else
#      clex="IACONJ";
#  } 
if(pos=="VII-v")
  { clex="VIIw"; }
if(pos=="VII-v" && (lex=="atihkamêkoskâw" || lex=="kîskatâwahkâw" || lex=="miyimâwahcâw" || lex=="sakâw" || lex=="sîkipêstâw" || lex=="sôhkiyowêw")) 
  { clex="VIIw_SG"; }
if(pos=="VII-v" && match(lex,"a$")!=0) 
  { clex="VIIw_PL"; }
if(pos=="VII-n") 
  { clex="VIIn"; }
if(pos=="VII-n" && (lex=="misi-yôtin" || lex=="mispon" || lex=="wâsêskwan")) 
  { clex="VIIn_SG"; }
if(pos=="VII-n" && match(lex,"a$")!=0) 
  { clex="VIIn_PL"; }
if(pos=="VAI-n")  
  { clex="VAIn"; }
if(pos=="VAI-n" && match(lex,"ak$")!=0) 
  { clex="VAIn_PL"; }
if(pos=="VAI-v") 
  { clex="VAIw"; }
if(pos=="VAI-v" && match(lex,"ak$")!=0) 
  { clex="VAIw_PL"; }
if(pos=="VTI-1")
  { clex="VTI"; }
if(pos=="VTI-1"&& match(lex,"ak$")!=0) 
  { clex="VTI_PL"; }
if(pos=="VTI-2")  
  { clex="VAIw"; }
if(pos=="VTI-3") 
  { clex="VAIw"; }
if(pos=="VTA-1")
  { clex="VTA"; }
if(pos=="VTA-2") # w- > w2 (except kiskinohamawêw)
  { clex="VTAvw";
    if(lex!="kiskinohamawêw")
      sub("w$","w2",stem);
  }
if(pos=="VTA-2"&& match(lex,"ak$")!=0) 
  { clex="VTAvw_PL"; }
if(pos=="VTA-3")
  { clex="VTAcw"; }
if(pos=="VTA-4") # t- > t3
  { clex="VTAt";
    sub("t$","t3",stem);
  }
if(pos=="VTA-5" && (lex=="ahêw" || lex=="wîhkistêw")) # (ahêw, [wîhkistêw]) (i- > i2)
  { clex="VTAi";
    stem=stem "i2";
  }
if(pos=="VTA-5" && lex=="ay-itêw") # (ay-itêw) 
  { clex="VTAti"; }

# if(pos=="VTA-1" || pos=="VTA-2" || pos=="VTA-3" || pos=="VTA-4")
#  { clex="TACONJ";
#  }

  if(clex!="" && stem==lex)
    printf "%s %s \"%s\" ;", lex, clex, gloss;
  if(clex!="" && stem!=lex)
    printf "%s:%s %s \"%s\" ;", lex, stem, clex, gloss;
  if(clex!="")
    if(note1!="" || note2!="")
       printf " ! %s %s\n", note1, note2;
    else
      printf "\n";
}

if(class=="I")
{ if(pos=="IPC" || pos=="IPJ" || pos=="IPC ;; IPJ")
    clex="pcle";
  if(pos=="IPH")
    { clex="pcle";
      gsub(" ","% ",lex);
    }
  if(index(gloss,"!")!=0)
    gsub("!"," [excl]",gloss);
  if(clex!="")
    printf "%s %s \"%s\" ;\n", lex, clex, gloss;
}
}'

#  191 IACONJ_n
# 4473 IACONJ_v
#  626 IICONJ_n
#  826 IICONJ_v
# 1176 TACONJ_1
#  570 TACONJ_2
#  340 TACONJ_3
#  324 TACONJ_4
#    4 TACONJ_5
# 1468 TICONJ_1
#  360 TICONJ_2
#    6 TICONJ_3

# 934  IPC
# 250  IPV
# 160  IPH
#  91  IPJ
#  64  IPN
#   9  IPC ;; IPJ
#   4  IPP
