#!/bin/sh

# Script for creating a descriptive analyzer and a normative generator for crk

echo 'Concatenating LEXC files.' ;

cat $GTLANG_crk/src/fst/root.lexc $GTLANG_crk/src/fst/affixes/noun_affixes.lexc $GTLANG_crk/src/fst/affixes/verb_affixes.lexc $GTLANG_crk/src/fst/stems/noun_stems.lexc $GTLANG_crk/src/fst/stems/numerals.lexc $GTLANG_crk/src/fst/stems/particles.lexc $GTLANG_crk/src/fst/stems/pronouns.lexc $GTLANG_crk/src/fst/stems/verb_stems.lexc > crk-dict.lexc

echo 'Compiling LEXC code.' ;

hfst-lexc crk-dict.lexc -o crk-lexc-dict.hfst

# Test:
echo 'Test: crk-lexc-dict.hfst' ;
echo 'nipâw+V+AI+Ind+1Sg -> nit2<nipâ>n2' ;
echo 'nipâw+V+AI+Ind+1Sg' | hfst-lookup -q crk-lexc-dict.hfst

# echo 'Compiling TWOLC code.' ;
# hfst-twolc -i $GTLANG_crk/src/phononology.twolc -o crk-phon.hfst
#
# echo 'Composing and intersecting LEXC and TWOL transducers.' ;
# hfst-compose-intersect crk-lexc-dict.hfst crk-phon.hfst | hfst-minimize - -o crk-gen-norm-dict.hfst

echo 'Compiling XFSCRIPT code for morphophonology.' ;

hfst-xfst -e "source src/fst/phonology.xfscript" -E "save stack crk-phon.hfst"

# Test:
echo 'Test: crk-phon.hfst' ;
echo 'nit2<nipâ>n2 -> ni<nipâ>n' ;
echo "nit2<nipâ>n2" | hfst-lookup -q crk-phon.hfst

hfst-compose -F -1 crk-lexc-dict.hfst -2 crk-phon.hfst | hfst-minimize - -o crk-gen-norm-bound-dict.hfst

# Test:
echo 'Test: crk-gen-norm-bound-dict.hfst' ;
echo 'nipâw+V+AI+Ind+1Sg -> ni<nipâ>n' ;
echo 'nipâw+V+AI+Ind+1Sg' | hfst-lookup -q crk-gen-norm-bound-dict.hfst

echo 'Inverting normative generator transducer into a normative analyser transducer.' ;

hfst-invert crk-gen-norm-bound-dict.hfst -o crk-anl-norm-bound-dict.hfst

# Test:
echo 'Test: crk-anl-norm-bound-dict.hfst' ;
echo 'ni<nipâ>n -> nipâw+V+AI+Ind+1Sg' ;
echo 'ni<nipâ>n' | hfst-lookup -q crk-anl-norm-bound-dict.hfst

echo 'Compiling regular expression implementing spelling-relaxation.' ;

hfst-regexp2fst -S -i $GTLANG_crk/src/orthography/spellrelax.regex | hfst-invert -o crk-orth.hfst
# hfst-regexp2fst -S -i $GTLANG_crk/src/orthography/spellrelax-weighted.regex | hfst-invert -o crk-orth.hfst

echo 'Composing spelling relaxation transducer with normative analyser transducer to create descriptive analyser.'

hfst-compose -F -1 crk-orth.hfst -2 crk-anl-norm-bound-dict.hfst | hfst-minimize - -o crk-anl-desc-bound-dict.hfst

# Test:
echo 'Test: crk-anl-desc-bound-dict.hfst' ;
echo 'ni<nipa>n -> nipâw+V+AI+Ind+1Sg' ;
echo 'ni<nipa>n' | hfst-lookup -q crk-anl-desc-bound-dict.hfst

echo 'Compiling filter to remove non-normative forms with +Err/Orth tag.' ;

echo '~[ $[ "+Err/Orth" ] ] ;' | hfst-regexp2fst -S -o crk-err-filter.hfst

echo 'Compiling transcriptor to remove morpheme boundaries.' ;

hfst-xfst -e 'regex [ "<" | ">" ] -> 0 ;' -E "save stack crk-remove-boundaries.hfst"

echo 'Removing morpheme boundaries from descriptive analyzer.' ;

hfst-invert -i crk-remove-boundaries.hfst -o - | hfst-compose -F -1 - -2 crk-anl-desc-bound-dict.hfst -o crk-anl-desc-dict.hfst

# Test:
echo 'Test: crk-anl-desc-dict.hfst' ;
echo 'ninipan -> nipâw+V+AI+Ind+1Sg' ;
echo 'ninipan' | hfst-lookup -q crk-anl-desc-dict.hfst

echo 'Removing lexicalised non-normative forms from normative analyzer and generator.' ;

hfst-compose -F -1 crk-err-filter.hfst -2 crk-gen-norm-bound-dict.hfst |
hfst-compose -F -1 - -2 crk-remove-boundaries.hfst | hfst-invert -o crk-anl-norm-dict.hfst

hfst-invert -i crk-anl-norm-dict.hfst -o crk-gen-norm-dict.hfst

# Test:
echo 'Test: crk-anl-norm-dict.hfst' ;
echo 'ninipân -> nipâw+V+AI+Ind+1Sg' ;
echo 'ninipân' | hfst-lookup -q crk-anl-norm-dict.hfst
echo 'Test: crk-gen-norm-dict.hfst' ;
echo 'nipâw+V+AI+Ind+1Sg -> ninipân' ;
echo 'nipâw+V+AI+Ind+1Sg' | hfst-lookup -q crk-gen-norm-dict.hfst

##### END HFST compililations #####

echo 'Creating FOMA versions of selected transducers.' ;

hfst-invert crk-gen-norm-dict.hfst | hfst-fst2fst -b -F -i - -o crk-gen-norm-dict.fomabin

hfst-fst2fst -b -F -i crk-orth.hfst -o crk-orth.fomabin

foma -e"load crk-gen-norm-dict.fomabin" -e"invert net" -e"define Morph" -e"load crk-orth.fomabin" -e"invert net" -e"define Orth" -e"regex [ Morph .o. Orth ];" -e"save stack crk-anl-desc-dict.fomabin" -s
