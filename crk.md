
# Plains Cree morphological analyser
INTRODUCTION TO MORPHOLOGICAL ANALYSER OF Plains Cree LANGUAGE.


 # Definitions for Multichar_Symbols

## Analysis symbols

The morphological analyses of wordforms of Plains Cree are presented
in this system in terms of the following symbols.
(It is highly suggested to follow existing standards when adding new tags).

POS

 * +N	         = Noun
 * +V	         = Verb
 * +Ipc		 = Indeclinable Particle
 * +Prop       
 * +Adv        
 * +CC         
 * +CS         
 * +Interj     
 * +Phr        
 * +Pron       
 * +Num        
 * +Arab       
 * +Rom        
 * +PUNCT       = punctuation symbols
 * +LEFT        = the left part of a paired punctuation symbol
 * +RIGHT       = the right part of a paired punctuation symbol
 * +CLB         = clause boundary symbols
 * +Symbol = independent symbols in the text stream, like £, €, ©
 * +ABBR 

Nominal morphology

 * +Loc         Locative
 * +Obv         Obviative
 * +Voc         Vocative

 * +Dim         Diminutive

Particles


 * +Def	     This is the intransitive demonstrative, i.e. the definite.
 * +Indef       Indefinite

 * +Dem         Demonstrative
 * +Prox	     Demonstrative Proximate
 * +Med	     Demonstrative Medial
 * +Dist	     Demonstrative Distal
 * +Pers = personal pronouns? At least it seems so based on the code
 * +Interr      Interrogative (who/whose/what/what kind)
 * +Foc	     Focus particle

+Ord +Ord   ordinals

Verbal MSP
 * +Prs  
 * +Fut  
 * +Prt  
 * +Cnj  
 * +Int   Future Intentional
 * +Def   Future Definite (TODO: okay to overlap with particle tag of the same name?)

 * +Ind   Indicative, aka Independent
 * +Imp   Imperative, consider deleting +Imp tag
 * +Del   Delayed imperative
 * +Imm   Immediate imperative, consider deleting +Imp tag
 * +Cond  TODO: Should Future Conditional be tagget Fut only? Conor: we will split the Future tags

 * +1Sg     first singular
 * +2Sg     etc
 * +3Sg    

 * +1Pl     1Pl is exclusive plural (I, them, not you)
 * +2Pl    
 * +3Pl    
 * +12Pl    12Pl is inclusive plural (I, you, ...)
 * +4Sg     Fourth Person inanimate singlar (used only in the VII paradigms)
 * +4Pl     Fourth Person inanimate plural (used only in the VII paradigms)
 * +4Sg/Pl    
 * +5Sg/Pl    

 * +1SgO    objective conjugation
 * +2SgO   
 * +2Sg/PlO    Used in the syncretic 2sg/pl -> 1pl in the VTA paradigms
 * +3SgO   
 * +SgO    
 * +1PlO   
 * +2PlO   
 * +12PlO	
 * +3PlO   
 * +PlO    
 * +4Sg/PlO  ambiguous 4th person (both Singular and Plural)
 * +5Sg/PlO  ambiguous 5th person (both Singular and Plural)
 * +X  Unspecified actor forms Okimāsis p. 118

Person prefix fragment features


Nominal morphosyntactic features
 * +Sg		  singular
 * +Pl		  plural

 * +Px1Sg	  person prefixes for nouns
 * +Px2Sg	 
 * +Px3Sg	 
 * +Px4Sg	 
 * +Px1Pl	  obviative
 * +Px12Pl	  inclusive
 * +Px2Pl	 
 * +Px3Pl	 
 * +Px4Pl	 
 * +Der/Dim  diminutive derivation

 * RdplW+  Reduplication Type 1 (Weak)
 * RdplS+  Reduplication Type 2 (Strong)

 * +Der/Com  Comitative circumfix (wîci-...-m)
 * +Der/X  VTI x-actor to VII-1

Verb conjugation (transitivity + animacy classes)
 * +AI       intransitive with animate subject,
 * +II       intransitive with inanimate subject,
 * +TA       transitive with animate object, and
 * +TI       transitive with inanimate object.

Noun animacy and dependency classes
 * +A		  animate noun
 * +I		  inanimate noun
 * +D		  dependent noun

 * +Qst      yes-no question particle; cî
 * +Neg      negation; [na]môy[a].

Preverbs










## Auxiliary symbols

These symbols either shape or govern the
morphophonological structure

 * %> 		  suffix border
 * %< 		  prefix border


## Symbols that need to be escaped on the lower side (towards twolc):
 * **»7**:  Literal »
 * **«7**:  Literal «
```
  %[%>%]  - Literal >
  %[%<%]  - Literal <
```

Special characters for morphophonology
 * w2       mowêw:mow2
 * t2 		 Epenthetic -t- between person prefixes and vowel-initial stems
 * t3       t to s in VTA-4
 * t4       t:c in VTI-1 with unspecified actor
 * y2       epenthetic joiner in reduplication of vowel-initial stems
 * y3       epenthetic joiner in reduplication of vowel-initial stems
 * i2       vta-5i epenthesis.

 * h2 		  Prefix in possessives


