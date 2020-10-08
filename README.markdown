The Plains Cree morphology and tools
====================================

👉🏼 **[Download the latest FSTs here (plains-cree-fsts*.zip)][fst-release]** 👈🏼

[fst-release]: https://github.com/giellalt/lang-crk/releases

This directory contains source files for the Plains Cree language
morphology and dictionary. The data and implementation are licenced
under \_\_LICENCE\_\_ licence also detailed in the LICENCE file of this
directory. The authors named in the AUTHORS file are available to grant
other licencing choices.

Installation and compilation, and a short note on usage, is documented
in the file INSTALL.

Documentation can be found here:

-   <https://giellalt.uit.no/crk/PlainsCreeDocumentation.html>
    (analyser)
-   <https://giellalt.uit.no/index.html> (infrastructure)

Requirements
------------

In order to compile and use Plains Cree language morphology and
dictionaries, you need:

-   Helsinki Finite-State Technology (HFST) library and tools, version
    3.8 or newer, or
-   Foma finite-state tool

Note that Xerox Finite-State Morphology tools (XFST) work incorrectly
with the latest implementation of morphophonological rules implemented
with TWOLC, whereas HFST works properly.

Note also that Foma will not work if using the TWOLC implementation of
the morphophonogical rules, as Foma does not include a TWOLC compiler.

Currently, we have implemented crk morphophonology using both TWOLC and
XFSCRIPT rewrite rules, and as of 2020-07-11 they are yet equivalent in
their workings.

Optionally:

-   VislCG3 Constraint Grammar tools

Downloading
-----------

The Plains Cree language sources can be acquired using [giella SVN
repository](https://giellalt.uit.no/infra/anonymous-svn.html), from the
language specific directory, after the core has been downloaded and
initial setup has been performed.

Installation
------------

INSTALL describes the GNU build system in detail. The following setup
will compile Plains Cree:

> ./configure \--without-xfst \--with-hfst make (as root) make install

This should result in a local installation and:

> (as root) make uninstall

in its uninstallation.

If you would rather install in e.g. your home directory (or aren\'t the
system administrator), you can tell ./configure:

    ./configure --prefix=$HOME

For other configuration options:

> ./configure -h

If you are checking out the development versions from SVN you must first
create and install the necessary autotools files from the host system,
and check that your environment is correctly set up. This is done by
doing:

> ./autogen.sh

It is common practice to keep [generated files out of version
control](http://www.gnu.org/software/automake/manual/automake.html#CVS).

VPATH builds
------------

If you want to keep the source code tree clean, a VPATH build is the
solution. The idea is to create a build dir somewhere outside of the
source code tree, and call [configure]{.title-ref} from there. Here is
one VPATH variant of the standard procedure:

```
 mkdir build && cd build
 ../configure
 make
 (as root) make install
```

This will keep all the generated files within the build/ dir, and keep
the src/ dir (mostly) free of generated files. If you are building from
the development version in SVN, you must run the ./autogen.sh script
BEFORE you take the steps above.

For further installation instruction refer to file `INSTALL`, which
contains the standard installation instructions for GNU autoconf based
software.
