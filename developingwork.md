# How to evaluate the output of the FST, as a part of the developing work
Here are some tips for the linguist, all commands are based on working in the crk-catalogue

## Make an alias to the crk-catalog

Add this to your .bashrc or .profile: 
```
alias crk="pushd ~/main/langs/crk" 
```

Open a new terminal window: In any catalogue, write 'crk' ENTER.

## Test that all noun lemmas are possible to generate as base form
```
sh test/data/testnounlemmas.sh
```

## Look at fst-output

###  A certain form for all lemmas
The example is for animate nouns, all the continuation lexicons for these nouns start with AN
```
grep ' AN' src/fst/stems/nouns.lexc |\
egrep -v '^(\!|LEX)' | tr ":" " " | cut -d " " -f1 |\
sed 's/$/+N+AN+Loc/' | dcrk | less
```

###  The paradigm for a certain lemma
The example is for an inanimate noun, but one can use any of the paradigms in the test/data-catalogue
```
cat test/data/NI-par.txt | sed 's/^/ôtênaw/' | dcrk | less
```

## Run only one yaml-test
Remove all yamltests (check in your local modifications first!):

```
rm test/src/gt-norm-yamls/*
```
Get the yaml-file you want to test, e.g.: 
```
svn up test/src/gt-norm-yamls/V-mato_gt-norm.yaml
make check
```

## Compare the lingvistic output of all yaml-tests for a certain PoS
Remove all yamltests (check in your local modifications first!) - the example is for verbs:
```
rm test/src/gt-norm-yamls/*
```

Get the yaml-file you want to test, e.g.: 
```
svn up test/src/gt-norm-yamls/U-all_gt-norm.yaml
```

make check

## Make/update all yaml-tests in one for a certain PoS (and a certain pattern?)
This example is adding all verbs into one file:
```
head -11 test/src/gt-norm-yamls/V-AI-matow_gt-norm.yaml > test/src/gt-norm-yamls/U-all_gt-norm.yaml
tail +11 test/src/gt-norm-yamls/V* | grep -v "==" >> test/src/gt-norm-yamls/U-all_gt-norm.yaml```

This example is adding all nouns with final -y into one file:
```
head -11 test/src/gt-norm-yamls/N-AN-amisk_gt-norm.yaml > test/src/gt-norm-yamls/A-Ny-all_gt-norm.yaml 
tail +11 test/src/gt-norm-yamls/N*y_gt-norm.yaml | grep -v "==" >>  test/src/gt-norm-yamls/A-Ny-all_gt-norm.yaml
```

##  Make a new yaml-file
The example is for the inanimate noun ôtênaw. Use an already functioning yaml-file as a starting point (here N-AN-amiskw_gt-norm.yaml). You still have to do a little editing afterwords, like correcting the docu about the lemma, and making it more readable by adding empty lines. And you must of course correct the output. 

```
head -12 test/src/gt-norm-yamls/N-AN-amisk_gt-norm.yaml\
> test/src/gt-norm-yamls/N-IN-otenaw_gt-norm.yaml

cat test/data/NI-par.txt | sed 's/^/ôtênaw/' | dcrk |\
tr '\t' ':' | sed 's/:/: /' | grep -v '^$' |\
sed 's/^/     /' >> test/src/gt-norm-yamls/N-IN-otenaw_gt-norm.yaml
```

Comment: The last sed-command should give 5 whitespaces

##  Documentation on unix-commands
* [Unix for linguists](/tools/docu-unix.html)
* [Some unix commands explained, with examples, and example files, but in Saami](/tools/unix_korpus_kursa.html)
* [Basic unix-commands, external link](http://mally.stanford.edu/~sr/computing/basic-unix.html)
* [More fun with sort, external link](http://www.softpanorama.org/Tools/sort.shtml)
* [awk can be useful too, external link](http://www.softpanorama.org/Tools/awk.shtml)
