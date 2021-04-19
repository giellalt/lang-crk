# How to handle variation in lexc

## Different orthographies
The lexc can be written with SRO (The Standard Roman Orthography) 

From this one can compile alternative FSTs with systematic variation, as a base for generation of spell checker programs and ICALL-programs.
* with macron-FST 
* with circumflex-FST
* no-length-marking-FST
* with converting to syllabics

For an analyser to be used for analysing texts, one can use spell relax to get the analyser to understand all orthographies. With spell relax there will not be  any tags in the output to tell which kind of orthography is used.

Words with another orthography, from other dialects:
* if systematic, it can be done in the compiling process
* if not systematic, one can use tags, e.g. Dial/Mask. They with be included in the compiling when one asks for it.

## Non-normative forms: Err/Sub
These are forms, which don't follow orthographic principles, but still they are in texts, which we want to analyse.

### ex. from North Saami: "bázáhus" is a non-normative form of the lemma "bázahus"
The normative form should be on the left side, and then the lemma in the analysis will be a normative form and can be found e.g. in the dictionary.

`bázahus:bázahuss JOHTOLAT "remainder" ; ` \\
`bázahus+Err/Orth:bázáhuss JOHTOLAT "remainder" ; `

The descriptive FST will inflect both "bázahus" and "bázáhus", but the string with the tag Err/Sub is removed from the normative analyser/generator during the compilation prosess. 
```
bázahusat 
bázahusat	bázahus+N+Pl+Nom

bázáhusat
bázáhusat	bázahus+Err/Orth+N+Pl+Nom
```

The normative analyser:
```
bázahusat 
bázahusat	bázahus+N+Pl+Nom

bázáhusat
bázáhusat	bázáhusat	+?
```

## The word itself is non-normative: Err/Lex
Ex. "brillefutterála" which is a slightly adapated loanword from Norwegian to North Saami. The normative word is "čalbmelássaskuohppu"

`brillefutterála+Err/Lex:brille#futterál SOSIAL "spectacle case" ;`

The descriptive FST will inflect "brillefutterála", but the line with the tag Err/Lex is removed from the normative analyser/generator during the compilation prosess. 
```
brillefutterálat 
brillefutterálat	brillefutterála+N+Err/Lex+Pl+Nom
```

The normative analyser:
```
brillefutterálat
brillefutterálat	brillefutterálat	+?
```

## Lexical homonymi: how to identify the correct lemma e.g. in a dictionary
Two lemmas can have identical base forms, but different paradigms and semantics. 

### The lemmas belong to different stem-categories: Add morphogical tags
Example from North Saami. G3 = Grade 3 in consonant gradation 

`beassi:beassi BEARRI "nest" ;` \\
`beassi+G3:beas'si AIGI "birchbark" ; `

 
Analysis:
```
beassi
beassi	beassi+N+G3+Sg+Nom
beassi	beassi+N+G3+Sg+Acc
beassi	beassi+N+G3+Sg+Gen
beassi	beassi+N+Sg+Nom

beasi
beasi	beassi+N+Sg+Gen
beasi	beassi+N+Sg+Acc
```

 

 
Example from North Saami. NomAg tag for derivation Nomen Agentis 

`vuovdi+NomAg:vuovdi ACTOR "salesman" ;` \\
`vuovdi+G3:vuov'di AIGI "forest" ; `

Analysis:
```
vuovdi
vuovdi	vuovdi+N+NomAg+Sg+Nom
vuovdi	vuovdi+N+NomAg+Sg+Acc
vuovdi	vuovdi+N+NomAg+Sg+Gen
vuovdi	vuovdi+N+Sg+Nom

vuovddi
vuovddi	vuovdi+N+Sg+Gen
vuovddi	vuovdi+N+Sg+Acc
```

 

### In stead of morphogical tags, one can add homonymi tags
Example from South Saami, two verbs:

`govledh+Hom1:govl TJOEHPEDH_TV "hear" ;` \\
`govledh+Hom2:govl VÅÅJNEDH "sound" ;`

Analysis:

```
gåvla
gåvla	govledh+Hom1+V+TV+Ind+Prs+Sg3

govloe
govloe	govledh+Hom2+V+IV+Ind+Prs+Sg3
```

## Orthograpic variants (all normative) of the same lemma: tags v1, v2...

One lemma can have orthograpic variants for base form and at least parts of the inflection paradigm. We can add a variants tag as a help to recognize the correct base form for the paradigm.

Example from North Saami: 

`mandáhta+v2:mandáhtta GOAHTI-A "mandate" ; ` \\
`mandáhta+v1:mandáhta STAHTA "mandate" ;`

Generation with normative generator gives:
```
mandáhta+v2+N+Ess
mandáhta+v2+N+Ess	mandáhttan

mandáhta+v1+N+Ess
mandáhta+v1+N+Ess	mandáhtan
```

If the base forms are identical, but there are variants in the inflection, we don't use these tags.
