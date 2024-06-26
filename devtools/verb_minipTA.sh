#!/bin/bash

# script to generate paradigms for generating word forms
# command, when you are in smn:
# sh devtools/verb_minip.sh 2SYLL_OD | less
# sh devtools/verb_minip.sh kihlođ 


LOOKUP=$(echo $LOOKUP)
GTHOME=$(echo $GTHOME)


PATTERN=$1
L_FILE="in.txt"
cut -d '!' -f1 src/fst/stems/morphology/verbs.lexc | egrep $PATTERN | cut -d ':' -f1>$L_FILE

P_FILE="test/data/testverbparadigmTA.txt"

for lemma in $(cat $L_FILE);
do
 for form in $(cat $P_FILE);
 do
   echo "${lemma}${form}" | $LOOKUP $GTHOME/langs/crk/src/generator-gt-norm.xfst
 done
done