Triggers for various morphophonological phenomena
Mostly, these are not realized themselves as any grapheme/phoneme

 * %^EGLOT    glottal stop after e, for eh- in conjunctive order


## Usage tags

These tags distinguish different special-purpose analysers
and generators from each other. Thus, for examples, we have
normative and descriptive analysers, and generators for different purposes.

 * +Err/Orth  tag for substandard forms
 * +Err/Frag  tag for word-form fragments
 * +Dial  tag for dialectical forms that can't be called errors
 * +Use/NG   not-generate, for ped generation isme-ped.fst
 * +Eng indicates that this is an English form

Flagdiacritics

These are documented in Chapter 8 of Beesley/Karttunen, p. 456 zB.

For indicative, there are prefixes, so here we need one
flag for each person-number combination. Note that
for the inverse objective conjugation, the flag refers to
the **prefix**, not to the subject. So *indsg1* refers to either
subject = 1Sg or object = 1Sg. The 3-3 forms are prefixless.










The conjunct form always has
the ê- prefix, and future conditional never has a prefix.

 * @U.verb.FutCon@  Future Conditional

Prefixes with a certain phonological content:

 * @U.person.NULL@ 
 * @U.person.NI@ 
 * @U.person.KI@ 

Order

 * @U.order.indep@  Independent
 * @U.order.cnj@    Conjunct
 * @U.order.imp@    Imperative






Tense






New multichar symbols for nouns


















End of new and all Multichar_Symbols


  LEXICON Root          is where it all starts
 * NOUN_PREFIXES   ;    
 * NOUN_IRREGULARS ;    
 * NOUN_VOCATIVES  ;    
 * VerbPrefixes    ;    
 * Pronoun         ;    
 * Propernouns     ;    
 * Particles       ;    
 * Numerals        ;    
 * Abbreviation    ;    
 * Punctuation     ;    
 * Symbols         ;    
 * NON_STANDARD     ;    


Definitions






Rules

VG>i2 -> VV







* *mêskanaw>i2^DIMs*
* *mêskanâ000s*

* *mêskanaw>i2hk*
* *mêskanâ000hk*

* *sôniyâw>i2^DIMs*
* *sôniyâ000s0*

* *miskotâkay>i2^DIMs*
* *miskocâkâ000s0*

* *nâpêw>i2^DIMsis*
* *nâpê0000sis*

* *iskwêw>i2^DIMsis*
* *iskwê0000sis*

* *maskosiy>i2^DIMs*
* *maskosî0000s*

* *pikiw>i2^DIMs*
* *pikî0000s*

* *maskosiy>i2hk*
* *maskosî000hk*

* *sîwâpoy>i2^DIMs*
* *sîwâpô0000s*

* *tohtôsâpoy>i2hk*
* *tohtôsâpô000hk*



* *wâwi>i2^DIMs*
* *wâwi000s*

* *ôsi>i2hk*
* *ôsi00hk*



* *atimw>i2^DIMs*
* *acimo000s*

* *mistikw>i2hk*
* *mistiko00hk*
* *sâkahikan>i2^DIMs*
* *sâkahikan0i0s*

* *maskisin>i2hk*
* *maskisin0ihk*


* *atimw*
* *atim0*

* *askihkw*
* *askihk0*

* *nit2<nînihikw*
* *ni00nînihik*


* *a>tân*
* *ê0tân*



* *nit2<astotin>i2^DIMs*
* *nic0ascocin0i0s*







* *ê^EGLOT<acimo>t*
* *êh0acimo0t*

* *ê^EGLOT<d1ay2<acimo>t*
* *êh00ay0acimo0t*

* *ê^EGLOT<d2ay3d1âh<acimo>t*
* *êh00ay0âh0acimo0t*


* *nit2<nêhiyawê>n2*
* *ni00nêhiyawâ0n*
* *kit2<kâsîhkwê>n2*
* *ki00kâsîhkwâ0n*


* *nit2<tipiska>n2*
* *ni00tipiskê0n*
* *kit2<kiskêyihta>n2*
* *ki00kiskêyihtê0n*


* *ê-<nîpin3>k*
* *ê-0nîpih0k*


* *ê-<mispon>k*
* *ê-0mispo00k*



* *wapâht4>ikâtê>w*
* *wapâhc0ikâtê0w*




* *ê-<mow2>i2ht*
* *ê-0mow0iht*
* *ê-<ayaw2>i2koyâhk*
* *ê-0ayaw0ikoyâhk*
* *kit2<kîskisw>in*
* *ki00kîskiso00n*
* *nit2<kîskisw>i2mâwa*
* *ni00kîskiso00mâwa*
* *ê-<kîskisw>i2tân*
* *ê-0kîskiso00tân*
* *ê-<kîskisw>it*
* *ê-0kîskiso00t*
* *ê-<kîskisw>i2sk*
* *ê-0kîskiso00sk*
* *ê-<kîskisw>i2koyâhk*
* *ê-0kîskiso00koyâhk*
* *nit2<kîskisw>i2kawin*
* *ni00kîskiso00kawin*
* *kîskisw>in*
* *kîskiso00n*
* *kîskisw>ii2hkan*
* *kîskisô00hkan*

