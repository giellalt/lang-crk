#!/bin/sh

# wolvengrey-new2lexc.sh

# Transforms Wolvengrey's Cree Words (CW) dictionary content to LEXC format,
# based on a TSV conversion of CW Toolbox source where an additional column has
# been added to specify a FST-stem, when needed.

# Usage:
# cat CW.tsv | wolvengrey-new2lexc.sh 1:WC 2:FULL

# where:
# 1:WC = (general) wordclass (N, V, I, PVN) # N.B. PVN not yet fully implemented
# 2:FULL = whether English glosses and other grammatical information is output

tr -d '"' |

gawk -v CLASS=$1 -v FULL=$2 'BEGIN { FS="\t"; class=CLASS; full=FULL; }
{ line[++nr]=$0;
  n=split(line[nr],s,"\t");
  for(i=1; i<=n; i++)
     f[nr, i]=s[i];
}
END {
  for(j=1; j<=n; j++)
     {
       if(f[1, j]=="\\sro") lemma_col=j;
       if(f[1, j]=="\\ps") pos_col=j;
       if(f[1, j]=="\\def") gloss_col=j;
       if(f[1, j]=="\\stm") stem_col=j;
       if(f[1, j]=="\\fststem") fststem_col=j;
       if(f[1, j]=="\\gr1") note1_col=j;
       if(f[1, j]=="\\gr2") note2_col=j;
     }
for(i=2; i<=nr; i++)
   { lemma=f[i, lemma_col]; pos=f[i, pos_col]; gloss=f[i, gloss_col]; note1=f[i, note1_col]; note2=f[i, note2_col];
     clex=""; flags=""; check="";
     # lex=$1; pos=$3; gloss=$4; note1=$10; note2=$11; clex=""; flags=""; check="";
     if(f[i, fststem_col]!="") # Use \fststm column instead of \stm, if such is provided
       stem=f[i, fststem_col];
     else
       stem=f[i, stem_col];
     gsub("[ ]*$","",lemma); gsub("[!?]","",lemma); # gsub("ý","y",lemma); # Proto-Algonquian -ý- only removed just before printing LEXC output
     gsub("^[- ]*","",stem); gsub("[- ]*$","",stem); # gsub("ý","y",stem); # Proto-Algonquian -ý- only removed just before printing LEXC output
     gsub("[ ]*","",pos); gsub("[ ]*$","",pos);
     gsub("^[ ]*","",gloss); gsub("[ ]*$","",gloss);
     gsub("^[ ]*","",note1); gsub("[ ]*$","",note1);
     gsub("^[ ]*","",note2); gsub("[ ]*$","",note2);
     gsub("ń","n",lemma); gsub("ń","n",stem); # Another dialectal variation

#####
# NOUNS: AEW classes to contlexes in new crk FST:
#
# Independent NA AEW to FST conversion
# NA-1, NA-2 -> NA
# NA-3 -> NA + stem-final -w (underlying stem-final, coded in CW)
# NA-4, NA-4w -> NA_SG/A_POSS/IM + stem-final -w2, y4 (coding final glides as immutable)
#
# Independent NI AEW to FST conversion
# NI-1, NI-2 -> NI
# NI-3 -> NI + stem-final -w (underlying stem-final, coded in CW)
# NI-4, NI-4w -> NI_SG/I_POSS/IM + stem-final w2, y4 (final glides as immutable)
#
# NI-5  derivations of -was "bag" -> PL:  (UNIMPLEMENTED)
# TODO: marking stems that require -im with contlex of type N...POSS/IM
#
# All nouns to have only the short diminutive -is,
# unless corpus or other data indicates otherwise
#####

     if(class=="N" && index(lemma," ")==0) # No multipart lemmas, such as names (that should probably rather be IPMs)
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
           sub("\\(t\\)","",lemma);S # CSV: is the epenthetic -t- part of the lemma? (as it is part of the stem).
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
       if(lemma=="ôsi")
         { clex="NI_SG/I_POSS/IM"; stem="ôs"; }

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

       # Flagging lexicalized diminutive forms, which cannot be further diminutivized
       if(index(note1,"diminutive")!=0)
         { flags="@P.dim.DIM@";
           sub("^.","&^DIM",stem);
         }

       # Restricting diminutivization to the short form -is, unless otherwise specified 
       if(clex!="" && index(clex,"DIM")==0 && index(flags,"DIM")==0)
         clex=clex"_DIM/IS";

       # Marking plural only nouns
       if(index(note1,"plural")!=0 && match(lemma,"a(k)?$")!=0)
         flags=flags "@P.number.PL@";
     
       # gsub("ý","y",lemma); # Undo marking historical -y- before outputting LEXC code
       # gsub("ý","y",stem);
     
       if(clex!="")
         { if(lemma!=stem && stem!="")
              output[contlex] = output[contlex] sprintf("%s%s:%s%s %s", flags, lemma, flags, stem, clex);
           else
             output[contlex] = output[contlex] sprintf("%s%s %s", flags, lemma, clex);
           if(full=="full")
             { output[contlex] = output[contlex] sprintf(" \"%s\" ;", gloss); 
               output[contlex] = output[contlex] " ! AEW: " pos
               if(note1!="") note1="-";
               if(note2=="") note2="-";
               if(note1!="-" || note2!="-")
               output[contlex] = output[contlex] sprintf(" ! 1: %s ! 2: %s", note1, note2);
             }
           else
             output[contlex] = output[contlex] sprintf(" ;");
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

########
# VERBS: AEW classes to contlexes in new crk FST:
#
# VII VERBS
# VII-1v -> VIIw_SG (impersonal - singular only)
# VII-2v + lemma: not ending with plural -a suffix -> VIIw (regular sg+pl)
# VII-2v + lemma: ending with plural -a suffix -> VIIw_PL (plural only)
# VII-1n -> VIIn_SG (impersonal) + stem-final coding: -an -> -an3; -pipon -> -pipon3
# VII-2n -> VIIn (regular) + stem-final coding: -an -> -an3; -pipon -> -pipon3
# VII-2n + lemma: ending with plural -a suffix -> VIIn_PL (plural only) + stem: -an -> -an3; -pipon -> -pipon3
#
# VAI VERBS
# VAI-1 + lemma: not ending in plural -ak suffix + stem: ending in [aâê] -> VAIae (regular -a/e vowel-final)
# VAI-1 + lemma: not ending in plural -ak suffix + stem: ending in [iîoô] -> VAIio (regular -i/o vowel-final)
# VAI-1 + lemma: ending in plural -ak suffix -> VAIw_PL (plural only)
# VAI-2 -> VAIn (regular) + stem-final coding: -n -> -n3 + a/ê alternation in suffixation <- n2 (affixes)
# VAI-2 + lemma: ending in plural -ak suffix -> VAIn_PL (plural only) + a/ê alternation in suffixation <- n2 (affixes)
# VAI-3 (VTI-like) -> VAIm + stem + with addition of final theme suffix -a
#
# VTI VERBS
# VTI-1 + lemma: not ending in plural -ak suffix -> VTIm (regular) + lemma: -m final + a/ê alternation in suffixation <- n2 (affixes), -t4 (X)
# VTI-1 + lemma: ending in plural -ak suffix -> VTIm_PL (plural only) + lemma: -m final + a/ê alternation in suffixation <- n2 (affixes), -t4 (X)
# VTI-2 -> VTIw (VAI-like) + a/ê alternation in suffixation <- n2 (affixes)
# VTI-3 -> VTIw (Diminutives, Habituals, VAI-like) + a/ê alternation in suffixation <- n2 (affixes)
#
# VTA VERBS
# VTA-1 + lemma: not ending in plural -ak suffix -> VTA (regular) + stem: mow- -> mow2-
# VTA-2 lemma: not ending in plural -ak suffix -> VTA (regular)
# VTA-2 lemma: ending in plural -ak suffix -> VTA_PL (plural only)
# VTA-3 lemma: not ending in plural -ak suffix -> VTA (regular)
# VTA-4 -> VTAt + stem: -t -> -t3
# VTA-5 -> VTAi (ahêw, [ay-]itêw) + stem-final: -t -> -t3

if(class=="V" && index(lemma," ")==0) # No multipart lemmas, e.g. "namoya wâpiw" ("not see, i.e. be blind")
{

# VII
# osâwâw:osâwâ VIIw ;
# mihkwâw:mihkwâ VIIw ;
# nîpin:nîpin3 VIIn ;
# mispon VIIn_PL ; ! only occurs in plural
# pimamon VIIn ;
# mâyâtan:mâyâtan3 VIIn ;
# miywâsin VIIn ;

if(pos=="VII-1v") # VII-1v lemmas are always singular
  { clex="VIIw_SG"; }
if(pos=="VII-2v" && match(lemma,"a$")==0)
  { clex="VIIw"; }
if(pos=="VII-2v" && match(lemma,"a$")!=0) 
  { clex="VIIw_PL"; }
if(pos=="VII-1n")  # VII-1n lemmas are always singular
  { clex="VIIn_SG"; }
if(pos=="VII-2n" && match(lemma,"a$")==0) 
  { clex="VIIn"; }
if(pos=="VII-2n" && match(lemma,"a$")!=0) 
  { clex="VIIn_PL"; }
if(match(lemma,"an$")!=0 || match(lemma,"ana$")!=0 || lemma=="nîpin" || lemma=="âpihtâ-nîpin" || match(lemma,"^(.+[-])?pipon$")!=0) # EXPANSION: n3 for all -an final II verbs, and selected -in, and -on final VII verbs
  sub("n$","n3",stem);

# VAI
# apiw:api VAIio ;
# atoskêw:atoskê VAIae ;
# mâtow:mâto VAIio ; # YAML file needs to be corrected as to long -â-
# mîcisow:mîciso VAIio ;
# nêhiýawêw:nêhiýawê VAIae ;
# nipâw:nipâ VAIae ;
# pimisin:pimisin3 VAIn ;

if(pos=="VAI-1" && match(lemma,"ak$")==0 && lemma!="nîminâniwan") # except nîminâniwan (inflected form of "nîmiw")
  { if(match(stem,"[aâê]$")!=0)
      clex="VAIae";
    if(match(stem,"[iîoô]$")!=0)
      clex="VAIio";
  }
if(pos=="VAI-1" && match(lemma,"ak$")!=0) 
  { clex="VAIw_PL"; }
if(pos=="VAI-2" && match(lemma,"ak$")==0) 
  { clex="VAIn"; sub("n$","n3",stem); }
if(pos=="VAI-2" && match(lemma,"ak$")!=0) 
  { clex="VAIn_PL"; sub("n$","n3",stem); }
if(pos=="VAI-3")
  { clex="VAIm"; stem=stem"a"; }

# VTI
# kâtâw:kâtâ VTIw ;
# kîsihtâw:kîsihtâ VTIw ;
# mîciw:mîci VTIw ;
# wâpahtam:wâpaht4a VTIm ; ! Check status of -a
# nâtam:nâta VTIm ;

if(pos=="VTI-1" && match(lemma,"ak$")==0)
  { clex="VTIm"; stem=stem"a"; }
if(pos=="VTI-1" && match(lemma,"ak$")!=0) 
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
# nakatêw:nakat3 VTAt ;        ! t3:s in some cases
# nâtêw:nât3 VTAt ;
# nitonawêw:nitonaw VTA ; ! w->w2 for collapsing cases?
# wâpamêw:wâpam VTA ;
# wîcihêw:wîcih VTA ;
# mêstasîhkawêwak:mêstasîhkaw VTA_PL ; ! "generally" plural according to AEW
#
# itêw:it3 VTAi ;
# kostêw:kost3 VTAt ;      ! s:0 when preceeding t3:s
# ayâwêw:ayâw2 VTA ;      ! w2:w for non-collapsing cases

if(pos=="VTA-1")
  { clex="VTA";
    if(lemma=="mowêw")
      stem="mow2";
  }
if(pos=="VTA-2" && match(lemma,"ak$")==0) # (w -> w2: implemented -ayâwêw)
  { clex="VTA";
    if(match(lemma,"^[.+-]?ayâwêw$")!=0) # unclear: kiskinohamawêw
       sub("w$","w2",stem);
  }
if(pos=="VTA-2" && match(lemma,"ak$")!=0) 
  { clex="VTA_PL"; }
if(pos=="VTA-3")
  { clex="VTA"; }
if(pos=="VTA-4") # t -> t3
  { clex="VTAt";
    sub("t$","t3",stem);
  }
if(pos=="VTA-5")
  { clex="VTAi"; sub("t$","t3",stem); }

      # gsub("ý","y",lemma); # Undo marking historical -y- in lemma before outputting LEXC code
      # gsub("ý","y",stem);

      contlex="VERBSTEMS";     
       if(clex!="")
         { if(lex!=stem)
              output[contlex] = output[contlex] sprintf("%s:%s %s", lemma, stem, clex);
           else
             output[contlex] = output[contlex] sprintf("%s %s", lemma, clex);
           if(full=="full")
             { output[contlex] = output[contlex] sprintf(" \"%s\" ;", gloss)
               output[contlex] = output[contlex] " ! AEW: " pos
               if(note1!="") note1="-";
               if(note2=="") note2="-";
               if(note1!="-" || note2!="-")
               output[contlex] = output[contlex] sprintf(" ! 1: %s ! 2: %s", note1, note2);
             }
           else
             output[contlex] = output[contlex] sprintf(" ;");
           if(check!="")
             output[contlex] = output[contlex] sprintf(" ! %s", check);
           output[contlex] = output[contlex] sprintf("\n");
         }
}

if(class=="I")
{

# Indeclinable particle frequencies
# 2014 2019 Subclass Definition
#  934 1120 IPC      Regular single independent particle
#  250  324 IPV      Preverb
#  160  229 IPH      Multipart phrasal particle
#    0  190 INM      Place/person name
#   91  128 IPJ      Interjection
#   64   82 IPN      Prenoun
#    9   10 IPC ;; IPJ Ambiguous: particle/interjection
#    4    4 IPP      Preverb-like?

  PROCINFO["sorted_in"]="@ind_str_asc";
  output["Particle"] = sprintf("+Ipc:0 # ;\n")
  output["Particle/Interjection"] =  sprintf("+Ipc+Interj:0 # ;\n");
  output["Particle/Phrase"] = sprintf("+Ipc+Phr:0 # ;\n")
  output["Particle/Name"] = sprintf("+Ipc+Prop:0 # ;\n")

  contlex="Particles";
  # IPP requires consideration; IPV and IPN to be dealt with separately
  if(pos=="IPC")
    { clex="Particle"; gsub(" ","% ",lemma); }
  if(pos=="IPJ")
    { clex="Particle/Interjection"; gsub(" ","% ",lemma); }
  if(pos=="IPC ;; IPJ")
    { clex="Particle"; gsub(" ","% ",lemma); }
  if(pos=="IPH")
    { clex="Particle/Phrase"; gsub(" ","% ",lemma); }
  if(pos=="INM")
    { clex="Particle/Name"; gsub(" ","% ",lemma); }



  # gsub("ý","y",lemma); # Undo marking historical -y- in lemma before outputting LEXC code
  # gsub("ý","y",stem);

  if(clex!="")
    { output[contlex] = output[contlex] sprintf("%s %s", lemma, clex);
      if(full=="full")
        output[contlex] = output[contlex] sprintf(" \"%s\" ;", gloss);
      else
        output[contlex] = output[contlex] sprintf(" ;");
      output[contlex] = output[contlex] sprintf("\n");
    }
}

if(class=="PVN")
{

# Grammatical preverbs (excluded), e.g.:
# ê- ka- kâ- kê- kika- kita- kiyê- kiyi- kî- nôh- nôhci- ohci- ôh- ô- ta- tita- wî-

  if(pos=="IPV" &&
          (lemma!="ê-" &&
           lemma!="ka-" &&
           lemma!="kâ-" &&
           lemma!="kâh-" &&
           lemma!="kê-" &&
           lemma!="kika-" &&
           lemma!="kita-" &&
           lemma!="kiyê-" &&
           lemma!="kiyi-" &&
           lemma!="kici-" &&
           lemma!="kî-" &&
           lemma!="nôh-" &&
           lemma!="nôhci-" &&
           lemma!="kôh-" &&
           lemma!="kôhci-" &&
           lemma!="ô-" &&
           lemma!="ôh-" &&
           # lemma!="ohci-" &&
           lemma!="ta-" &&
           lemma!="tita-" &&
           lemma!="tâh-" &&
           lemma!="wâh-" &&
           lemma!="wî-" &&
           lemma!="wîci-" &&
           lemma!="ka-kî-" &&
           lemma!="ta-kî-"))
    { contlex="PREVERBS";
      clex="PREVERBS_BOUND";
    }

#   PV/ako+
#   PV/apihci+
#   PV/ase+
#   PV/kipi+
#   PV/kisi+
#   PV/kisiwi+
#   PV/kwataki+
#   PV/maci+
#   PV/pimi+
#   PV/tahci+
#   PV/tako+
#   PV/wa+

  sub("-$","",lemma);

  tag=lemma;

  gsub("â","a",tag);
  gsub("ê","e",tag);
  gsub("î","i",tag);
  gsub("ô","o",tag);
  gsub("ý","y",tag);

  # gsub("ý","y",lemma); # Undo marking historical -y- in lemma before outputting LEXC code
  # gsub("ý","y",stem);

  if(clex!="")
    { if(index(lemma,"-")==0)
<<<<<<< HEAD
        { output[contlex] = output[contlex] sprintf("PV/%s\\+:%s %s", tag, lemma, clex);
=======
        { output[contlex] = output[contlex] sprintf("PV/%s+:%s %s", tag, lemma, clex);
>>>>>>> 114a2dc3 (Revision of script for generating LEXC content for preverbs.)
            if(full=="full")
              output[contlex] = output[contlex] sprintf(" \"%s\" ;", gloss);
            else
              output[contlex] = output[contlex] sprintf(" ;");
          output[contlex] = output[contlex] sprintf("\n");
        }
      else
<<<<<<< HEAD
        { output[contlex] = output[contlex] sprintf("@U.hyphen.hyphen@PV/%s\\+:@U.hyphen.hyphen@%s %s", tag, lemma, clex);
=======
        { output[contlex] = output[contlex] sprintf("@U.hyphen.hyphen@PV/%s+:@U.hyphen.hyphen@%s %s", tag, lemma, clex);
>>>>>>> 114a2dc3 (Revision of script for generating LEXC content for preverbs.)
            if(full=="full")
              output[contlex] = output[contlex] sprintf(" \"%s\" ;", gloss);
            else
              output[contlex] = output[contlex] sprintf(" ;");
          output[contlex] = output[contlex] sprintf("\n");

          # Non-hyphenated alternative
          stem=lemma;
          n=split(stem,char,"");
          stem="";
          for(j=1; j<=n; j++)
             { if(char[j]=="-" && match(char[j+1],"[aâêiîoô]")!=0)
                 char[j]="h";
               if(char[j]=="-" && match(char[j+1],"[aâêiîoô]")==0)
                 char[j]="";
               stem=stem char[j];
             }
<<<<<<< HEAD
          output[contlex] = output[contlex] sprintf("@U.hyphen.NULL@PV/%s\\+:@U.hyphen.NULL@%s %s", tag, stem, clex);
=======
          output[contlex] = output[contlex] sprintf("@U.hyphen.NULL@PV/%s+:@U.hyphen.NULL@%s %s", tag, stem, clex);
>>>>>>> 114a2dc3 (Revision of script for generating LEXC content for preverbs.)
            if(full=="full")
              output[contlex] = output[contlex] sprintf(" \"%s\" ;", gloss);
            else
              output[contlex] = output[contlex] sprintf(" ;");
          output[contlex] = output[contlex] sprintf("\n");
        }
    }
}

}

# Outputting continuation lexica

for(c in output)
   { printf "LEXICON %s\n", c;
     print output[c];
     print "";
   }
}' | less; exit 0;
