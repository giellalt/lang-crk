#!/bin/sh

SUFFIX="";

hfst-lexc $GTLANG_crk/src/derivation/crk-drv.lexc -o crk-drv-morph$SUFFIX.hfst
echo 'CRK-DRV: Compiled derivational morphology.' ;

hfst-xfst -F $GTLANG_crk/src/derivation/crk-drv.regex
echo 'Compiled derivational phonology.' ;

hfst-xfst -F $GTLANG_crk/src/derivation/crk-morphophon.regex
echo 'CRK-DRV: Compiled derivational morphophonology' ;

echo '~[ $[ [ a | â | ê | i | î | o | ô ] ( [ w | y | ý ] ) [ "/" [ a | â | ê | i | î | o | ô ] ( [ w | y | ý ] ) ]^2 ] ] ;' |
hfst-regexp2fst -S -o crk-drv-VG3-filter.hfst
echo 'CRK-DRV: Compiled filter to exclude excessive VG cases.';

hfst-compose -F -x ON -1 crk-drv-morph$SUFFIX.hfst -2 crk-drv-VG3-filter.hfst -o - |
hfst-compose -F -x ON -1 - -2 crk-drv-phon.hfst -o - |
hfst-compose -x ON -1 - -2 crk-morphophon.hfst -o crk-drv$SUFFIX.hfst

# hfst-compose -F -x ON -1 crk-drv-morph$SUFFIX.hfst -2 crk-drv-phon.hfst -o - |
# hfst-compose -x ON -1 - -2 crk-morphophon.hfst -o crk-drv$SUFFIX.hfst
echo 'CRK-DRV: Composed together derivational morphology and phonology.' ;

cat $GTLANG_crk/src/fst/root.lexc $GTLANG_crk/src/fst/affixes///noun_affixes.lexc $GTLANG_crk/src/fst/affixes///propernouns.lexc $GTLANG_crk/src/fst/affixes///verb_affixes.lexc $GTLANG_crk/src/fst/stems///abbreviations.lexc $GTLANG_crk/src/fst/stems///crk-propernouns.lexc $GTLANG_crk/src/fst/stems///noun_stems.lexc $GTLANG_crk/src/fst/stems///numerals.lexc $GTLANG_crk/src/fst/stems///particles.lexc $GTLANG_crk/src/fst/stems///pronouns.lexc $GTLANG_crk/src/fst/stems///verb_stems.lexc $GTLANG_crk/src/fst///stems/derivation_stems.lexc > crk-infl.lexc

hfst-lexc crk-infl.lexc -o crk-infl-morph.hfst
echo 'CRK-DRV: Compiled inflectional morphology.' ;

hfst-substitute -i crk-infl-morph.hfst -o crk-drv-infl-morph$SUFFIX.hfst -f 'DRV-FST' -T crk-drv$SUFFIX.hfst
echo 'CRK-DRV: Substituted DRV-FST with derivational model.' ;

hfst-xfst -e "load crk-drv-infl-morph$SUFFIX.hfst" -e "twosided flag-diacritics" -e "eliminate flag infl" -e "eliminate flag morf" -E "save stack crk-drv-infl-morph$SUFFIX.hfst"

# hfst-eliminate-flags -F infl -i crk-drv-infl-morph.hfst -o crk-drv-infl-morph2.hfst 
echo 'CRK-DRV: Removed flag: infl' ;
echo 'CRK-DRV: Removed flag: morf' ;

hfst-twolc -i $GTLANG_crk/src/fst/phonology.twolc -o crk-phon.hfst
# echo 'Compiled inflectional morphophonological TWOLC rules.'

echo 'CRD-DRV: Composing and intersecting together inflectional morphology and phonology.'
hfst-compose-intersect crk-drv-infl-morph$SUFFIX.hfst crk-phon.hfst |
hfst-minimize -i - -o crk-gen-norm$SUFFIX.hfst

echo 'CRT-DRV: Inverting generating FST to create analyzing FST.' ;

hfst-invert -i crk-gen-norm$SUFFIX.hfst -o crk-anl-norm$SUFFIX.hfst

echo 'CRK-DRV: Creating optimized versions of both FSTs.' ;

hfst-fst2fst -w -i crk-gen-norm$SUFFIX.hfst -o crk-gen-norm$SUFFIX.hfstol
hfst-fst2fst -w -i crk-anl-norm$SUFFIX.hfst -o crk-anl-norm$SUFFIX.hfstol

echo 'CRK-DRV: Done' ;