* *kit2<nitonaw>in*
* *ki00nitonaw0in*
* *nit2<nitonaw>i2mâwa*
* *ni00nitonâ000mâwa*
* *ê-<nitonaw>i2tân*
* *ê-0nitonâ000tân*
* *ê-<nitonaw>it*
* *ê-0nitonaw0it*
* *ê-<nitonaw>i2sk*
* *ê-0nitonâ000sk*
* *ê-<nitonaw>i2koyâhk*
* *ê-0nitonâ000koyâhk*
* *nit2<nitonaw>i2kawin*
* *ni00nitonâ000kawin*
* *nitonaw>in*
* *nitonaw0in*
* *nitonaw>îhkan*
* *nitonaw0îhkan*


* *it3>i*
* *is0i*
* *kit2<nakat3>in*
* *ki00nakas0in*
* *nit2<nakat3>i2mâwa*
* *ni00nakat0imâwa*
* *ê-<nakat3>i2tân*
* *ê-0nakat0itân*
* *ê-<nakat3>it*
* *ê-0nakas0it*
* *ê-<nakat3>i2sk*
* *ê-0nakat0isk*
* *ê-<nakat3>i2koyâhk*
* *ê-0nakat0ikoyâhk*
* *nit2<nakat3>i2kawin*
* *ni00nakat0ikawin*
* *nakat3>in*
* *nakas0in*
* *nakat3>ii2hkan*
* *nakas0îhkan*



* *kit2<kost3>in*
* *ki00ko0s0in*
* *nit2<kost3>i2mâwa*
* *ni00kost0imâwa*
* *ê-<kost3>i2tân*
* *ê-0kost0itân*
* *ê-<kost3>it*
* *ê-0ko0s0it*
* *ê-<kost3>i2sk*
* *ê-0kost0isk*
* *ê-<kost3>i2koyâhk*
* *ê-0kost0ikoyâhk*
* *nit2<kost3>i2kawin*
* *ni00kost0ikawin*
* *kost3>in*
* *ko0s0in*
* *kost3>ii2hkan*
* *ko0s0îhkan*





* *mi4<îwat3>i2^DIMs*
* *m00îwac0i0s*

__@OUTSIDE RULES@__


* *d1ay2-<nipâw*
* *na0-0nipâw*

* *d1âh-<nipâw*
* *nâh-0nipâw*

* *d2ay3-d1âh-<nipâw*
* *na0-nâh-0nipâw*

* *d2ay3-d1âh-<ayâw*
* *0ay-0âh-0ayâw*

* *d1âh-<ayâw*
* *0âh-0ayâw*

* *d1ay2-<ayâw*
* *0ay-0ayâw*

INITIAL CHANGE



* *nipât^IC*
* *nêpât0*

* *miyo-nipât^IC*
* *mêyo-nipât0*

* *itwêt^IC*
* *êtwêt0*

* *apit^IC*
* *êpit0*

* *wayawit^IC*
* *wêyawit0*

* *îkatêhtêt^IC*
* *âkatêhtêt0*

* *nîmit^IC*
* *nâmit0*

* *0ohcît^IC*
* *wêhcît0*

* *m0ostohtêt^IC*
* *mwêstohtêt0*


* *0oyôyot^IC*
* *wêyôyot0*

* *k0ocît^IC*
* *kwêcît0*


* *îkatêhât^IC*
* *âkatêhât0*

* *00îkatêhât^IC*
* *iyîkatêhât0*

* *00êskêt^IC*
* *iyêskêt0*

* *00âcimot^IC*
* *iyâcimot0*

* *00ôhkomit^IC*
* *iyôhkomit0*



* *w3<spiton*
* *o0spiton*

* *ni<spiton*
* *ni0spiton*

* *ki<spiton*
* *ki0spiton*

* *w3<îpit*
* *w0îpit*

* *w3<ahkwan*
* *w0ahkwan*





* *ni4<ohkom*
* *n00ôhkom*

* *ni4<ohkom>i2nân>ak*
* *n00ôhkom0inân0ak*

* *ki4<ohkom*
* *k00ôhkom*

* *w3<ohkom>a*
* *00ohkom0a*


* *nit2<ospwâkan*
* *nit0ôspwâkan*

* *kit2<ospwâkan*
* *kit0ôspwâkan*

* *ot2<ospwâkan*
* *ot0ôspwâkan*

Composing the rules together












Test lemma/stem set for nouns according the new crk FST


Complete extraction of lemma:stem info from AEW 2020, according to
LEXC structure in the new crk FST.












Model verb lemmas and stems for new crk FST


Full incorporation of AEW 2020 verbs into new crk FST





# Plains Cree noun morphology                           




# Prefixes






NounPrefixes redirects to AN-IN, BODY, INALIENABLE




AN-IN adds the prefixes ni-, ki-, o-. Redirects to STEMS






DEP-M-INIT  adds the prefixes n-, k-, o- (which alternate to w- in twolc), and generic form m- . Redirects to DEP-M-INIT.






DEP-KINTERMS  adds the prefixes n-, k-, o- (which alternate to w- in twolc) Redirects to DEP-KINTERMSSTEMS






Now, lexc directs us to the ../stems/nouns.lexc file,
where we find all the nominal stems. The suffixes are then
found at the end of this file.








