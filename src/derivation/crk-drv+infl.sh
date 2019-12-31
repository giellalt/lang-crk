#!/bin/sh

hfst-lexc crk-drv.lexc -o crk-drv-morph.hfst
echo 'Compiled derivational morphology.' ;

hfst-xfst -F crk-drv.regex
echo 'Compiled derivational phonology.' ;

hfst-xfst -F crk-morphophon.regex
echo 'Compiled derivational morphophonology' ;

hfst-compose -F -x ON -1 crk-drv-morph.hfst -2 crk-drv-phon.hfst -o - |
hfst-compose -x ON -1 - -2 crk-morphophon.hfst -o crk-drv.hfst
echo 'Composed together derivational morphology and phonology.' ;

cat $GTLANG_crk/src/morphology/root.lexc $GTLANG_crk/src/morphology/affixes///noun_affixes.lexc $GTLANG_crk/src/morphology/affixes///propernouns.lexc $GTLANG_crk/src/morphology/affixes///verb_affixes.lexc $GTLANG_crk/src/morphology/stems///abbreviations.lexc $GTLANG_crk/src/morphology/stems///crk-propernouns.lexc $GTLANG_crk/src/morphology/stems///noun_stems.lexc $GTLANG_crk/src/morphology/stems///numerals.lexc $GTLANG_crk/src/morphology/stems///particles.lexc $GTLANG_crk/src/morphology/stems///pronouns.lexc $GTLANG_crk/src/morphology/stems///verb_stems.lexc $GTLANG_crk/src/morphology///stems/derivation_stems.lexc > crk-infl.lexc

hfst-lexc crk-infl.lexc -o crk-infl-morph.hfst
echo 'Compiled inflectional morphology.' ;

hfst-substitute -i crk-infl-morph.hfst -o crk-drv-infl-morph.hfst -f 'DRV-FST' -T crk-drv.hfst
echo 'Substituted DRV-FST with derivational model.' ;

hfst-xfst -e "load crk-drv-infl-morph.hfst" -e "eliminate flag infl" -E "save stack crk-drv-infl-morph.hfst"

# hfst-eliminate-flags -F infl -i crk-drv-infl-morph.hfst -o crk-drv-infl-morph2.hfst 
echo 'Removed flag: infl' ;

hfst-twolc -i $GTLANG_crk/src/phonology/crk-phon.twolc -o crk-phon.hfst
echo 'Compiled inflectional morphophonological TWOLC rules.'

echo 'Composing and intersecting together inflectional morphology and phonology.'
hfst-compose-intersect crk-drv-infl-morph.hfst crk-phon.hfst |
hfst-minimize -i - -o crk-gen-norm.hfst

echo 'Done' ;
