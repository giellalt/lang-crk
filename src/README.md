How to use the alternative Makefile
===================================

    make -j -f quick.mk

This will create:

 - `crk-strict-analyzer.hfstol` -- reads Plains Cree wordforms and
   outputs analyses. Wordforms must be written in _perfect_ SRO.
 - `crk-descriptive-analyzer.hfstol` -- reads Plains Cree wordforms, and
   outputs possible analyses. Wordforms can be written with known
   spelling variations, including long vowel relaxation.
 - `crk-normative-generator.hfstol` -- given a morphological analyses,
   produces Plains Cree wordforms in SRO.
 - `crk-normative-generator-with-morpheme-boundaries.hfstol` -- same as
   above, but includes `<` and `>` to indicate morpheme boundaries
