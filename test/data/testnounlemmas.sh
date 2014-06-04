# This script tests if words which are used as lemmas in nouns.lexc can be generated as N+Animacy+Sg
# command: sh testnounlemmas.sh

grep ' A' $GTHOME/langs/crk/src/morphology/stems/nouns.lexc |egrep -v '^(LEX|\!|[A-Z].|<|@)' | tr ':' ' ' | cut -d ' ' -f1 > $GTHOME/langs/crk/dev/anouns
grep ' I' $GTHOME/langs/crk/src/morphology/stems/nouns.lexc |egrep -v '^(LEX|\!|[A-Z].|<|@)' | tr ':' ' ' | cut -d ' ' -f1 > $GTHOME/langs/crk/dev/inouns
cat $GTHOME/langs/crk/dev/anouns | sed 's/$/+N+AN+Sg/' | $LOOKUP $GTHOME/langs/crk/src/generator-gt-desc.xfst | cut -f2 | grep -v 'N+' | grep -v '^$' > $GTHOME/langs/crk/dev/gennouns
cat $GTHOME/langs/crk/dev/inouns | sed 's/$/+N+IN+Sg/' | $LOOKUP $GTHOME/langs/crk/src/generator-gt-desc.xfst | cut -f2 >> $GTHOME/langs/crk/dev/gennouns
cat $GTHOME/langs/crk/dev/inouns $GTHOME/langs/crk/dev/anouns | sort -u > $GTHOME/langs/crk/dev/nounlemmas
sort -u -o $GTHOME/langs/crk/dev/gennouns $GTHOME/langs/crk/dev/gennouns
echo 'These lemmas can not be generated as they are written here:' > $GTHOME/langs/crk/dev/missingnounlemmas
echo '' >> $GTHOME/langs/crk/dev/missingnounlemmas
comm -23 $GTHOME/langs/crk/dev/nounlemmas $GTHOME/langs/crk/dev/gennouns >> $GTHOME/langs/crk/dev/missingnounlemmas
see $GTHOME/langs/crk/dev/missingnounlemmas