# Suffixes




## The declensions for Animates 






 * LEXICON AN_DECL_0POSS  for the animate declension, Dim: -isis and -is 


 * LEXICON AN_DECL_PL  for the animate declension, Dim: -isis and -is 


 * LEXICON AN_DECLis  for the animate declension, Dim: -is diminutives




 * LEXICON AN_DECLisis  for the animate declension, Dim: -isis diminutives


 * LEXICON AN_DECL  for the animate declension, poss.-im-, Dim: -is
 * LEXICON ANimDECLisis  for the animate declension, poss.-im-, Dim: -isis


 * LEXICON ANimDECLis  for the animate declension, poss.-im-, Dim: -is




 * LEXICON ANimDECLw  for the animate declension, stem -w, poss.-im-, Dim: -is




 * LEXICON AN_DIM  both for lexicalised and derivated diminutives




 * LEXICON ANimDECLnaahk  for the animate declension, poss.-im-, Dim: -is, , with collectiv loc


 * LEXICON ANABSDECLnaahk  for the animate absolute declension, with collectiv loc




 * LEXICON ANimDECLnaahk-NOPOSS  for the animate declension, poss.-im-, Dim: -is, , with collectiv loc




 * LEXICON ANABSDECL  for the animate absolute declension


 * LEXICON ANABSDECL_PL  for the animate absolute declension










 * LEXICON AN_KININFL_MONOG  Lexicon with reduces possessive paradigm: only one wife/husband


 * LEXICON AN_DECL-ATIM	 for atim and mistatim.


 * LEXICON ANPOSS-ATIM  is also there to handle the highly irregular atim and mistatim


 * LEXICON ANVOC  


 * LEXICON AN_KININFL  


 * LEXICON AN_KININFL_PL  


 * LEXICON AN_DIMPOSS  Possessive suffixes to diminutives


 * LEXICON AN_KINiyINFL   Special treatment for kinship nouns ending with -iy - should be done in twolc?


 * LEXICON AN_DEP_INIT_M  for the inanimate possessive declension


 * LEXICON ANABLGENERIC  generic forms Sg, Pl, Loc and diminutives




## The declinations for Inanimates


 * LEXICON INimDECLw_ONESYLL_SG  for the inanimate declension, stem -w, poss.-im-, dim. -is, only Sg


 * LEXICON INimDECL  for the inanimate declension, poss.-im-, dim. -is


 * LEXICON INimDECLisis  for the inanimate declension, poss.-im-, dim. -isis




 * LEXICON IN_DECL  for the inanimate declension, Dim: -is- and -isis-


 * LEXICON IN_DECL_PL  for the inanimate declension, plural Dim: -is- and -isis-




 * LEXICON IN_DECLis  for the inanimate declension, Dim: -is- 


 * LEXICON IN_DECLisis  for the inanimate declension, Dim: -isis-




 * LEXICON IN_DECL_OSI  for the inanimate declension of ôsi, an irregular noun




 * LEXICON IN_DIM  for the inanimate diminutives


 * LEXICON INABSDECL  for inanimate absolute declension


 * LEXICON INABSDECL_PL  for inanimate absolute declension




 * LEXICON INimDIM  the diminutives with poss.-im-, Dim: -is


 * LEXICON INimDIMisis  the diminutives with poss.-im-, Dim: -isis




 * LEXICON INimDIM-SG  the diminutives with poss.-im-, Dim: -is




LEXICON IN_DIMDECL Declensions inanimate diminutives, adding +Dim , not in use


 * LEXICON INDEP-DERIV_M_SG   for hardcoded noun:diminutive for inalienables


 * LEXICON IN_DEP_INIT_M_PL  for the inanimate possessive declension, plural lemmas


 * LEXICON IN_DEP_INIT_M  for the inanimate possessive declension




 * LEXICON INABLGENERIC  generic forms Sg, Pl, Loc and diminutives


 * LEXICON IN_DEP_INIT_M_DIM  for the inanimate possessive declension




 * LEXICON IN_DEP_INIT_M_SG  inanimate possessive declension, only Sg


## Animate possessive suffixes


 * LEXICON ANSUFF_SG 


 * LEXICON ANSUFF_0POSS 


 * LEXICON SG_OBV 






 * LEXICON ANSUFF_Pl_0POSS 




 * LEXICON ANSUFF_PL 


 * LEXICON PL_OBV 














## Inanimate possessive suffixes




 * LEXICON INSUFF_SG  




 * LEXICON INSUFF_PL  






 * LEXICON INSUFF_LOC 




 * LEXICON ANiySUFF_SG  




 * LEXICON ANiySUFF_PL 




## Singular/plural suffixes






 * LEXICON SG_  




 * LEXICON PLa  




 * LEXICON PLak  




## Locative suffixes


 * LEXICON LOC  


 * LEXICON LOCahk  


 * LEXICON LOCinaahk  For collective locative


## Obviative suffix
 * LEXICON OBVIATIVE 




## Special cases
 * LEXICON NOPREFIX  gives diacr.flag for no prefix. Used for hardcoded forms in the lexicon



# Plains Cree numerals                           

## The file for numerals

 * LEXICON Numerals 





