grep ";" $GTHOME/langs/crk/src/morphology/stems/nouns.lexc |egrep -v '^(<|\!|@|AN|IN|IR)' | tr ':+' ' ' | cut -d ' ' -f1 | sort -u | grep -v "^$" > $GTHOME/langs/crk/lemmas.txt
grep ";" $GTHOME/langs/crk/src/morphology/stems/nouns.lexc |egrep -v '^(<|\!|@|AN|IN|IR)' | grep ' IN' |tr ':+' ' ' | cut -d ' ' -f1 | grep -v "^$" |sed 's/$/+N+IN+Sg/' |$HLOOKUP $GTHOME/langs/crk/src/generator-gt-norm.hfst | cut -f2 | grep -v "^$" |sort -u > $GTHOME/langs/crk/anlemmas.txt
grep ";" $GTHOME/langs/crk/src/morphology/stems/nouns.lexc |egrep -v '^(<|\!|@|AN|IN|IR)' | egrep ' (AN|IRREGULARDECL)' |tr ':+' ' ' | cut -d ' ' -f1 | grep -v "^$" |sed 's/$/+N+AN+Sg/' |$HLOOKUP $GTHOME/langs/crk/src/generator-gt-norm.hfst | cut -f2 | grep -v "^$" |sort -u >> $GTHOME/langs/crk/anlemmas.txt
grep ";" $GTHOME/langs/crk/src/morphology/stems/nouns.lexc |egrep -v '^(<|\!|@|AN|IN|IR)' | egrep 'N\+IN\+Sg\+Px3Sg' |tr ':+' ' ' | cut -d ' ' -f1 | grep -v "^$" |sed 's/$/+N+IN+Sg+Px3Sg/' |$HLOOKUP $GTHOME/langs/crk/src/generator-gt-norm.hfst | cut -f2 | grep -v "^$" |sort -u >> $GTHOME/langs/crk/anlemmas.txt
sort -u -o $GTHOME/langs/crk/anlemmas.txt $GTHOME/langs/crk/anlemmas.txt
comm -23 $GTHOME/langs/crk/lemmas.txt $GTHOME/langs/crk/anlemmas.txt > $GTHOME/langs/crk/failedlemmas.txt
see $GTHOME/langs/crk/failedlemmas.txt


