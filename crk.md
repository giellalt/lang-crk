# Plains Cree description 

All documents in one file



# Plains Cree disambiguator 

* * *
<small>This (part of) documentation was generated from [src/cg3/disambiguator.cg3](https://github.com/giellalt/lang-crk/blob/main/src/cg3/disambiguator.cg3)</small>

# Plains Cree disambiguator 

* * *
<small>This (part of) documentation was generated from [src/cg3/textanalysis.cg3](https://github.com/giellalt/lang-crk/blob/main/src/cg3/textanalysis.cg3)</small>

Nouns
Verbs

* * *

<small>This (part of) documentation was generated from [src/derivation/crk-drv.lexc](https://github.com/giellalt/lang-crk/blob/main/src/derivation/crk-drv.lexc)</small>

---



NOUN_ENDLEX for wrapping up various things

End of noun affixes code

* * *

<small>This (part of) documentation was generated from [src/fst/affixes/noun_affixes.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/affixes/noun_affixes.lexc)</small>

---


Proper noun inflection
The Plains Cree language proper nouns inflect in the same cases as regular
nouns, but with a colon (':') as separator.

* * *

<small>This (part of) documentation was generated from [src/fst/affixes/propernouns.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/affixes/propernouns.lexc)</small>

---


# Symbol affixes

* * *

<small>This (part of) documentation was generated from [src/fst/affixes/symbols.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/affixes/symbols.lexc)</small>

---


Plains Cree verb morphology                  

The Plains Cree verbs are divided in four groups:

1. AI: Animate intransitive 
2. II: Inanimate intransitive
3. TA: Transitive animate
4. TI: Transitive inanimate

# Prefixes

LEXICON VerbPrefixes   divides the lexicon into four modes: independent, conjunctive, imperative and future conditional

* @U.order.indep@ INDEPENDENT ;         
* @U.order.cnj@   CONJUNCT ;             
*                 IMPERATIVE ;          
*                 FUTURE_CONDITIONAL ;  

LEXICON INDEPENDENT  gives flags and prefixes for personprefix
Hypotheticals

LEXICON IND_TENSE  gives flags and prefixes for tense 

LEXICON FUTURE_CONDITIONAL  gives flags for future conditional (no prefix)

LEXICON CONJUNCT  gives flag for conjunct and combined tense preverbs

LEXICON CNJ_TENSE    gives prefixes and flags for tense in conjunct

LEXICON IMPERATIVE    gives flag for imperative (no prefixes)

Preverbs

LEXICON VERBPREFIXES   just adds the prefix boundary

Now, LEXC directs us to the ../stems/verbs_stems.lexc file,
where we find all the verbal stems. The suffixes are then
found in the section "Suffixes" right underneath.

# Suffixes

Intransitive inanimate (II)

LEXICON VIIn   

LEXICON VIIn_SG   

LEXICON VIIw_PL   

= LEXICON VIIw_PL   NO LONGER NEEDED FROM AROK
+V+II: VIIw_PL_WICI ;	   NO LONGER NEEDED FROM AROK

LEXICON VIIw   

LEXICON VIIw_SG   

LEXICON VIIn_PL   NO LONGER NEEDED FROM AROK
NO LONGER NEEDED FROM AROK

	 NO LONGER NEEDED FROM AROK
@U.wici.NULL@ VIIw_PL_ORDER ; NO LONGER NEEDED FROM AROK

@U.wici.NULL@ VIIw_PL_ORDER ;

LEXICON VIIw_SGPL_ORDER  

LEXICON VIIw_SG_ORDER  singular only

LEXICON VIIw_PL_ORDER  singular only

= LEXICON VIIw_PL_ORDER  plural only 
@U.order.indep@+Ind:@U.order.indep@ VIIw_PL_IND_PERSON ; !
@U.order.cnj@+Cnj:@U.order.cnj@ VIIw_PL_CNJ_PERSON ; !
@U.order.FutCon@+Fut+Cond:@U.order.FutCon@ VIIw_PL_FUT_CON_PERSON ;!

LEXICON VIIn_SGPL_ORDER  

LEXICON VIIn_SG_ORDER  singular only

LEXICON VIIn_PL_ORDER  plural only

LEXICON VIIw_SG_IND_TENSE  plural only

LEXICON VIIw_SG_CNJ_TENSE  plural only

LEXICON VIIw_PL_IND_TENSE  plural only

LEXICON VIIw_PL_CNJ_TENSE  plural only

= LEXICON VIIw_PL_CNJ_TENSE  plural only
@U.tense.Prs@+Prs:@U.tense.Prs@ VIIw_PL_IND_PERSON ; !
@U.tense.Prt@+Prt:@U.tense.Prt@ VIIw_PL_IND_PERSON ; !
@U.tense.FutDef@+Fut+Def:@U.tense.FutDef@ VIIw_PL_IND_PERSON ; !
@U.tense.FutInt@+Fut+Int:@U.tense.FutInt@ VIIw_PL_IND_PERSON ; !

= LEXICON VIIw_PL_CNJ_TENSE  plural only
@U.tense.Prs@+Prs:@U.tense.Prs@ VIIw_PL_CNJ_PERSON ; !
@U.tense.Prt@+Prt:@U.tense.Prt@ VIIw_PL_CNJ_PERSON ; !
@U.tense.FutInt@+Fut+Int:@U.tense.FutInt@ VIIw_PL_CNJ_PERSON ; !

LEXICON VIIn_SG_IND_TENSE  plural only

LEXICON VIIn_SG_CNJ_TENSE  plural only

LEXICON VIIn_PL_IND_TENSE  plural only

LEXICON VIIn_PL_CNJ_TENSE  plural only

LEXICON VIIw_SGPL_IND_PERSON  

LEXICON VIIw_SGPL_CNJ_PERSON  

LEXICON VIIw_SGPL_FUT_CON_PERSON  

LEXICON VIIw_SG_IND_PERSON  

LEXICON VIIw_SG_CNJ_PERSON  

LEXICON VIIw_SG_FUT_CON_PERSON  

LEXICON VIIw_PL_IND_PERSON  

LEXICON VIIw_PL_CNJ_PERSON  

LEXICON VIIw_PL_FUT_CON_PERSON  

= LEXICON VIIw_PL_FUT_CON_PERSON  plural only
@U.person.NULL@ VIIw_IND_PL_SUFFIX ;

= LEXICON VIIw_PL_FUT_CON_PERSON  plural only
@U.person.NULL@ VIIw_CNJ_PL_SUFFIX ;

= LEXICON VIIw_PL_FUT_CON_PERSON  plural only
@U.person.NULL@ VIIw_FUT_CON_PL_SUFFIX ;

LEXICON VIIn_SGPL_IND_PERSON  

LEXICON VIIn_SGPL_CNJ_PERSON  

LEXICON VIIn_SGPL_FUT_CON_PERSON  

LEXICON VIIn_SG_IND_PERSON  

LEXICON VIIn_SG_CNJ_PERSON  

LEXICON VIIn_SG_FUT_CON_PERSON  

LEXICON VIIn_PL_IND_PERSON  plural only

LEXICON VIIn_PL_CNJ_PERSON  plural only

LEXICON VIIn_PL_FUT_CON_PERSON  plural only

LEXICON VIIn_SGPL_IND_NULL 

LEXICON VIIn_SG_IND_SUFFIX    singular

LEXICON VIIn_PL_IND_SUFFIX   plural

LEXICON VIIw_SGPL_IND_NULL 

LEXICON VIIw_SG_IND_SUFFIX    w final singular

LEXICON VIIw_PL_IND_SUFFIX   w final plural

LEXICON VIIn_SGPL_CNJ_NULL 

LEXICON VIIn_SG_CNJ_SUFFIX    singular

LEXICON VIIn_PL_CNJ_SUFFIX   plural

LEXICON VIIw_SGPL_CNJ_NULL 

LEXICON VIIw_SG_CNJ_SUFFIX    w final singular

LEXICON VIIw_PL_CNJ_SUFFIX    w final plural

LEXICON VIIn_SGPL_FUT_CON_NULL 

LEXICON VIIn_SG_FUT_CON_SUFFIX    singular

LEXICON VIIn_PL_FUT_CON_SUFFIX   plural

LEXICON VIIw_SGPL_FUT_CON_NULL 

LEXICON VIIw_SG_FUT_CON_SUFFIX    w final singular

LEXICON VIIw_PL_FUT_CON_SUFFIX    w final plural

Intransitive animate (AI)

LEXICON VAIw_PL  stems that end in â or ê

LEXICON VAIae  stems that end in â or ê

LEXICON VAIio  stems that end in i, î, o, ô

LEXICON VAIn  

LEXICON VAIn_PL  

LEXICON VAIm  These are VTI3 in Arok's database

LEXICON VAIn_ORDER 

LEXICON VAIn_PL_ORDER  plural only  

LEXICON VAIae_ORDER 

LEXICON VAIw_PL_ORDER  plural only 

LEXICON VAIio_ORDER 

LEXICON VAIn_PL_IND_TENSE  plural only

LEXICON VAIn_PL_CNJ_TENSE  plural only

LEXICON VAIw_PL_IND_TENSE  plural only

LEXICON VAIw_PL_CNJ_TENSE  plural only

LEXICON VAIn_IND_PERSON  

LEXICON VAIn_CNJ_PERSON  

LEXICON VAIn_FUT_CON_PERSON  

LEXICON VAIn_IMP_PERSON  

LEXICON VAIn_PL_IND_PERSON  plural only

LEXICON VAIn_PL_CNJ_PERSON  plural only

LEXICON VAIn_PL_FUT_CON_PERSON  plural only

LEXICON VAIn_PL_IMP_PERSON  plural only

LEXICON VAIw_PL_IND_PERSON  plural only

LEXICON VAIw_PL_CNJ_PERSON  plural only

LEXICON VAIw_PL_FUT_CON_PERSON  plural only

LEXICON VAIw_PL_IMP_PERSON  plural only

LEXICON VAIae_IND_PERSON  

LEXICON VAIae_CNJ_PERSON  

LEXICON VAIw_FUT_CON_PERSON  

LEXICON VAIw_IMP_PERSON  

LEXICON VAIio_IND_PERSON  

LEXICON VAIio_CNJ_PERSON  

LEXICON VAIw_IND_NI     

LEXICON VAIw_IND_NI_SG_SUFFIX    

LEXICON VAIw_IND_NI_PL_SUFFIX   

LEXICON VAIw_IND_KI     

LEXICON VAIw_IND_KI_SG_SUFFIX    

LEXICON VAIw_IND_KI_PL_SUFFIX    

LEXICON VAIae_IND_NULL     

LEXICON VAIio_IND_NULL     

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

LEXICON VAIae_CNJ_NULL    

LEXICON VAIio_CNJ_NULL    

LEXICON VAIae_CNJ_NULL_SG_SUFFIX    

LEXICON VAIio_CNJ_NULL_SG_SUFFIX    

LEXICON VAIw_CNJ_NULL_PL_SUFFIX    

LEXICON VAIn_CNJ_NULL    

LEXICON VAIn_CNJ_NULL_SG_SUFFIX    

LEXICON VAIn_CNJ_NULL_PL_SUFFIX    

LEXICON VAIae_FUT_CON_NULL    

LEXICON VAIw_FUT_CON_NULL_SG_SUFFIX    

+X+4Sg:%>yiki # ;

LEXICON VAIw_FUT_CON_NULL_PL_SUFFIX    

+X+4Pl:%>yikwâwi # ;

LEXICON VAIn_FUT_CON_NULL    

LEXICON VAIn_FUT_CON_NULL_SG_SUFFIX    

+X+4Sg:%>iyiki # ;

LEXICON VAIn_FUT_CON_NULL_PL_SUFFIX    

+X+4Pl:%>iyikwâwi # ;

Transitive inanimate (TI)

* LEXICON VTIm   

* LEXICON VTIm_PL    Plural

* LEXICON VTIae   NOTE: These inflect just as VAI -w final stems, so they are redirected to those paradigms

* LEXICON VTIio   NOTE: These inflect just as VAI -w final stems, so they are redirected to those paradigms

LEXICON VTIm_ORDER  . 

LEXICON VTIm_PL_ORDER  plural only NOTE: imperative and fut con go straight to person lexica

LEXICON VTIm_PL_IND_TENSE  plural only

LEXICON VTIm_PL_CNJ_TENSE  plural only

LEXICON VTIm_IND_PERSON  

LEXICON VTIm_CNJ_PERSON  

LEXICON VTIm_FUT_CON_PERSON  

LEXICON VTIm_IMP_PERSON  

LEXICON VTIm_PL_IND_PERSON  plural only

LEXICON VTIm_PL_CNJ_PERSON  plural only

LEXICON VTIm_PL_FUT_CON_PERSON  plural only

LEXICON VTIm_PL_IMP_PERSON  plural only

LEXICON VTIm_IND_NI     

LEXICON VTIm_IND_NI_SG_SUFFIX    

LEXICON VTIm_IND_NI_PL_SUFFIX    

LEXICON VTIm_IND_KI     

LEXICON VTIm_IND_KI_SG_SUFFIX    

LEXICON VTIm_IND_KI_PL_SUFFIX    

LEXICON VTIm_IND_NULL     

LEXICON VTIm_IND_NULL_SG_SUFFIX    NOTE: X actor will eventually derive to VII, so it is not yet included as per Arok's paradigm

Derives to VIIn

LEXICON VTIm_IND_NULL_PL_SUFFIX    

Derives to VIIn

LEXICON VTIm_CNJ_NULL    

LEXICON VTIm_CNJ_NULL_SG_SUFFIX    

+X+4Sg:%>mihiyik # ;

LEXICON VTIm_CNJ_NULL_PL_SUFFIX    

+X+4Pl:%>mihiyiki # ;

LEXICON VTIm_FUT_CON_NULL    

LEXICON VTIm_FUT_CON_NULL_SG_SUFFIX    

+X+4Sg:%>mihiyiki # ;

LEXICON VTIm_FUT_CON_NULL_PL_SUFFIX    

+X+3Sg:%>mihkwâwi # ;
+X+4Sg:%>mihiyikwâwi # ;

* LEXICON VTA   Multi-Syllabic stems 

* LEXICON VTA_PL   Multi-Syllabic stems plural only forms

* LEXICON VTAt   Multi-Syllabic t/s-final alternating stems

* LEXICON VTAi   Mono-Syllabic stems

* LEXICON VTA_WICI   -Vw stem-ending verbs; where + i suf deletes w and i

* LEXICON VTA_PL_WICI   -Vw stem-ending verbs; when deletes w and i plural only forms 

* LEXICON VTAt_WICI   -t ending stems

* LEXICON VTAi_WICI   single mora stems

LEXICON VTA_ORDER  Note: Imp and Fut Con don't take tense

LEXICON VTA_PL_ORDER  Note: Imp and Fut Con don't take tense 

LEXICON VTAi_ORDER  Note: Imp and Fut Con don't take tense ; Conjugates as TA regular except in 2sg IMM IMP

LEXICON VTAt_ORDER  Note: Imp and Fut Con don't take tense ; Conjugates as TA regular except in 2sg IMM IMP

LEXICON VTA_IND_TENSE  plural only

LEXICON VTA_CNJ_TENSE  plural only

LEXICON VTA_PL_IND_TENSE  plural only

LEXICON VTA_PL_CNJ_TENSE  plural only

LEXICON VTA_IND_PERSON  

LEXICON VTA_CNJ_PERSON  

LEXICON VTA_FUT_CON_PERSON  

LEXICON VTA_IMP_PERSON  

LEXICON VTA_PL_IND_PERSON  

LEXICON VTA_PL_CNJ_PERSON  

LEXICON VTA_PL_FUT_CON_PERSON  

LEXICON VTA_PL_IMP_PERSON  

LEXICON VTAt_IMP_PERSON  no -i in 2sg+3SgO

LEXICON VTAi_IMP_PERSON  

LEXICON VTA_IND_NI     NOTE: No local, as local forms are always with ki-

LEXICON VTA_IND_NI_SG_SUFFIX   

LEXICON VTA_IND_NI_PL_SUFFIX    

LEXICON VTA_IND_KI     

LEXICON VTA_IND_KI_SG_SUFFIX    

LEXICON VTA_IND_KI_PL_SUFFIX    

LEXICON VTA_IND_NULL     NOTE: never local

LEXICON VTA_IND_NULL_SG_SUFFIX    

LEXICON VTA_IND_NULL_PL_SUFFIX    

~~~~~~~~~~~~~~~~~~~~~~

End of verb affixes LEXC code

* * *

<small>This (part of) documentation was generated from [src/fst/affixes/verb_affixes.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/affixes/verb_affixes.lexc)</small>

---



| --- 

*  y2:0       epenthetic joiner in reduplication of vowel-initial stems
*  y3:0       epenthetic joiner in reduplication of vowel-initial stems
*  d1:0   Reduplication consonant place holder 
*  d2:0   Reduplication consonant place holder 

*  %^EGLOT:0    Epenthetic -h- place holder

*  w3:w  3rd person possessor for NDA and NDI (non-kinship)
*  y4:y  immutable -y in single-syllable nouns
*  i4:i  possessive prefix -i that deletes before Vowel in Dep nouns

* *mêskanaw>i2s*
* *mêskanâ0>0s*

* *mêskanaw>i2hk*
* *mêskanâ0>0hk*

* *sôniyâw>i2s^DIM*
* *sôniyâ0>0s0*

* *miskotâkay>i2s^DIM*
* *miskocâkâ0>0s0*

* *nâpêw>i2^DIMsis*
* *nâpê0>00sis*

* *iskwêw>i2^DIMsis*
* *iskwê0>00sis*

* *maskosiy>i2^DIMs*
* *maskosî0>00s*

* *pikiw>i2^DIMs*
* *pikî0>00s*

* *maskosiy>i2hk*
* *maskosî0>0hk*

* *sîwâpoy>i2^DIMs*
* *sîwâpô0>00s*

* *tohtôsâpoy>i2hk*
* *tohtôsâpô0>0hk*

* *wâwi>i2^DIMs*
* *wâwi>00s*

* *ôsi>i2hk*
* *ôsi>0hk*

* *atimw>i2^DIMs*
* *acimo>00s*

* *mistikw>i2hk*
* *mistiko>0hk*
* *sâkahikan>i2^DIMs*
* *sâkahikan>i0s*

* *maskisin>i2hk*
* *maskisin>ihk*

* *atimw*
* *atim0*

* *askihkw*
* *askihk0*

* *atimw*
* *atim0*

* *nit2<nînihikw*
* *ni0<nînihik*

* *a>tân*
* *ê>tân*

* *nit2<astotin>i2^DIMs*
* *nic<ascocin>i0s*

* *ê^EGLOT<acimo>t*
* *êh<acimo>t*

* *ê^EGLOT<d1ay2<acimo>t*
* *êh<0ay<acimo>t*

* *ê^EGLOT<d2ay3d1âh<acimo>t*
* *êh<0ay0âh<acimo>t*

* *nit2<nêhiyawê>n2*
* *ni0<nêhiyawâ>n*
* *kit2<kâsîhkwê>n2*
* *ki0<kâsîhkwâ>n*

* *nit2<tipiska>n2*
* *ni0<tipiskê>n*
* *kit2<kiskêyihta>n2*
* *ki0<kiskêyihtê>n*

* *ê-<nîpin3>k*
* *ê-<nîpih>k*

* *ê-<mispon>k*
* *ê-<mispo0>k*

* *wapâht4>ikâtê>w*
* *wapâhc>ikâtê>w*

* *ê-<mow2>i2ht*
* *ê-<mow>iht*
* *ê-<ayaw2>i2koyâhk*
* *ê-<ayaw>ikoyâhk*
* *kit2<kîskisw>in*
* *ki0<kîskiso>0n*
* *nit2<kîskisw>i2mâwa*
* *ni0<kîskiso>0mâwa*
* *ê-<kîskisw>i2tân*
* *ê-<kîskiso>0tân*
* *ê-<kîskisw>it*
* *ê-<kîskiso>0t*
* *ê-<kîskisw>i2sk*
* *ê-<kîskiso>0sk*
* *ê-<kîskisw>i2koyâhk*
* *ê-<kîskiso>0koyâhk*
* *nit2<kîskisw>i2kawin*
* *ni0<kîskiso>0kawin*
* *kîskisw>in*
* *kîskiso>0n*
* *kîskisw>ii2hkan*
* *kîskisô>0hkan*

* *kit2<nitonaw>in*
* *ki0<nitonaw>in*
* *nit2<nitonaw>i2mâwa*
* *ni0<nitonâ0>0mâwa*
* *ê-<nitonaw>i2tân*
* *ê-<nitonâ0>0tân*
* *ê-<nitonaw>it*
* *ê-<nitonaw>it*
* *ê-<nitonaw>i2sk*
* *ê-<nitonâ0>0sk*
* *ê-<nitonaw>i2koyâhk*
* *ê-<nitonâ0>0koyâhk*
* *nit2<nitonaw>i2kawin*
* *ni0<nitonâ0>0kawin*
* *nitonaw>in*
* *nitonaw>in*
* *nitonaw>îhkan*
* *nitonaw>îhkan*

* *kit2<nakat3>in*
* *ki0<nakas>in*
* *nit2<nakat3>i2mâwa*
* *ni0<nakat>imâwa*
* *ê-<nakat3>i2t>ân*
* *ê-<nakat>it>ân*
* *ê-<nakat3>it*
* *ê-<nakas>it*
* *ê-<nakat3>i2sk*
* *ê-<nakat>isk*
* *ê-<nakat3>i2koyâhk*
* *ê-<nakat>ikoyâhk*
* *nit2<nakat3>i2kawin*
* *ni0<nakat>ikawin*
* *nakat3>in*
* *nakas>in*
* *nakat3>ii2hkan*
* *nakas>îhkan*

* *kit2<kost3>in*
* *ki0<ko0s>in*
* *nit2<kost3>i2mâwa*
* *ni0<kost>imâwa*
* *ê-<kost3>i2tân*
* *ê-<kost>itân*
* *ê-<kost3>it*
* *ê-<ko0s>it*
* *ê-<kost3>i2sk*
* *ê-<kost>isk*
* *ê-<kost3>i2koyâhk*
* *ê-<kost>ikoyâhk*
* *nit2<kost3>i2kawin*
* *ni0<kost>ikawin*
* *kost3>in*
* *ko0s>in*
* *kost3>ii2hkan*
* *ko0s>îhkan*

* *mi4<îwat3>i2^DIMs*
* *m0<îwac>i0s*

**ReduplCRule1**

**ReduplCRule2**

**ReduplY2Rule**

**ReduplY3Rule**

* *d1ay2-<nipâw*
* *na0-<nipâw*

* *d1âh-<nipâw*
* *nâh-<nipâw*

* *d2ay3-d1âh-<nipâw*
* *na0-nâh-<nipâw*

* *d2ay3-d1âh-<ayâw*
* *0ay-0âh-<ayâw*

* *d1âh-<ayâw*
* *0âh-<ayâw*

* *d1ay2-<ayâw*
* *0ay-<ayâw*

INITIAL CHANGE

* *nipât^IC*
* *nêpât0*

* *miyo-<nipât^IC*
* *mêyo-<nipât0*

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
* *o<spiton*

* *ni<spiton*
* *ni<spiton*

* *ki<spiton*
* *ki<spiton*

* *w3<îpit*
* *w<îpit*

* *w3<ahkwan*
* *w<ahkwan*

* *ni4<ohkom*
* *n0<ôhkom*

* *ni4<ohkom>i2nân>ak*
* *n0<ôhkom>inân>ak*

* *ki4<ohkom*
* *k0<ôhkom*

* *w3<ohkom>a*
* *0<ohkom>a*

* *nit2<ospwâkan*
* *nit<ôspwâkan*

* *kit2<ospwâkan*
* *kit<ôspwâkan*

* *ot2<ospwâkan*
* *ot<ôspwâkan*

* * *

<small>This (part of) documentation was generated from [src/fst/phonology-morph-bound.twolc](https://github.com/giellalt/lang-crk/blob/main/src/fst/phonology-morph-bound.twolc)</small>

---


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

__`OUTSIDE RULES`__

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

* * *

<small>This (part of) documentation was generated from [src/fst/phonology.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/fst/phonology.xfscript)</small>

---


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

ordinals

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
* w2       non-collapsing glide, e.g. mowêw:mow2
* t2 		 Epenthetic -t- between person prefixes and vowel-initial stems
* t3       t to s in VTA-4
* t4       t:c in VTI-1 with unspecified actor
* y2       non-collapsing glide
* ý2	 non-collapsing glide
* y3       epenthetic joiner in reduplication of vowel-initial stems
* i2       VTA-5i epenthesis.

* h2 	  Prefix in possessives

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

* * *

<small>This (part of) documentation was generated from [src/fst/root.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/root.lexc)</small>

---


# File containing abbreviations 

## Lexica for adding tags and periods

Splitting in 4 + 1  groups, because of the preprocessor

* **LEXICON Abbreviation   **
1. The ITRAB ;	    lexicon (intransitive abbrs)
1. The TRNUMAB ;   lexicon (abbrs trans wrt. numberals)

## The sublexica
### Dividing between abbreviations with and witout final period

* **LEXICON ab-noun   **

* **LEXICON ab-adv   **

### The lexicons that add tags

* **LEXICON ab-nodot-noun   **  The bulk

* **LEXICON ab-dot-noun   **  This is the lexicon for abbrs that must have a period.

* **LEXICON ab-nodot-adv   **

* **LEXICON ab-dot-adv   **  This is the lexicon for abbrs that must have a period.

* **LEXICON ab-dot-adj   **  This is the lexicon for abbrs that must have a period.

## The abbreviation lexicon itself

* **LEXICON ITRAB   ** are intransitive abbreviations, Ltd. etc.

* **LEXICON TRNUMAB   ** contains abbreviations who are transitive in front of numerals 

For abbrs for which numerals are complements, but other
words not necessarily are. This group treats arabic numerals as
if it were transitive but letters as if it were intransitive.

* **LEXICON TRAB   ** contains transitive abbreviations

This lexicon is for abbrs that always have a constituent following it.

* * *

<small>This (part of) documentation was generated from [src/fst/stems/abbreviations.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/abbreviations.lexc)</small>

---

Place-holder for inserting derivational FST after prefixes and before suffixes
DRV-FST is the place-holder character

Linking verb stems from Derivational FST to their inflectional suffixes

Nouns

Verbs

* * *

<small>This (part of) documentation was generated from [src/fst/stems/derivation_stems.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/derivation_stems.lexc)</small>

---



Test lemma/stem set for nouns according the new crk FST

Complete extraction of lemma:stem info from CW/AEW (2023) and (MD 2023), according to
LEXC structure in the new crk FST.

* * *

<small>This (part of) documentation was generated from [src/fst/stems/noun_header.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/noun_header.lexc)</small>

---



Test lemma/stem set for nouns according the new crk FST

Complete extraction of lemma:stem info from AEW 2020, according to
LEXC structure in the new crk FST.

* * *

<small>This (part of) documentation was generated from [src/fst/stems/noun_stems.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/noun_stems.lexc)</small>

---


# Plains Cree numerals                           

## The file for Arabic, Roman, and other symbolic numerals

* **LEXICON NUM-PREFIXES   **

* **LEXICON ARABIC   ** arabic numerals

* **LEXICON ARABICLOOPphone   ** +358(0)16671254

* **LEXICON ARABICCASEphone   **  

* **LEXICON ARABICLOOP   **

* **LEXICON ARABICLOOPORD   ** ordinals

* **LEXICON NUMARABTAG   ** 

* * *

<small>This (part of) documentation was generated from [src/fst/stems/numeral_symbols.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/numeral_symbols.lexc)</small>

---


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

* * *

<small>This (part of) documentation was generated from [src/fst/stems/numerals.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/numerals.lexc)</small>

---


# Plains Cree particles                           

The file contains the following lexicons, with content as described:

* LEXICON Particle  adds +Ipc

* LEXICON Particle/Interjection   adds +Ipc+Interj

* LEXICON Particle/Name  adds +Ipc+Prop

* LEXICON Particle/Phrase  adds +Ipc+Phr

* LEXICON Particles  contains the actual list of particles.

* * *

<small>This (part of) documentation was generated from [src/fst/stems/particles.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/particles.lexc)</small>

---


## Plains Cree pronouns

There are more pronoums to be added here.

LEXICON Pronoun 

LEXICON Personal  \\
niýa+Pron+Pers+1Sg:niýa # ; 
kiýa+Pron+Pers+2Sg:kiýa # ; 

LEXICON Interrogative   \\
awîna+Pron+Interr+A+Sg:awîna # "who,whose" ; 
awîniki+Pron+Interr+A+Pl:awîniki # "who" ; 
awînihi+Pron+Interr+A+Obv:awînihi # "who" ; 
awîniwâ+Pron+Interr+A+Obv:awîniwâ # "who" ; 

LEXICON Indefinite  \\
awiyak+Pron+Indef+A+Sg:awiyak # "someone" ; 
awiyak+Pron+Indef+A+Pl:awiyakak # "some people" ;

LEXICON Demonstrative    \\
ANIMATE \\
awa+Pron+Dem+Prox+A+Sg:awa # "this" ; 
ôki+Pron+Dem+Prox+A+Pl:ôki # "these" ; 
ôhi+Pron+Dem+Prox+A+Obv:ôhi # "this/these" ; 

INANIMATE \\

ôma+Pron+Dem+Prox+I+Sg:ôma # "this" ; 
ôhi+Pron+Dem+Prox+I+Pl:ôhi # "these" ; 

ôma+Pron+Def+Prox+I+Sg:ôma # "this one" ; 
ôhi+Pron+Def+Prox+I+Pl:ôhi # "these ones" ; 

* * *

<small>This (part of) documentation was generated from [src/fst/stems/pronouns.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/pronouns.lexc)</small>

---



Model verb lemmas and stems for new crk FST

Complete extraction of lemma:stem info from CW/AEW (2023) and (MD 2023), according to
LEXC structure in the new crk FST.

* * *

<small>This (part of) documentation was generated from [src/fst/stems/verb_header.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/verb_header.lexc)</small>

---



Model verb lemmas and stems for new crk FST

Full incorporation of AEW 2020 verbs into new crk FST

* * *

<small>This (part of) documentation was generated from [src/fst/stems/verb_stems.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/stems/verb_stems.lexc)</small>

---

Hyphenator and text to ipa for Plains Cree

Defining sets

The rules

Long vowels

* * *

<small>This (part of) documentation was generated from [src/phonetics/txt2ipa.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/phonetics/txt2ipa.xfscript)</small>

---



* * *

<small>This (part of) documentation was generated from [src/transcriptions/phonology-eng.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/transcriptions/phonology-eng.xfscript)</small>

---



We describe here how abbreviations are in Plains Cree are read out, e.g.
for text-to-speech systems.

For example:

* s.:syntynyt # ;  
* os.:omaa% sukua # ;  
* v.:vuosi # ;  
* v.:vuonna # ;  
* esim.:esimerkki # ; 
* esim.:esimerkiksi # ; 

* * *

<small>This (part of) documentation was generated from [src/transcriptions/transcriptor-abbrevs2text.lexc](https://github.com/giellalt/lang-crk/blob/main/src/transcriptions/transcriptor-abbrevs2text.lexc)</small>

---



Old code

* * *

<small>This (part of) documentation was generated from [src/transcriptions/transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/transcriptions/transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.xfscript)</small>

---



Word-specific explicit solution for verb morphology - Option 1 (works only in FOMA)
Word-specific solution

Word-specific explicit solution for verb morphology - Option 2 (works)

Rule-based solution for verb morphology

Irregular verb forms

* * *

<small>This (part of) documentation was generated from [src/transcriptions/transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/transcriptions/transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.xfscript)</small>

---



Word-specific explicit solution for verb morphology

Rule-based morphological solution

* * *

<small>This (part of) documentation was generated from [src/transcriptions/transcriptor-cw-eng-verb-entry2inflected-phrase.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/transcriptions/transcriptor-cw-eng-verb-entry2inflected-phrase.xfscript)</small>

---


GENERAL DEFINITIONS

VERBS

NOUNS

Continue list of irregular noun plurals here

Assigning +V (+II/AI/TI/TA) or +N as part-of-speech

* * *

<small>This (part of) documentation was generated from [src/transcriptions/transcriptor-eng-phrase2crk-features.xfscript](https://github.com/giellalt/lang-crk/blob/main/src/transcriptions/transcriptor-eng-phrase2crk-features.xfscript)</small>

---


[ L A N G U A G E ]  G R A M M A R   C H E C K E R

# DELIMITERS

# TAGS AND SETS

## Tags

This section lists all the tags inherited from the fst, and used as tags
in the syntactic analysis. The next section, **Sets**, contains sets defined
on the basis of the tags listed here, those set names are not visible in the output.

### Beginning and end of sentence
BOS
EOS

### Parts of speech tags

N
A
Adv
V
Pron
CS
CC
CC-CS
Po
Pr
Pcle
Num
Interj
ABBR
ACR
CLB
LEFT
RIGHT
WEB
PPUNCT
PUNCT

COMMA
¶

### Tags for POS sub-categories

Pers
Dem
Interr
Indef
Recipr
Refl
Rel
Coll
NomAg
Prop
Allegro
Arab
Romertall

### Tags for morphosyntactic properties

Nom
Acc
Gen
Ill
Loc
Com
Ess
Ess
Sg
Du
Pl
Cmp/SplitR
Cmp/SgNom Cmp/SgGen
Cmp/SgGen
PxSg1
PxSg2
PxSg3
PxDu1
PxDu2
PxDu3
PxPl1
PxPl2
PxPl3
Px

Comp
Superl
Attr
Ord
Qst
IV
TV
Prt
Prs
Ind
Pot
Cond
Imprt
ImprtII
Sg1
Sg2
Sg3
Du1
Du2
Du3
Pl1
Pl2
Pl3
Inf
ConNeg
Neg
PrfPrc
VGen
PrsPrc
Ger
Sup
Actio
VAbess

Err/Orth

### Semantic tags

Sem/Act
Sem/Ani
Sem/Atr
Sem/Body
Sem/Clth
Sem/Domain
Sem/Feat-phys
Sem/Fem
Sem/Group
Sem/Lang
Sem/Mal
Sem/Measr
Sem/Money
Sem/Obj
Sem/Obj-el
Sem/Org
Sem/Perc-emo
Sem/Plc
Sem/Sign
Sem/State-sick
Sem/Sur
Sem/Time
Sem/Txt

HUMAN

PROP-ATTR
PROP-SUR

TIME-N-SET

###  Syntactic tags

@+FAUXV
@+FMAINV
@-FAUXV
@-FMAINV
@-FSUBJ>
@-F<OBJ
@-FOBJ>
@-FSPRED<OBJ
@-F<ADVL
@-FADVL>
@-F<SPRED
@-F<OPRED
@-FSPRED>
@-FOPRED>
@>ADVL
@ADVL<
@<ADVL
@ADVL>
@ADVL
@HAB>
@<HAB
@>N
@Interj
@N<
@>A
@P<
@>P
@HNOUN
@INTERJ
@>Num
@Pron<
@>Pron
@Num<
@OBJ
@<OBJ
@OBJ>
@OPRED
@<OPRED
@OPRED>
@PCLE
@COMP-CS<
@SPRED
@<SPRED
@SPRED>
@SUBJ
@<SUBJ
@SUBJ>
SUBJ
SPRED
OPRED
@PPRED
@APP
@APP-N<
@APP-Pron<
@APP>Pron
@APP-Num<
@APP-ADVL<
@VOC
@CVP
@CNP
OBJ
<OBJ
OBJ>
<OBJ-OTHERS
OBJ>-OTHERS
SYN-V
@X

## Sets containing sets of lists and tags

This part of the file lists a large number of sets based partly upon the tags defined above, and
partly upon lexemes drawn from the lexicon.
See the sourcefile itself to inspect the sets, what follows here is an overview of the set types.

### Sets for Single-word sets

INITIAL

### Sets for word or not

WORD
NOT-COMMA

### Case sets

ADLVCASE

CASE-AGREEMENT
CASE

NOT-NOM
NOT-GEN
NOT-ACC

### Verb sets

NOT-V

### Sets for finiteness and mood

REAL-NEG

MOOD-V

NOT-PRFPRC

### Sets for person

SG1-V
SG2-V
SG3-V
DU1-V
DU2-V
DU3-V
PL1-V
PL2-V
PL3-V

### Pronoun sets

### Adjectival sets and their complements

### Adverbial sets and their complements

### Sets of elements with common syntactic behaviour

### NP sets defined according to their morphosyntactic features

### The PRE-NP-HEAD family of sets

These sets model noun phrases (NPs). The idea is to first define whatever can
occur in front of the head of the NP, and thereafter negate that with the
expression **WORD - premodifiers**.

### Border sets and their complements

### Grammarchecker sets

* * *
<small>This (part of) documentation was generated from [tools/grammarcheckers/grammarchecker.cg3](https://github.com/giellalt/lang-crk/blob/main/tools/grammarcheckers/grammarchecker.cg3)</small># Tokeniser for crk

Usage:
```
$ make
$ echo "ja, ja" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "Juos gorreválggain lea (dárbbašlaš) deavdit gáibádusa boasttu olmmoš, man mielde lahtuid." | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "(gáfe) 'ja' ja 3. ja? ц jaja ukjend \"ukjend\"" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "márffibiillagáffe" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

Pmatch documentation:
<https://github.com/hfst/hfst/wiki/HfstPmatch>

Characters which have analyses in the lexicon, but can appear without spaces
before/after, that is, with no context conditions, and adjacent to words:
* Punct contains ASCII punctuation marks
* The symbol after m-dash is soft-hyphen `U+00AD`
* The symbol following {•} is byte-order-mark / zero-width no-break space
`U+FEFF`.

Whitespace contains ASCII white space and
the List contains some unicode white space characters
* En Quad U+2000 to Zero-Width Joiner U+200d'
* Narrow No-Break Space U+202F
* Medium Mathematical Space U+205F
* Word joiner U+2060

Apart from what's in our morphology, there are
1. unknown word-like forms, and
2. unmatched strings
We want to give 1) a match, but let 2) be treated specially by
`hfst-tokenise -a`
Unknowns are made of:
* lower-case ASCII
* upper-case ASCII
* select extended latin symbols
ASCII digits
* select symbols
* Combining diacritics as individual symbols,
* various symbols from Private area (probably Microsoft),
so far:
* U+F0B7 for "x in box"

## Unknown handling
Unknowns are tagged ?? and treated specially with `hfst-tokenise`
hfst-tokenise --giella-cg will treat such empty analyses as unknowns, and
remove empty analyses from other readings. Empty readings are also
legal in CG, they get a default baseform equal to the wordform, but
no tag to check, so it's safer to let hfst-tokenise handle them.

Finally we mark as a token any sequence making up a:
* known word in context
* unknown (OOV) token in context
* sequence of word and punctuation
* URL in context

* * *

<small>This (part of) documentation was generated from [tools/tokenisers/tokeniser-disamb-gt-desc.pmscript](https://github.com/giellalt/lang-crk/blob/main/tools/tokenisers/tokeniser-disamb-gt-desc.pmscript)</small>

---

# Grammar checker tokenisation for crk

Requires a recent version of HFST (3.10.0 / git revision>=3aecdbc)
Then just:
```
$ make
$ echo "ja, ja" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

More usage examples:
```
$ echo "Juos gorreválggain lea (dárbbašlaš) deavdit gáibádusa boasttu olmmoš, man mielde lahtuid." | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "(gáfe) 'ja' ja 3. ja? ц jaja ukjend \"ukjend\"" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
$ echo "márffibiillagáffe" | hfst-tokenise --giella-cg tokeniser-disamb-gt-desc.pmhfst
```

Pmatch documentation:
<https://github.com/hfst/hfst/wiki/HfstPmatch>

Characters which have analyses in the lexicon, but can appear without spaces
before/after, that is, with no context conditions, and adjacent to words:
* Punct contains ASCII punctuation marks
* The symbol after m-dash is soft-hyphen `U+00AD`
* The symbol following {•} is byte-order-mark / zero-width no-break space
`U+FEFF`.

Whitespace contains ASCII white space and
the List contains some unicode white space characters
* En Quad U+2000 to Zero-Width Joiner U+200d'
* Narrow No-Break Space U+202F
* Medium Mathematical Space U+205F
* Word joiner U+2060

Apart from what's in our morphology, there are
1) unknown word-like forms, and
2) unmatched strings
We want to give 1) a match, but let 2) be treated specially by hfst-tokenise -a
* select extended latin symbols
* select symbols
* various symbols from Private area (probably Microsoft),
so far:
* U+F0B7 for "x in box"

TODO: Could use something like this, but built-in's don't include šžđčŋ:

Simply give an empty reading when something is unknown:
hfst-tokenise --giella-cg will treat such empty analyses as unknowns, and
remove empty analyses from other readings. Empty readings are also
legal in CG, they get a default baseform equal to the wordform, but
no tag to check, so it's safer to let hfst-tokenise handle them.

Finally we mark as a token any sequence making up a:
* known word in context
* unknown (OOV) token in context
* sequence of word and punctuation
* URL in context

* * *

<small>This (part of) documentation was generated from [tools/tokenisers/tokeniser-gramcheck-gt-desc.pmscript](https://github.com/giellalt/lang-crk/blob/main/tools/tokenisers/tokeniser-gramcheck-gt-desc.pmscript)</small>

---