## Here start the 999 numbers

 * LEXICON UNDERTHOUSAND 

 * LEXICON HUNDREDS 

 * LEXICON CUODI 

 * LEXICON HUNDRED 



 * LEXICON TENS 

 * LEXICON TEN 




 * LEXICON ONESTONEXT 



 * LEXICON TEENS 

 * LEXICON ONES 

 * LEXICON CARDINAL 

 * LEXICON NUM  adds +Num+Ipc

# Plains Cree particles                           

The file contains the following lexicons, with content as described:

 * LEXICON Particle  adds +Ipc


 * LEXICON Particle/Interjection   adds +Ipc+Interj


 * LEXICON Particle/Name  adds +Ipc+Prop


 * LEXICON Particle/Phrase  adds +Ipc+Phr


 * LEXICON Particles  contains the actual list of particles.



## Plains Cree pronouns

There are more pronoums to be added here.

 LEXICON Pronoun 


 LEXICON Personal  \\
 niya+Pron+Pers+1Sg:niya # ; 
 niya+Pron+Pers+1Sg:nîya # ;  
 kiya+Pron+Pers+2Sg:kiya # ; 



 LEXICON Interrogative   \\
 awîna+Pron+Interr+Sg:awîna # "who,whose" ;
 awîna+Pron+Interr+Pl:awîniki # "who" ;

 LEXICON Indefinite  \\
 awiyak+Pron+Indef+A+Sg:awiyak # "someone" ; 
 awiyak+Pron+Indef+A+Pl:awiyakak # "some people" ;

 LEXICON Demonstrative    \\
ANIMATE \\
 awa+Pron+Dem+Prox+A+Sg:awa # "this" ; 
 awa+Pron+Dem+Prox+A+Pl:ôki # "these" ; 



INANIMATE \\

 ôma+Pron+Dem+Prox+I+Sg:ôma # "this" ; 
 ôma+Pron+Dem+Prox+I+Pl:ôhi # "these" ; 



 ôma+Pron+Def+Prox+I+Sg:ôma # "this one" ; 
 ôma+Pron+Def+Prox+I+Pl:ôhi # "these one" ; 


Punctuation marks 




Punctuation contains period, comma, parentheses, etc.




 %,+CLB:%,           # ; 
 %.+CLB:%.           # ; 
 %.%.+CLB:%.%.       # ; 
 ^excl+CLB:%!	    # ;	 !^C^












Plains Cree verb morphology                  








The Plains Cree verbs are divided in four groups:


1. AI: Animate intransitive 
1. II: Inanimate intransitive
1. TA: Transitive animate
1. TI: Transitive inanimate






# Prefixes




 LEXICON VerbPrefixes   divides the lexicon into four modes: independent, conjunctive, imperative and future conditional


 * @U.order.indep@ INDEPENDENT ;         
 * @U.order.cnj@   CONJUNCT ;             
 *                IMPERATIVE ;          
 *                FUTURE_CONDITIONAL ;  




 LEXICON INDEPENDENT  gives flags and prefixes for personprefix




 LEXICON IND_TENSE  gives flags and prefixes for tense 




 LEXICON FUTURE_CONDITIONAL  gives flags for future conditional (no prefix)




 LEXICON CONJUNCT  gives flag for conjunctive and prefix ê-, kâ-, kâki-






 LEXICON CNJ_TENSE    gives prefixes and flags for tense in conjunctive




 LEXICON IMPERATIVE    gives flag for imperative (no prefixes)


Words marked GG are from Plains Cree Grammar guide and glossary




Preverbs


 LEXICON PREVERBS   just adds the prefix boundary














Now, lexc directs us to the ../stems/verbs.lexc file,
where we find all the verbal stems. The suffixes are then
found in the section "Suffixes" right underneath.




# Suffixes


fst:
AICONJ:  stem
AICONJw: stem (excl w)
Wolv:
AICONJ_n
AICONJ_w








LEXICON TACONJ_3 
TACONJ_2 ;


LEXICON TACONJ_4 
TACONJ_2 ;






