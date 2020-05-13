#!/bin/sh

# wolvengrey2lexc.sh

# transforms Wolvengrey's dictionary content to the lexc format

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

gawk -v CLASS=$1 'BEGIN { FS="\t"; class=CLASS; }
{ while((getline line[++nr])!=0)
        { n=split(line[nr],s,"\t");
          for(i=1; i<=n; i++)
             f[nr, i]=s[i];
        }        
  for(i=1; i<=nr; i++)
   { lemma=f[i, 1]; pos=f[i, 3]; gloss=f[i, 4]; note1=f[i, 10]; note2=f[i, 11];
     clex=""; flags=""; check="";
     # lex=$1; pos=$3; gloss=$4; note1=$10; note2=$11; clex=""; flags=""; check="";
     if(f[i, 15]!="") # Use \fststem column instead of \stem, if such is provided
       stem=f[i, 15];
     else
       stem=f[i, 16];
     gsub("[ ]*$","",lemma); gsub("[!?]","",lemma); # Proto-Algonquian -ý- only removed just before printing LEXC output
     gsub("^[- ]*","",stem); gsub("[- ]*$","",stem); # gsub("ý","y",stem);
     gsub("[ ]*","",pos); gsub("[ ]*$","",pos);
     gsub("^[ ]*","",gloss); gsub("[ ]*$","",gloss);
     gsub("^[ ]*","",note1); gsub("[ ]*$","",note1);
     gsub("^[ ]*","",note2); gsub("[ ]*$","",note2);
     gsub("ń","n",lemma); gsub("ń","n",stem);

#####
# NOUNS: AEW classes to contlexes in new crk FST:
#
# Independent NA AEW to FST conversion
# NA-1, NA-2 -> NA
# NA-3 -> NA + stem-final -w
# NA-4, NA-4w -> NA_SG/A_POSS/IM -w2, y4 (immutable)
#
# Independent NI AEW to FST conversion
# NI-1, NI-2 -> NI
# NI-3 -> NI + -w (stem)
# NI-4, NI-4w -> NI_SG/I_POSS/IM, with w2, y4 for the immutable final glides
#
# NI-5  derivations of -was "bag" -> PL:  (UNIMPLEMENTED)
# TODO: marking stems that require -im with contlex of type N...POSS/IM
#####

     if(class=="N")
     {
       if(match(pos,"^N[^D]")!=0)
         contlex="NOUN_INDEP_STEMS";
       if(match(pos,"^ND")!=0 && match(lemma,"^m")==0)
         { contlex="NOUN_DEP_KINSHIP_STEMS";
           # lemma="-"stem; # Use Px1Sg form as lemma
         }
       if(match(pos,"^ND")!=0 && match(lemma,"^m")!=0)
         contlex="NOUN_DEP_NONKINSHIP_STEMS";

       if(index(stem,"(t)")!=0)
         { sub("\\(t\\)","t",stem);
           sub("\\(t\\)","",lemma); # CSV: is the epenthetic -t- part of the lemma? (as it is part of the stem).
         }

       # NOUNS: Animate + Independent -> +N+A
       # pahkwêsikan NA_POSS/IM "bannock" ; ! AEW NA-1 (Consonant-Initial Regular NA Stem)
       # asikan NA "sock" ; ! AEW NA-1 (Vowel-Initial Regular NA Stem)
       # kihc-ôkiniy NA "tomato" ; ! AEW NA-2 (Consonant-Initial Vowel-Glide NA Stem)
       # ayapiy NA "net" ; ! AEW NA-2 (Vowel-Initial Vowel-Glide NA Stem)
       # kwâpahikan NA "ladle" ; ! AEW NA-1 (Consonant-Initial Regular NA Stem)
       # masinahikanâhtik:masinahikanâhtikw NA "pencil" ; ! AEW NA-3 (Consonant-Initial Consonant-/w/ NA Stem)
       # askihk:askihkw NA_POSS/IM "kettle, pail" ; ! AEW NA-3 (Vowel-Initial Consonant-/w/ NA Stem)
       # niska:nisk NA_SG/A_POSS/IM "goose" ; ! AEW NA-4 (Consonant-Initial Single-Syllable NA Stem)
       # sihta:siht NA_SG/A_POSS/IM "spruce" ; ! AEW NA-4 (Consonant-Initial Single-Syllable NA Stem)
       # êsa:ês NA_SG/A_POSS/IM "clam; shell" ; ! AEW NA-4 (Vowel-Initial Single-Syllable NA Stem)
       # wâhkwa:wâhkw NA_SG/A_POSS/IM "roe, fish eggs; lump of roe" ; ! AEW NA-4w (Consonant-Initial Single-Syllable-/w/ NA Stem)
       # ihkwa:ihkw NA_SG/A_POSS/IM "louse" ; ! AEW NA-4w (Vowel-Initial Single-Syllable-/w/ NA Stem)

       # To be added in notes in CSV source:
       # AEW: askihk, pahkwêsikan as having -im- with NA_POSS/IM - fixed in this AWK script, to be coded generally by AEW
       # AEW: kihci-okiniy as "standard" form for kihc-okiniy - FIXED IN CSV

       if(pos=="NA-1" || pos=="NA-2")
         { clex="NA";
           if(lemma=="pahkwêsikan") clex="NA_POSS/IM";
         }
       if(pos=="NA-3" && lemma!="atim")
         { clex="NA"; if(lemma"w"!=stem) check="CHECK!";
           if(lemma=="askihk") clex="NA_POSS/IM";
         }
       if(pos=="NA-4")
         { clex="NA_SG/A_POSS/IM"; stem2=lemma; sub(".$","",stem2); if(stem2!=stem) check="CHECK!"; sub("w$","w2",stem); sub("y$","y4",stem); }
       if(pos=="NA-4w")
         { clex="NA_SG/A_POSS/IM"; stem2=lemma; sub(".$","",stem2); if(stem2!=stem) check="CHECK!"; }

       # NOUNS: Inanimate + Independent -> +N+I
       # askiy NI "land" ;
       # cîmân NI "canoe" ; ! AEW NI-1 (Consonant-Initial Regular NI Stem)
       # astotin NI "hat" ; ! AEW NI-1 (Vowel-Initial Regular NI Stem)
       # maskihkiy NI "medicine" ; ! AEW NI-2 (Consonant-Initial VW NI Stem)
       # mîkisasâkay NI "beaded coat, beaded dress" ; ! AEW NI-2 (Consonant-Initial VW NI Stem)
       # oskasâkay NI "new coat, new dress" ; ! AEW NI-2 (Vowel-Initial VW NI Stem)
       # pahkêkin:pahkêkinw NI "leather, rawhide" ; ! AEW NI-3 (Consonant-Initial Cw NI Stem)
       # askêkin:askêkinw NI "fresh rawhide" ; ! AEW NI-3 (Vowel-Initial Cw NI Stem)
       # wâwi:wâw2 NI_SG/I_POSS/IM "egg" ; ! AEW NI-4 (Consonant-Initial Single-Syllable NI Stem)
       # osk-âyi:osk-ây4 NI_SG/I_POSS/IM "new item, new thing" ; ! AEW NI-4 (Vowel-Initial Single-Syllable NI Stem)
       # mihko:mihkw NI_SG/I_POSS/IM "blood" ; ! AEW NI-4w (Consonant-Initial Single-Syllable-/w/ NI Stem)

       # CSV: NI: oskasakay -> oskasâkay in stems!

       if(pos=="NI-1" || pos=="NI-2")
         clex="NI";
       if(pos=="NI-3")
         { clex="NI"; if(lemma"w"!=stem) check="CHECK!"; }
       if(pos=="NI-4")
         { clex="NI_SG/I_POSS/IM"; stem2=lemma; sub(".$","",stem2); if(stem2!=stem) check="CHECK!"; sub("w$","w2",stem); sub("y$","y4",stem); }
       if(pos=="NI-4w")
         { clex="NI_SG/I_POSS/IM"; stem2=lemma; sub(".$","",stem2); if(stem2!=stem) check="CHECK!"; }

       # NOUNS: Animate + Dependent + Non-kinship
       # masakay:asakay NAD "skin" ;
       # mitâs:tâs NAD "pair of pants" ; ! AEW NDA-1 (Consonant initial regular stem)
       # môhpan:ohpan NAD "lung" ; ! AEW NDA-1 (Vowel initial regular stem) note that in 3rd person the w- does not surface
       # mitihtihkosiy:tihtihkosiy NAD "kidney" ; ! AEW NDA-2 (Consonant initial regular VG stem) N.B. also occurs as the stems tihtikosiw and tihtikos (the latter is an NDI-1 declension)
       # maskasiy:askasiy NAD "finger nail/claw" ; ! AEW NDA-2 (Vowel Initial VG stem) 

       # NOUNS: Animate + Dependent + Kinship (non-vocatives)
       # nôhkom:ohkom NAD "grand-mother" ;
       # nôhtâwiy:ohtâwiy NAD "father" ;
       # nitânis:tânis NAD "daughter, brother, sister" ;
       # ninîkihik:nîkihikw NAD "parent" ; ! AEW NDA-3 (Consonant initial Vw stem) Deal later: can also be the stem <wiyihkw> or <iyihkw>. <wiyihkw> and <iyihkw> can occur in locative. The <nîkihik> can not.
       # nîtim:îtimw NAD "cross-cousin of opposite gender" ; ! AEW NDA-3 (Cowel initial Vw stem).
       # nîw:îw2 NAD_SG/A "wife" ; ! AEW NDA-4 (Vowel initial sing syllable NDA-4 stem). N.B. Only one of its type.
       # @P.loc.NULL@-îskw:@P.loc.NULL@îskw NAD_SG/A "fellow wife; husbands ex" ; ! AEW NDA-4w (Vowel initial single-syllable-/w/ stem). N.B. Only one of its type. Cannot take the locative (marked here with a flag-diacritic, which could be incorporated in a new set of NON-LOC contlexes).

       # MISSING IN CSV? AA: FIXED
       # môhpan -> -ohpan:ohpan NAD "lung" (no PxX form in the YAML)
       # mitihtihkosiy : missing -h- in YAML file: FIXED

       if(index(pos,"NDA")!=0 && index(note1,"vocative")==0)
         { if(pos=="NDA-1" || pos=="NDA-2")
             clex="NAD";
           if(pos=="NDA-3")
             { clex="NAD"; sub("w$","",lemma); if(match(stem,"w$")==0) check="CHECK!"; }
           if(pos=="NDA-4")
             { clex="NAD_SG/A"; sub("w$","w2",stem); sub("y$","y4",stem); }
           if(pos=="NDA-4w")
             clex="NAD_SG/A";
           if(lemma=="nîskw") flags="@P.loc.NULL@"; # FIXED - CONTLEX CODE WAS INCORRECT
         }

       # NOUNS: Inanimate + Dependent + Non-kinship (no non-kinships NDIs)
       # mihtawakay:htawakay NID "ear" ;
       # mispiton:spiton NID "arm" ;
       # miyaw:iyaw2 NID ;
       # mitêh:têh NID "heart" ; ! AEW NDI-1 (Consonant Initial Regular stem)
       # mîpit:îpit NID "tooth" ; ! AEW NDI-1 (Vowel Initial Regular stem)
       # miskotâkay:skotâkay NID "coat/dress" ; ! AEW NDI-2 (Consonant Initial VW stem)
       # mêstakay:êstakay NID "hair" ; ! AEW NDI-1 (Vowel Initial VW stem)
       # miskîsik:skîsikw NID "eye" ; ! AEW NDI-3 (Consonant Initial Cw stem)
       # mayakask:ayakaskw NID "palate" ; ! AEW NDI-3 (Vowel Initial Cw stem)
       # mîki -> nîki:îk NID_SG/I "home" ; ! AEW NDI-4 (Vowel Initial Single Syllable NDI-4 stem) N.B. Does not usually work unpossessed or plural unless distributive. CHANGE NO PxX form
       # @P.number.SG@mîni -> -în:@P.number.SG@în NID_SG/I "bone-marrow" ; ! AEW NDI-4 (Vowel Initial Single Syllable NDI-4 stem) N.B. might cause issue with <î>, also is a mass noun that is never plural. REMOVE INSTEAD OF wîni:wîn NI_SG/I_POSS/IM
       # nîwas:îwat3 NID "sacred bundle" ; ! AEW NID Irregular(?) VW single-syllable stem. N.B. T->s when word final. (cannot be PxX)

       # CHANGES TO SOURCE CSV:
       # stem: -îk- => lemma: mîki : AEW: KEEP -îk lemma / AA: NOTHING TO FIX
       # stem: -în- => lemma: mîni : AEW: REMOVE AND INCLUDE NEW wîni:wîn NI_SG/I_POSS/IM
       # lemma: mêstakaya (pl) -> mêstakay (sg) "hair" : INCLUDE SINGULAR mêstakay as lemma / AA: FIXED

       # NOUNS: Inanimate + Dependent

       # OTHER CHANGES: initial (t) in DEP nouns: include as part of stem, but how about lemma?

       if(pos=="NDI-1" || pos=="NDI-2")
         clex="NID";
       if(pos=="NDI-3")
         { clex="NID"; if(match(stem,"w$")==0) check="CHECK!"; }
       if(pos=="NDI-4")   # Maybe not needed
         clex="NID_SG/I"; # Maybe not needed
       if(lemma=="miyaw") stem="iyaw2";
       if(lemma=="mîni") flags="@P.number.SG";
       if(lemma=="nîwas") { clex="NID"; stem="îwat3"; }

       if(index(note1,"diminutive")!=0)
         flags="@P.dim.DIM@";
     
       gsub("ý","y",lemma); # Undo marking historical -y- before outputting LEXC code
       gsub("ý","y",stem);
     
       if(clex!="")
         { if(lemma!=stem)
              output[contlex] = output[contlex] sprintf("%s%s:%s%s %s \"%s\" ;", flags, lemma, flags, stem, clex, gloss);
           else
             output[contlex] = output[contlex] sprintf("%s%s %s \"%s\" ;", flags, lemma, clex, gloss);
           output[contlex] = output[contlex] " ! AEW: " pos
           if(note1!="") note1="-";
           if(note2=="") note2="-";
           if(note1!="-" || note2!="-")
             output[contlex] = output[contlex] sprintf(" ! 1: %s ! 2: %s", note1, note2);
           if(check!="")
             output[contlex] = output[contlex] sprintf(" ! %s", check);
           output[contlex] = output[contlex] sprintf("\n");
         }
  # Irregular nouns:
  # Suppletive: atim => atimw- vs. -têm-
  if(lemma=="atim")
    { output["NOUN_INDEP_STEMS"] = output["NOUN_INDEP_STEMS"] "@R.person.NULL@atim:@R.person.NULL@atimw NA \"dog, beast of burden\" ; ! Regular stem of atim: atimw- (cannot be possessed)\n";
      output["NOUN_INDEP_STEMS"] = output["NOUN_INDEP_STEMS"] "@D.person.NULL@atim:@D.person.NULL@têm NA \"dog, beast of burden\" ;   ! Irregular suppletive stem of atim: -têm- (must be possessed)\n"
    }
  }

# VII
# wâpiskâw:wâpiskâ VII-1 ;
# ayâw:ayâ VII-1 ;
# mispon:mispon3 VII-2 ;
# VAI
# acimow:acimo VAI-1 ;
# nipâw:nipâ VAI-1 ;
# itwêw:itwê VAI-1 ;
# VTI
# wâpahtam:wâpaht4 VTI-1 ;
# itam:it VTI-1 ;
# VTA
# mowêw:mow2 VTA-1 ;
# acimêw:acim VTA-1 ;
# itêw:it3 VTA-2 ;

if(class=="V" && index(lemma," ")==0) # No multipart lemmas, e.g. "namoya wapiw" (not see, i.e. be blind)
{

# VII
# osâwâw:osâwâ VIIw ;
# mihkwâw:mihkwâ VIIw ;
# nîpin:nîpin3 VIIn ;
# mispon VIIn_PL ; ! only occurs in plural
# pimamon VIIn ;
# mâyâtan:mâyâtan3 VIIn ;
# miywâsin VIIn ;

if(pos=="VII-v")
  { clex="VIIw"; }
if(pos=="VII-v" && (lemma=="atihkamêkoskâw" || lemma=="kîskatâwahkâw" || lemma=="miyimâwahcâw" || lemma=="sakâw" || lemma=="sîkipêstâw" || lemma=="sôhkiyowêw")) 
  { clex="VIIw_SG"; }
if(pos=="VII-v" && match(lemma,"a$")!=0) 
  { clex="VIIw_PL"; }
if(pos=="VII-n") 
  { clex="VIIn"; }
if(pos=="VII-n" && (lemma=="misi-yôtin" || lemma=="mispon" || lemma=="wâsêskwan")) 
  { clex="VIIn_SG"; }
if(pos=="VII-n" && match(lemma,"a$")!=0) 
  { clex="VIIn_PL"; }
if(match(lemma,"an$")!=0) || lemma=="nîpin" || lemma=="âpihtâ-nîpin" || match(lemma,"^(.+[-])?pipon$")!=0) # EXPANSION: n3 for all -an final II verbs, and selected -in, and -on final VII verbs
  sub("n$","n3",stem);

# VAI
# apiw:api VAIw ;
# atoskêw:atoskê VAIw ;
# mâtow:mâto VAIw ; # YAML file needs to be corrected as to long -â-
# mîcisow:mîciso VAIw ;
# nêhiyawêw:nêhiyawê VAIw ;
# nipâw:nipâ VAIw ;
# pimisin:pimisin3 VAIn ;

if(pos=="VAI-n")  
  { clex="VAIn"; sub("n$","n3",stem); } # except nîminâniwan (which is an inflected form of "nîmiw")
if(pos=="VAI-n" && match(lemma,"ak$")!=0) 
  { clex="VAIn_PL"; }
if(pos=="VAI-v") 
  { clex="VAIw"; }
if(pos=="VAI-v" && match(lemma,"ak$")!=0) 
  { clex="VAIw_PL"; }

# VTI
# kâtâw:kâtâ VTIw ;
# kîsihtâw:kîsihtâ VTIw ;
# mîciw:mîci VTIw ;
# wâpahtam:wâpaht4a VTIm ; ! Check status of -a
# nâtam:nâta VTIm ;

if(pos=="VTI-1")
  { clex="VTIm"; stem=stem"a"; }
if(pos=="VTI-1"&& match(lemma,"ak$")!=0) 
  { clex="VTIm_PL"; stem=stem"a"; }
if(pos=="VTI-2")  
  { clex="VTIw"; }
if(pos=="VTI-3") 
  { clex="VTIw"; }

# sub("t","t4","wâpahta")

# VTA
# kîskiswêw:kîskisw VTA;  ! w:0 for collapsing cases
# atoskahêw:atoskah VTA ;
# miskawêw:miskaw VTA ;
# mowêw:mow2 VTA ;        ! w->w2 for non-collapsing cases
# nakatêw:nakat3 VTA ;        ! t3:s in some cases
# nâtêw:nât3 VTA ;
# nitonawêw:nitonaw VTA ; ! w->w2for collapsing cases?
# wâpamêw:wâpam VTA ;
# wîcihêw:wîcih VTA ;
# mêstasîhkawêwak:mêstasîhkaw VTA_PL ; ! "generally" plural according to AEW
#
# itêw:it3 VTAi ;
# kostêw:kost3 VTA ;      ! s:0 when preceeding t3:s
# ayâwêw:ayâw2 VTA ;      ! w2:w for non-collapsing cases

if(pos=="VTA-1")
  { if(lemma!="itêw")
      clex="VTA";
    if(lemma=="mowêw")
      stem="mow2";
    if(lemma=="itêw") # itêw  --> iti in IMP2SG
      { clex="VTAi"; stem="it3"; }
  }
if(pos=="VTA-2") # w -> w2 (except kiskinohamawêw)
  { clex="VTA";
#    if(lemma!="kiskinohamawêw")
#      sub("w$","w2",stem);
  }
if(pos=="VTA-2"&& match(lemma,"ak$")!=0) 
  { clex="VTA_PL"; }
if(pos=="VTA-3")
  { clex="VTA"; }
if(pos=="VTA-4") # t -> t3
  { clex="VTA";
    sub("t$","t3",stem);
  }
if(pos=="VTA-5")
  { if(lemma=="ahêw" || lemma=="ay-itêw")  # ahêw and ay-itêw --> ahi, iti and ay-iti in IMP2SG
      { clex="VTAi"; sub("t$","t3",stem); }
    if(lemma=="kostêw" || lemma=="wîhkistêw") # s:0 when preceeding t3:s
      { clex="VTA"; sub("t$","t3",stem); }
  }

      gsub("ý","y",lemma); # Undo marking historical -y- in lemma before outputting LEXC code
      gsub("ý","y",stem);

      contlex="VERBSTEMS";     
       if(clex!="")
         { if(lex!=stem)
              output[contlex] = output[contlex] sprintf("%s:%s %s \"%s\" ;", lemma, stem, clex, gloss);
           else
             output[contlex] = output[contlex] sprintf("%s %s \"%s\" ;", lemma, clex, gloss);
           output[contlex] = output[contlex] " ! AEW: " pos
           if(note1!="") note1="-";
           if(note2=="") note2="-";
           if(note1!="-" || note2!="-")
             output[contlex] = output[contlex] sprintf(" ! 1: %s ! 2: %s", note1, note2);
           if(check!="")
             output[contlex] = output[contlex] sprintf(" ! %s", check);
           output[contlex] = output[contlex] sprintf("\n");
         }
     }
  }
  for(c in output)
     { printf "LEXICON %s\n", c;
       print output[c];
       print "";
     }
}' | less; exit 0; # Currently word-class="I" is skipped and ignored (and probably handled already).

# N.B. IPC code hasn't been changed in the last 4 years.
# Maybe we'd want to specify multiword expressions
# as well as common contractions and typos as +Err/Orth cases

# 934  IPC
# 250  IPV
# 160  IPH
#  91  IPJ
#  64  IPN
#   9  IPC ;; IPJ
#   4  IPP

if(class=="I")
{ if(pos=="IPC" || pos=="IPJ" || pos=="IPC ;; IPJ")
    clex="pcle";
  if(pos=="IPH")
    { clex="pcle";
      gsub(" ","% ",lemma);
    }
  if(index(gloss,"!")!=0)
    gsub("!"," [excl]",gloss);
  if(clex!="")
    printf "%s %s \"%s\" ;\n", lemma, clex, gloss;
}
}'
