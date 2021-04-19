This file gives an nverview of some still ad hoc solutions for disambiguation.

# Prerequisites:

* vislcg3 installed A text corpus. 

# How to analyse

Plains Cree differs from the other languuages in not having an adjusted
version of the preprocessor yet. While waiting , we do some ad hoc
solutions. Here is a pipeline that gives an analysis.

```
cat misc/CORR_Dog_Biscuits.txt |preprocess|lookup src/analyser-gt-desc.xfst | lookup2cg | vislcg3 -g src/syntax/disambiguation.cg3
```

The string *lookup src/analyser-gt-desc.xfst* might be express as the alias *ucrk*.

Dog Biscuits does not use the ' symbol as a letter, so we may use *preprocess*. 
With the Mary Wells text (and possibly other texts) using this letter, we use an ad hoc set of commands instead of *preprocess*, as below. The command below is there to build a

```
cat misc/7C_Mary_Wells.txt |sed 's/\([.,:;‘’"]\)/ \1 /g;'](tr '[  )' '\n'|\
grep -v '~$'|grep -v '^$'|lookup src/analyser-gt-desc.xfst | lookup2cg | vislcg3 -g src/syntax/disambiguation.cg3
```

# Missing list

In order to make good analyses, we need the words of the text in the analyser, 
i.e. we need to build a *missing list*, and add its word to the analyser. Here is 
a command for making a missing list (for the two texts, respectively).

```
cat misc/CORR_Dog_Biscuits.txt |preprocess|lookup src/analyser-gt-desc.xfst |grep '?'|sort|uniq -c|sort -nr|less

cat misc/7C_Mary_Wells.txt |sed 's/\([.,:;‘’"]\)/ \1 /g;'](tr '[  )' '\n'|\
grep -v '~$'|grep -v '^$'|lookup src/analyser-gt-desc.xfst |grep '?'|sort|uniq -c|sort -nr|less

cat misc/PCT.txt|ucrk|grep '?'|sort|uniq -c|sort -nr|less
```

# Strategies for disambiguation

Look at common ambiguity patterns in some texts.

* Grammar ambiguity
    - [Mary Wells](data/grammarambiguity.html)
    - [Bloomfiel](data/pct.grammar.html)
* Word ambiguity
    - [Mary Wells](data/wordambiguity.html)
    - [Bloomfield](data/pct.words.html)

To create similar statics, use the `sum-cg.pl` script (write *sum-cg.pl --help* 
in order to get just that. The input to the script should be the analysed text **before**
disambiguation:

```
cat misc/CORR_Dog_Biscuits.txt |preprocess|lookup src/analyser-gt-desc.xfst | lookup2cg > xxdogbiscuits.multi

sum-cg.pl --grammar xxdogbiscuits.multi | less
```

You may of course also take the disambiguated text as input, and use the sum-cg 
as a script to find where to go next.

## vislcg3 rules
* [tutorial](http://beta.visl.sdu.dk/cg3_howto.pdf)
* [documentation of vislcg3-syntax](http://beta.visl.sdu.dk/cg3/single/)
* [sand-box](http://beta.visl.sdu.dk/cglab.htm)

### Operators:
* DELIMITERS : 
    - This will work as an on-the-fly sentence (disambiguation window) delimiter.
* LIST KIN = "daughter" "mother" "father" "aunt" "uncle" ; 
* LIST WORD = N ADJ V ADV NUM ;
* LIST NP-MOD = ADJ ADV ;
* LIST @Kinship = @Kinship ;
* SET NOT-NP-MOD = WORD - NP-MOD ;
* SELECT INFM IF (1 INF) ; 
    - Singles out a reading from the cohort that matches the target, and if all contextual tests are satisfied it will delete all other readings except the matched one.
* REMOVE INFM IF (NOT 1 INF) ; 
    - Singles out a reading from the cohort that matches the target, and if all contextual tests are satisfied it will delete the mached reading.
* SELECT N IF (*-1 ART BARRIER NOT-NP-MOD) ;
* SELECT N IF (*-1 ART CBARRIER V) ;  
* REMOVE INF (NEGATE -1 N LINK -1 INF LINK -1 INFM ) ;
* MAP @Kinship TARGET KIN + N ;
* ADD  
    - Appends tag to matching readings. Will not block for adding further tags
* MAP @3SERR TARGET (-3S)(-1 (S NOM) OR (3S NOM)) ; 
    - Appends tags to matching readings, and blocks other MAP, ADD
* SUBSTITUTE (N S NOM) (N S Nom) N ; 
    - Replaces the tags in the first list with the tags in the second list. 

### Careful mode: 
* 1C NOM 
    - if the only reading left is NOM

###  Apply function tags

 
Make a set for the function tag, and make one or more rules: 
* LIST @SUBJ = @SUBJ ;
* MAP @SUBJ TARGET NOM IF (1 VFIN) ;
* LIST @SUBJ> = @SUBJ> ;
* MAP @SUBJ> TARGET NOM IF (1 VFIN) ; 
    - with arrow towards the finite verb

# Aliases

Put these in your .profile or .bashrc folder

```
alias crkdep="sent-proc.sh -l crk -s dep"
alias crkdept="sent-proc.sh -l crk -s dep -t"
alias crkdis="sent-proc.sh -l crk -s dis"
alias crkdist="sent-proc.sh -l crk -s dis -t"
```