Intransitive inanimate (II)




 LEXICON VIIw   


 LEXICON VIIw_SG   


 LEXICON VIIw_PL   


 LEXICON VIIn   


 LEXICON VIIn_SG   


 LEXICON VIIn_PL   
























 LEXICON VIIw_ORDER  




 LEXICON VIIw_SG_ORDER  singular only


 LEXICON VIIw_PL_ORDER  plural only 




 LEXICON VIIn_ORDER  


 LEXICON VIIn_SG_ORDER  singular only


 LEXICON VIIn_PL_ORDER  plural only










 LEXICON VIIw_SG_IND_TENSE  plural only


 LEXICON VIIw_SG_CNJ_TENSE  plural only


 LEXICON VIIw_PL_IND_TENSE  plural only


 LEXICON VIIw_PL_CNJ_TENSE  plural only








 LEXICON VIIn_SG_IND_TENSE  plural only


 LEXICON VIIn_SG_CNJ_TENSE  plural only


 LEXICON VIIn_PL_IND_TENSE  plural only


 LEXICON VIIn_PL_CNJ_TENSE  plural only






 LEXICON VIIw_IND_PERSON  


 LEXICON VIIw_CNJ_PERSON  


 LEXICON VIIw_FUT_CON_PERSON  


 LEXICON VIIw_SG_IND_PERSON  plural only


 LEXICON VIIw_SG_CNJ_PERSON  plural only


 LEXICON VIIw_SG_FUT_CON_PERSON  plural only


 LEXICON VIIw_PL_IND_PERSON  plural only


 LEXICON VIIw_PL_CNJ_PERSON  plural only


 LEXICON VIIw_PL_FUT_CON_PERSON  plural only




 LEXICON VIIn_IND_PERSON  


 LEXICON VIIn_CNJ_PERSON  


 LEXICON VIIn_FUT_CON_PERSON  


 LEXICON VIIn_SG_IND_PERSON  plural only


 LEXICON VIIn_SG_CNJ_PERSON  plural only


 LEXICON VIIn_SG_FUT_CON_PERSON  plural only


 LEXICON VIIn_PL_IND_PERSON  plural only


 LEXICON VIIn_PL_CNJ_PERSON  plural only


 LEXICON VIIn_PL_FUT_CON_PERSON  plural only










 LEXICON VIIw_IND_NULL 


 LEXICON VIIw_IND_SG_SUFFIX    singular


 LEXICON VIIw_IND_PL_SUFFIX   plural






 LEXICON VIIn_IND_NULL 


 LEXICON VIIn_IND_SG_SUFFIX    w final singular


 LEXICON VIIn_IND_PL_SUFFIX    w final plural










 LEXICON VIIw_CNJ_NULL 


 LEXICON VIIw_CNJ_SG_SUFFIX    singular


 LEXICON VIIw_CNJ_PL_SUFFIX   plural




 LEXICON VIIn_CNJ_NULL 


 LEXICON VIIn_CNJ_SG_SUFFIX    w final singular


 LEXICON VIIn_CNJ_PL_SUFFIX    w final plural








 LEXICON VIIw_FUT_CON_NULL 


 LEXICON VIIw_FUT_CON_SG_SUFFIX    singular


 LEXICON VIIw_FUT_CON_PL_SUFFIX   plural




 LEXICON VIIn_FUT_CON_NULL 


 LEXICON VIIn_FUT_CON_SG_SUFFIX    w final singular


 LEXICON VIIn_FUT_CON_PL_SUFFIX    w final plural




Intransitive animate (AI)






 LEXICON VAIw  


 LEXICON VAIw_PL  


 LEXICON VAIn  


 LEXICON VAIn_PL  




















 LEXICON VAIw_ORDER 


 LEXICON VAIw_PL_ORDER  plural only 




 LEXICON VAIn_ORDER 


 LEXICON VAIn_PL_ORDER  plural only  










 LEXICON VAIw_PL_IND_TENSE  plural only


 LEXICON VAIw_PL_CNJ_TENSE  plural only








 LEXICON VAIn_PL_IND_TENSE  plural only




 LEXICON VAIn_PL_CNJ_TENSE  plural only








 LEXICON VAIw_IND_PERSON  


 LEXICON VAIw_CNJ_PERSON  


 LEXICON VAIw_FUT_CON_PERSON  




 LEXICON VAIw_IMP_PERSON  


 LEXICON VAIw_PL_IND_PERSON  plural only


 LEXICON VAIw_PL_CNJ_PERSON  plural only


 LEXICON VAIw_PL_FUT_CON_PERSON  plural only


 LEXICON VAIw_PL_IMP_PERSON  plural only






 LEXICON VAIn_IND_PERSON  


 LEXICON VAIn_CNJ_PERSON  


 LEXICON VAIn_FUT_CON_PERSON  


 LEXICON VAIn_IMP_PERSON  


 LEXICON VAIn_PL_IND_PERSON  plural only


 LEXICON VAIn_PL_CNJ_PERSON  plural only


 LEXICON VAIn_PL_FUT_CON_PERSON  plural only


 LEXICON VAIn_PL_IMP_PERSON  plural only










 LEXICON VAIw_IND_NI     


 LEXICON VAIw_IND_NI_SG_SUFFIX    


 LEXICON VAIw_IND_NI_PL_SUFFIX   


 LEXICON VAIw_IND_KI     


 LEXICON VAIw_IND_KI_SG_SUFFIX    


 LEXICON VAIw_IND_KI_PL_SUFFIX    


 LEXICON VAIw_IND_NULL     


 LEXICON VAIw_IND_NULL_SG_SUFFIX    












 LEXICON VAIw_IND_NULL_PL_SUFFIX   














 LEXICON VAIn_IND_NI    


 LEXICON VAIn_IND_NI_SG_SUFFIX    


 LEXICON VAIn_IND_NI_PL_SUFFIX    


 LEXICON VAIn_IND_KI     


 LEXICON VAIn_IND_KI_SG_SUFFIX    


 LEXICON VAIn_IND_KI_PL_SUFFIX    


 LEXICON VAIn_IND_NULL     


 LEXICON VAIn_IND_NULL_SG_SUFFIX    










 LEXICON VAIn_IND_NULL_PL_SUFFIX    


















 LEXICON VAIw_CNJ_NULL    




 LEXICON VAIw_CNJ_NULL_SG_SUFFIX    










 LEXICON VAIw_CNJ_NULL_PL_SUFFIX    












 LEXICON VAIn_CNJ_NULL    




 LEXICON VAIn_CNJ_NULL_SG_SUFFIX    












 LEXICON VAIn_CNJ_NULL_PL_SUFFIX    


















































 LEXICON VAIw_FUT_CON_NULL    




 LEXICON VAIw_FUT_CON_NULL_SG_SUFFIX    








 LEXICON VAIw_FUT_CON_NULL_PL_SUFFIX    










 LEXICON VAIn_FUT_CON_NULL    




 LEXICON VAIn_FUT_CON_NULL_SG_SUFFIX    








 LEXICON VAIn_FUT_CON_NULL_PL_SUFFIX    












