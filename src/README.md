How to use the alternative Makefile
===================================

Type this:

    make -j -f quick.mk

This will create _at least_ the following transducers (FSTs):

 - `crk-strict-analyzer.hfstol` — reads Plains Cree wordforms and
   outputs analyses. Wordforms must be written in _perfect_ [SRO].
 - `crk-relaxed-analyzer.hfstol` — reads Plains Cree wordforms, and
   outputs possible analyses. Wordforms can be written with known
   spelling variations, including long vowel relaxation. 😎🍹
 - `crk-strict-generator.hfstol` — given a morphological analyses,
   produces Plains Cree wordforms in SRO.
 - `crk-strict-generator-with-morpheme-boundaries.hfstol` same as
   above, but includes `<` and `>` to indicate morpheme boundaries

Want even _more_ FSTs? FSTs intended for use in _itwêwina_, the online
Cree dictionary? You got 'em! Type this:

   make -j -f quick.mk dict

Which will create two additional FSTs:

 - `crk-strict-analyzer-for-dictionary.hfstol`
 - `crk-relaxed-analyzer-for-dictionary.hfstol`

These are the same as their counterparts, except they exclude some
analyses that are unnecessary in a dictionary application.


Mini-glossary
-------------

### `crk`

The [ISO 639-3][] code for nêhiyawêwin, or Plains Cree.

[ISO 639-3]: https://en.wikipedia.org/wiki/ISO_639-3

### analyzer

An FST that takes in a form in a language and attempts to produce one or
more likely linguistic analyses.

The inverse of a **generator**.

### generator

An FST that takes an analysis string from the language and attempts to
produce a valid linguistic form.

The inverse of an **analyzer**.

### for dictionary

Intended for use with itwêwina, or really any intelligent dictionary for
Plains Cree.

In practice, this means analyzers lack the `+Err/Frag` analyses and omit
the `+Err/Orth` tag, since these offer little value to the dictionary
(it's trying to match a lemma, after all!).

### morpheme boundary

A mark that denotes where one meaningful sub-unit of a word is separated
from a different, adjacent part of the same word.

In Plains Cree, these marks are `<` and `>`. `<` occurs before the stem
of a verb, separating person marking to the left of it, and `>` is
placed immediately after the stem, separating the _other_ person
marking.

For example,

Given `wâpam` (stem of _wâpamêw_ (VTA)):

 - <wâpam>êw
 - ni<wâpam>âw
 - ki<wâpam>âw


### strict

Only produce or recognize text in a strict orthographical norm or
standard. In the case of Plains Cree, this means texts that adheres to
the [standard Roman orthography (SRO)][SRO].

Note: The itwêwina database of dictionary heads is internally stored in SRO.

Examples:

| Non-SRO    | SRO                      | Syllabics   |
|------------|--------------------------|-------------|
| atchakosuk | acâhkosak                | ᐊᐦᒐᐦᑯᓴᐠ     |
| neeyuh     | niya                     | ᓂᔭ          |
| nagee      | nakî                     | ᓇᑮ          |
| ewapamat   | ê-wâpamat _or_ ê-wâpamât | ᐁ ᐚᐸᒪᐟ      |

[SRO]: https://creeliteracy.org/wp-content/uploads/2016/01/htsiic-covers-nocontacts.pdf

### relaxed

(of an **analyzer**) it can take in forms that are not necessarily in
the strict internal. We apply _spelling relaxation_ such that we can
accept multiple possible spellings of words, and not require one exact
spelling of words. The spelling relaxation is done through a manually
maintained list of rules.
