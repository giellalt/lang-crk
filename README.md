The Plains Cree morphology and tools
====================================

[![GitHub issues](https://img.shields.io/github/issues-raw/giellalt/lang-crk)](https://github.com/giellalt/lang-crk/issues)
[![Build Status](https://github.com/giellalt/lang-crk/workflows/Speller%20CI+CD/badge.svg)](https://github.com/giellalt/lang-crk/actions)
[![License](https://img.shields.io/github/license/giellalt/lang-crk)](https://raw.githubusercontent.com/giellalt/lang-crk/main/LICENSE)

👉🏼 **[Download the latest FSTs here (plains-cree-fsts*.zip)][fst-release]** 👈🏼

[fst-release]: https://github.com/giellalt/lang-crk/releases

👉 [**Documentation**](https://giellalt.github.io/lang-crk/) 👈🏼


This repository contains finite state source files for the Plains Cree language,
for building morphological analysers, proofing tools
and dictionaries. The data and implementation are licenced under __LICENCE__
licence, also detailed in the
[LICENSE](https://github.com/giellalt/lang-crk/blob/main/LICENSE). The
authors named in the AUTHORS file are available to grant other licencing
choices.

Installation and compilation, and a short note on usage, is documented
in the file INSTALL.

Documentation
-------------

Documentation can be found here:

- [In source documentation generated with github
   pages](https://gilellalt.github.io/lang-crk/)
-   <https://giellalt.github.io/lang-crk/> (analyser)
-   <https://giellalt.github.io/> (infrastructure)

Core dependencies
-----------------

In order to compile and use the Plains Cree language morphology and
dictionaries, you need:

- an FST compiler: [HFST](https://github.com/hfst/hfst), [Foma](https://github.com/mhulden/foma) or [Xerox Xfst](https://web.stanford.edu/~laurik/fsmbook/home.html)
- [VislCG3](https://visl.sdu.dk/svn/visl/tools/vislcg3/trunk) Constraint Grammar tools

To install VislCG3 and HFST, just copy/paste this into your Terminal on **Mac OS X**:

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
