
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

