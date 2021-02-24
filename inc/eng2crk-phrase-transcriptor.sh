#!/bin/sh

# eng2crk-phrase-transcriptor.sh

# EXAMPLES:

# English noun phrase: 
# echo 'in my little book' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin WA_fst_cg.frequency_list.txt| head -10
# NO CRK MATCH
# in my little book
# => book
# => +N+Dim+Px1Sg+Loc
# -----
# nimasinahikanisihk <-- masinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1] (n=26)
#      ≈  in my little book; in my little letter, in my little mail; in my little written document, in my little report, in my little paper; in# my little magazine; in my little will [NI]
#
# ninêhiyawasinahikanisihk <-- nêhiyawasinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1] (n=1)
#      ≈  in my little Cree book; in my little Cree bible [NI]
#
# ...
# English verb phrase:
# echo 'I work together with you' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin WA_fst_cg.frequency_list.txt| head -10 
# NO CRK MATCH
# I work together with you
# => work together with
# => +V+TA+1Sg+2SgO
# -----
# ê-wîtapimitân <-- PV/e+wîtapimêw+V+TA+Cnj+1Sg+2SgO [VTA-1] (n=16)
#      ≈  I sit with you, I sit beside you, I stay with you, I am present with you; I work together with you; I sit by you [VTA]
#
# ê-wîtatoskêmitân <-- PV/e+wîtatoskêmêw+V+TA+Cnj+1Sg+2SgO [VTA-1] (n=2)
#      ≈  I work together with you, I have you as your fellow worker [VTA]
#
# ...
# Cree verb form:
# echo 'niki-nitawi-kiskinwahamakosin' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin WA_fst_cg.frequency_list.txt | head -10  
# nikî-nitawi-kiskinwahamâkosin (<- niki-nitawi-kiskinwahamakosin)
# => kiskinwahamâkosiw [VAI-1]
# => PV/ki+PV/nitawi+_+V+AI+Ind+1Sg
# -----
#      ≈  I learn>ed; I was a student, I attend>ed school; I was taught [VAI]
# ...


gawk -v DICT=$1 -v ENGANLFST=$2 -v CRKANLFST=$3 -v CRKGENFST=$4 -v ENGNOUNGENFST=$5 -v ENGVERBGENFST=$6 -v CORPFREQ=$7 -f inc/eng2crk-phrase-transcriptor.gawk
