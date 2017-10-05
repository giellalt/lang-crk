#!/bin/sh

# Unix commands for running HFST to compile the new TWOLC and LEXC code for crk nouns 

echo 'Compiling TWOLC code.' ;

hfst-twolc -R inc/crk-phon.twolc -o inc/crk-phon.hfst

# The following code is needed within hfst-xfst, if one wants
# to intersect the TWOLC rules manually.
# However, that does not appear to be strictly necessary, nor speed things
#
# hfst[0]: load inc/crk-phon.hfst
# hfst[xx]: intersect
# hfst[1]: save stack inc/crk-phon-intr.hfst

echo 'Compiling LEXC code.' ;

hfst-lexc -o noun.hfst inc/noun_affixes.lexc

# This is for composing the LEXC hfst and intersected TWOLC hfst

# hfst-compose-intersect -o inc/noun_anl.hfst inc/noun.hfst inc/crk-phon-intr.hfst

# This is for composing the LEXC hfst with a non-intersected TWOLC hfst
# The entire operation appears to go about quite quickly

echo 'Intersecting compiled TWOLC hfst and composing that with compiled LEXC hfst.' ;

hfst-compose-intersect -o inc/noun_anl.hfst inc/noun.hfst inc/crk-phon.hfst

echo 'Finished.' ;