Transitive inanimate (TI)




 * LEXICON VTI   


 * LEXICON VTI_PL    Plural


 * LEXICON VTIw   NOTE: These inflect just as VAI -w final stems, so they are redirected to those paradigms


















 LEXICON VTIt_ORDER  . 


 LEXICON VTIt_PL_ORDER  plural only NOTE: imperative and fut con go straight to person lexica












 LEXICON VTIt_PL_IND_TENSE  plural only


 LEXICON VTIt_PL_CNJ_TENSE  plural only










 LEXICON VTIt_IND_PERSON  


 LEXICON VTIt_CNJ_PERSON  


 LEXICON VTIt_FUT_CON_PERSON  


 LEXICON VTIt_IMP_PERSON  


 LEXICON VTIt_PL_IND_PERSON  plural only


 LEXICON VTIt_PL_CNJ_PERSON  plural only


 LEXICON VTIt_PL_FUT_CON_PERSON  plural only


 LEXICON VTIt_PL_IMP_PERSON  plural only












 LEXICON VTIt_IND_NI     


 LEXICON VTIt_IND_NI_SG_SUFFIX    


 LEXICON VTIt_IND_NI_PL_SUFFIX    


 LEXICON VTIt_IND_KI     


 LEXICON VTIt_IND_KI_SG_SUFFIX    


 LEXICON VTIt_IND_KI_PL_SUFFIX    


 LEXICON VTIt_IND_NULL     


 LEXICON VTIt_IND_NULL_SG_SUFFIX    NOTE: X actor will eventually derive to VII, so it is not yet included as per Arok's paradigm










 LEXICON VTIt_IND_NULL_PL_SUFFIX    
















 LEXICON VTIt_CNJ_NULL    




 LEXICON VTIt_CNJ_NULL_SG_SUFFIX    








 LEXICON VTIt_CNJ_NULL_PL_SUFFIX    






































 LEXICON VTIt_FUT_CON_NULL    




 LEXICON VTIt_FUT_CON_NULL_SG_SUFFIX    








 LEXICON VTIt_FUT_CON_NULL_PL_SUFFIX    


















Transitive inanimate (TA)


