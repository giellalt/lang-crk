"make check" does both lemma generation tests and yaml-tests

The lemma generation tests have to be listed in the file: \\
test/src/fst/Makefile.am like this:
```
GENERATION_TESTS_IN=generate-noun-lemmas.sh.in  \
                    generate-verb-lemmas.sh.in
```

The script puts all lemmas in one file, \\ 
then it generates their baseforms in another file (N+AN+Sg, N+IN+Sg, plural forms if the lemma is in plural,\\ or for verbs: Ind+Prs+3Sg, for plural verbs: Ind+Prs+3Pl), \\ and then it compares these two files. \\
To get this to function properly, the names of the continuation lexicons have go be consistent\\ starting with AN, IN, TA, II, AI, TI, and with PL in the name for the plural lemmas.

Dependent nouns, which lemmas have initial hyphen: \\
Instead of the lemma, the script uses forms added as comment in stems file, marked with ¢.\\
An then the script compares these with generated forms: N+AN+Sg+Px1Sg1 or N+IN+Sg+Px1Sg1 

The lemmas which are not generated correctly, are added to the files: \\
missingnouns.txt and missingverbs.txt
