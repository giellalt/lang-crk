
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
* +RIGHT +MIDDLE  = the right part of a paired punctuation symbol
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

<small>This (part of) documentation was generated from [src/fst/morphology/root.lexc](https://github.com/giellalt/lang-crk/blob/main/src/fst/morphology/root.lexc)</small>
