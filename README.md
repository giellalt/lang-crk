The Plains Cree morphology and tools
====================================

[![Maturity](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgiellalt%2Flang-crk%2Fgh-pages%2Fmaturity.json)](https://giellalt.github.io/MaturityClassification.html)
![Lemma count](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgiellalt%2Flang-crk%2Fgh-pages%2Flemmacount.json)
[![GitHub issues](https://img.shields.io/github/issues-raw/giellalt/lang-crk)](https://github.com/giellalt/lang-crk/issues)
[![License](https://img.shields.io/github/license/giellalt/lang-crk)](https://github.com/giellalt/lang-crk/blob/main/LICENSE)
[![Doc Build Status](https://github.com/giellalt/lang-crk/workflows/Docs/badge.svg)](https://github.com/giellalt/lang-crk/actions)
[![CI/CD Build Status](https://divvun-tc.giellalt.org/api/github/v1/repository/giellalt/lang-crk/main/badge.svg)](https://divvun-tc.giellalt.org/api/github/v1/repository/giellalt/lang-crk/main/latest)

Download nightly / CI/CD zhfst files for testing:
[![Windows](https://img.shields.io/badge/download%40latest-Windows--bhfst-brightgreen)](https://pahkat.uit.no/main/download/speller-crk?platform=windows&channel=nightly)
[![MacOS](https://img.shields.io/badge/download%40latest-macOS--bhfst-brightgreen)](https://pahkat.uit.no/main/download/speller-crk?platform=macos&channel=nightly)
[![Mobile](https://img.shields.io/badge/download%40latest-mobile--bhfst-brightgreen)](https://pahkat.uit.no/main/download/speller-crk?platform=mobile&channel=nightly)

👉🏼 **[Download the latest FSTs here (plains-cree-fsts*.zip)][fst-release]** 👈🏼

[fst-release]: https://github.com/giellalt/lang-crk/releases

👉 [**Documentation**](https://giellalt.github.io/lang-crk/) 👈🏼

This repository contains finite state source files for the Plains Cree language,
for building morphological analysers, proofing tools
and dictionaries. The data and implementation are licenced under __LICENSE__
licence, also detailed in the
[LICENSE](https://github.com/giellalt/lang-crk/blob/main/LICENSE). The
authors named in the AUTHORS file are available to grant other licencing
choices.

Install proofing tools and [keyboards](https://github.com/giellalt/keyboard-crk)
for the Plains Cree language by using the [Divvun Installer](http://divvun.no)
(some languages are only available via the nightly channel).

Download and test speller files
-------------------------------

The speller files downloadable at the top of this page (the `*.bhfst` files) can
be used with [divvunspell](https://github.com/divvun/divvunspell), to test their
performance. These files are the exact same ones as installed on users' computers
and mobile phones. Desktop and mobile speller files differ from each other in the
error model and should be tested separately — thus also two different downloads.

Documentation
-------------

Documentation can be found at:

- [Language specific documentation](https://giellalt.github.io/lang-crk/)
- [General documentation](https://giellalt.github.io/)

Core dependencies
-----------------

In order to compile and use the Plains Cree language morphology and
dictionaries, you need:

- an FST compiler: [HFST](https://github.com/hfst/hfst), [Foma](https://github.com/mhulden/foma) or [Xerox Xfst](https://web.stanford.edu/~laurik/fsmbook/home.html)
- [VislCG3](https://visl.sdu.dk/svn/visl/tools/vislcg3/trunk) Constraint Grammar tools

To install VislCG3 and HFST, just copy/paste this into your Terminal on **macOS**:

```
curl https://apertium.projectjj.com/osx/install-nightly.sh | sudo bash
```

or terminal on **Ubuntu, Debian or Windows Subsystem for Linux**:

```
wget https://apertium.projectjj.com/apt/install-nightly.sh -O - | sudo bash
sudo apt-get install cg3 hfst
```

or terminal on **RedHat, Fedora, CentOS or Windows Subsystem for Linux**:

```
wget https://apertium.projectjj.com/rpm/install-nightly.sh -O - | sudo bash
sudo dnf install cg3 hfst
```

Alternatively, the Apertium wiki has good instructions on how to [install the dependencies for Mac
OS X](https://wiki.apertium.org/wiki/Apertium_on_Mac_OS_X) and how to [install
the dependencies on
linux](https://wiki.apertium.org/wiki/Installation_of_grammar_libraries)

Further details and dependencies are described on the GiellaLT [Getting Started](https://giellalt.uit.no/infra/GettingStarted.html) pages.

Downloading
-----------

Using Git:
```
git clone https://github.com/giellalt/lang-crk
```

Using Subversion:
```
svn checkout https://github.com/giellalt/lang-crk.git/trunk lang-crk
```

Building and installation
-------------------------

[INSTALL](https://github.com/giellalt/lang-crk/blob/main/INSTALL)
describes the GNU build system in detail, but for most users it is the usual:

```sh
./autogen.sh # This will automatically clone or check out other GiellaLT dependencies
./configure
make
(as root) make install
```

Citing
------

<!-- Add language specific citation stuff here and to the CITATION.cff -->

If you use language data from more than one GiellaLT language, consider citing
[our LREC 2022 article on whole
infra](https://aclanthology.org/2022.lrec-1.125/):

> Linda Wiechetek, Katri Hiovain-Asikainen, Inga Lill Sigga Mikkelsen,
  Sjur Moshagen, Flammie Pirinen, Trond Trosterud, and Børre Gaup. 2022.
  *Unmasking the Myth of Effortless Big Data - Making an Open Source
  Multi-lingual Infrastructure and Building Language Resources from Scratch*.
  In Proceedings of the Thirteenth Language Resources and Evaluation Conference,
  pages 1167–1177, Marseille, France. European Language Resources Association.

If you use bibtex, following is as it is on ACL anthology:

```bibtex
@inproceedings{wiechetek-etal-2022-unmasking,
    title = "Unmasking the Myth of Effortless Big Data - Making an Open Source
    Multi-lingual Infrastructure and Building Language Resources from Scratch",
    author = "Wiechetek, Linda  and
      Hiovain-Asikainen, Katri  and
      Mikkelsen, Inga Lill Sigga  and
      Moshagen, Sjur  and
      Pirinen, Flammie  and
      Trosterud, Trond  and
      Gaup, B{\o}rre",
    booktitle = "Proceedings of the Thirteenth Language Resources and Evaluation
    Conference",
    month = jun,
    year = "2022",
    address = "Marseille, France",
    publisher = "European Language Resources Association",
    url = "https://aclanthology.org/2022.lrec-1.125",
    pages = "1167--1177"
}
```
