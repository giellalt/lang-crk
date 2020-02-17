#!/bin/sh

# Script for creating a descriptive analyzer and a normative generator for crk

echo 'Concatenating LEXC files.' ;

cat $GTLANG_crk/src/morphology/root.lexc $GTLANG_crk/src/morphology/affixes///noun_affixes.lexc $GTLANG_crk/src/morphology/affixes///verb_affixes.lexc $GTLANG_crk/src/morphology/stems///noun_stems.lexc $GTLANG_crk/src/morphology/stems///numerals.lexc $GTLANG_crk/src/morphology/stems///particles.lexc $GTLANG_crk/src/morphology/stems///pronouns.lexc $GTLANG_crk/src/morphology/stems///verb_stems.lexc > crk-dict.lexc

echo 'Compiling LEXC code.' ;

hfst-lexc crk-dict.lexc -o crk-lexc-dict.hfst

# echo 'Compiling TWOLC code.' ;

# hfst-twolc -i $GTLANG_crk/src/phonology/crk-phon.twolc -o crk-phon.hfst

echo 'Composing and intersecting LEXC and TWOL transducers.' ;

hfst-compose-intersect crk-lexc-dict.hfst crk-phon.hfst | hfst-minimize - -o crk-gen-norm-dict.hfst

echo 'Inverting normative generator transducer into a normative analyser transducer.' ;

hfst-invert crk-gen-norm-dict.hfst -o crk-anl-norm-dict.hfst

echo 'Compiling regular expression implementing spelling-relaxation.' ;

hfst-regexp2fst -S -i $GTLANG_crk/src/orthography/spellrelax.regex | hfst-invert -o crk-orth.hfst
! hfst-regexp2fst -S -i $GTLANG_crk/src/orthography/spellrelax-weighted.regex | hfst-invert -o crk-orth.hfst

echo 'Composing spelling relaxation transducer with normative analyser transducer to create descriptive analyser.'

hfst-compose -F -1 crk-orth.hfst -2 crk-anl-norm-dict.hfst | hfst-minimize - -o crk-anl-desc-dict.hfst

echo 'Compiling filter to remove non-normative forms with +Err/Orth tag.' ;

echo '~[ $[ "+Err/Orth" ] ] ;' | hfst-regexp2fst -S -o crk-err-filter.hfst

echo 'Removing lexicalised non-normative forms from normative analyzer and generator.' ;

hfst-compose -F -1 crk-err-filter.hfst -2 crk-gen-norm-dict.hfst | hfst-invert -o crk-anl-norm-dict.hfst

hfst-invert -i crk-anl-norm-dict.hfst -o crk-gen-norm-dict.hfst

echo 'Creating FOMA versions of selected transducers.' ;

hfst-fst2fst -b -F -i crk-gen-norm-dict.hfst -o crk-gen-norm-dict.fomabin

hfst-fst2fst -b -F -i crk-orth.hfst -o crk-orth.fomabin

foma -e"load crk-gen-norm-dict.fomabin" -e"define M" -e"load crk-orth.fomabin" -e"invert net" -e"define O" -e"regex [ M .o. O ];" -e"save stack crk-anl-desc-dict.fomabin" -s