The VTA verbs split in different orders.
There are 5 stem classes in Wolv, 1-5 (VTA-1 through VTA-5)




 LEXICON TACONJ_1  Regular verbs


 * LEXICON TACONJ_2   -Vw stem-ending verbs; where + i suf deletes w and i


 * LEXICON TACONJ_2-PL   -Vw stem-ending verbs; when deletes w and i plural only forms


 * LEXICON TACONJ_3   -Cw stem-ending verbs; where w and i fuse to o


 * LEXICON TACONJ_4   -t stem-ending verbs; where t becomes s in some cases


 * LEXICON TACONJ_5  verbs that take a -i in 2sg imm. imp. due to moraic constraints


 * LEXICON TACONJ_5-TS   verbs that take a -i in 2sg imm. imp. due to moraic constraints, but also have stem final t becoming s in some cases.






 LEXICON VTACONJ_WICI  Regular verbs


 * LEXICON VTACONJvw_WICI   -Vw stem-ending verbs; where + i suf deletes w and i




 * LEXICON VTACONJvw_PL_WICI   -Vw stem-ending verbs; when deletes w and i plural only forms 




 * LEXICON VTACONJcw_WICI   -Cw stem-ending verbs; where w and i fuse to o 


 * LEXICON VTACONJt_WICI   -t stem-ending verbs; where t becomes s in some cases 




 * LEXICON VTACONJi_WICI   verbs that take a -i in 2sg imm. imp. due to moraic constraints 




 * LEXICON VTACONJti_WICI    verbs that take a -i in 2sg imm. imp. due to moraic constraints, but also have stem final t becoming s in some cases 








 LEXICON VTA_ORDER  Note: Imp and Fut Con don't take tense 


 LEXICON VTAvw_ORDER  Note: Imp and Fut Con don't take tense


 LEXICON VTAvw_PL_ORDER  Note: Imp and Fut Con don't take tense 


 LEXICON VTAcw_ORDER  Note: Imp and Fut Con don't take tense 


 LEXICON VTAcw_PL_ORDER  Note: Imp and Fut Con don't take tense 




 LEXICON VTAt_ORDER  Note: Imp and Fut Con don't take tense ; Independent is same as TA regular


 LEXICON VTAi_ORDER  Note: Imp and Fut Con don't take tense ; Conjugates as TA regular except in 2sg IMM IMP


 LEXICON VTAti_ORDER  Note: Imp and Fut Con don't take tense ; Independent is as TA regular, Imp as TAi, all else is as TAt












 LEXICON VTAvw_IND_TENSE  plural only


 LEXICON VTAvw_CNJ_TENSE  plural only




 LEXICON VTAvw_PL_IND_TENSE  plural only


 LEXICON VTAvw_PL_CNJ_TENSE  plural only




 LEXICON VTAcw_IND_TENSE   


 LEXICON VTAcw_CNJ_TENSE   




 LEXICON VTAcw_PL_IND_TENSE  plural only


 LEXICON VTAcw_PL_CNJ_TENSE  plural only




 LEXICON VTAt_IND_TENSE  plural only


 LEXICON VTAt_CNJ_TENSE  plural only




 LEXICON VTAi_IND_TENSE  plural only


 LEXICON VTAi_CNJ_TENSE  plural only




 LEXICON VTAti_IND_TENSE  plural only


 LEXICON VTAti_CNJ_TENSE  plural only








 LEXICON VTA_IND_PERSON  


 LEXICON VTA_CNJ_PERSON  


 LEXICON VTA_FUT_CON_PERSON  


 LEXICON VTA_IMP_PERSON  




 LEXICON VTAvw_IND_PERSON  


 LEXICON VTAvw_CNJ_PERSON  


 LEXICON VTAvw_FUT_CON_PERSON  


 LEXICON VTAvw_IMP_PERSON  Identical to TA IMP




 LEXICON VTAvw_PL_IND_PERSON  


 LEXICON VTAvw_PL_CNJ_PERSON  


 LEXICON VTAvw_PL_FUT_CON_PERSON  


 LEXICON VTAvw_PL_IMP_PERSON  




 LEXICON VTAcw_IND_PERSON  


 LEXICON VTAcw_CNJ_PERSON  


 LEXICON VTAcw_FUT_CON_PERSON  


 LEXICON VTAcw_IMP_PERSON  




 LEXICON VTAcw_PL_IND_PERSON  


 LEXICON VTAcw_PL_CNJ_PERSON  


 LEXICON VTAcw_PL_FUT_CON_PERSON  


 LEXICON VTAcw_PL_IMP_PERSON  






 LEXICON VTAt_IND_PERSON  


 LEXICON VTAt_CNJ_PERSON  


 LEXICON VTAt_FUT_CON_PERSON 


 LEXICON VTAt_IMP_PERSON  






 LEXICON VTAi_IND_PERSON  


 LEXICON VTAi_CNJ_PERSON 


 LEXICON VTAi_FUT_CON_PERSON 


 LEXICON VTAi_IMP_PERSON  






 LEXICON VTAti_IND_PERSON  


 LEXICON VTAti_CNJ_PERSON 


 LEXICON VTAti_FUT_CON_PERSON 


 LEXICON VTAti_IMP_PERSON  
















 LEXICON VTA_IND_NI     NOTE: No local, as local forms are always with ki-




 LEXICON VTA_IND_NI_SG_SUFFIX   






















 LEXICON VTA_IND_NI_PL_SUFFIX    


























 LEXICON VTA_IND_KI     




 LEXICON VTA_IND_KI_SG_SUFFIX    






























 LEXICON VTA_IND_KI_PL_SUFFIX    
















































 LEXICON VTA_IND_NULL     NOTE: never local






 LEXICON VTA_IND_NULL_SG_SUFFIX    






















 LEXICON VTA_IND_NULL_PL_SUFFIX    






























 LEXICON VTAvw_IND_NI     NOTE: No local, as local forms are always with ki-




 LEXICON VTAvw_IND_NI_SG_SUFFIX   






















 LEXICON VTAvw_IND_NI_PL_SUFFIX    


























 LEXICON VTAvw_IND_KI     




 LEXICON VTAvw_IND_KI_SG_SUFFIX    






























 LEXICON VTAvw_IND_KI_PL_SUFFIX    














































 LEXICON VTAvw_IND_NULL     NOTE: never local






 LEXICON VTAvw_IND_NULL_SG_SUFFIX    
























 LEXICON VTAvw_IND_NULL_PL_SUFFIX    
































 LEXICON VTAcw_IND_NI     NOTE: No local, as local forms are always with ki-




 LEXICON VTAcw_IND_NI_SG_SUFFIX   
























 LEXICON VTAcw_IND_NI_PL_SUFFIX    


























 LEXICON VTAcw_IND_KI     




 LEXICON VTAcw_IND_KI_SG_SUFFIX    
































 LEXICON VTAcw_IND_KI_PL_SUFFIX    












































 LEXICON VTAcw_IND_NULL     NOTE: never local






 LEXICON VTAcw_IND_NULL_SG_SUFFIX    
























 LEXICON VTAcw_IND_NULL_PL_SUFFIX    




























 LEXICON VTAt_IND_KI     




 LEXICON VTAt_IND_KI_SG_SUFFIX    
































 LEXICON VTAt_IND_KI_PL_SUFFIX    




















































































































































































~~~~~~~~~~~~~~~~~~~~~~


































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































