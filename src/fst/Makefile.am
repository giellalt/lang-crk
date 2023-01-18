## Process this file with automake to produce Makefile.in

## Copyright (C) 2011 Samediggi

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Add language-specific flags for hfst-lexc compilation here:
if HAVE_SHARED_COMMON
HFST_LEXC_LOCAL_FLAGS=  # --Werror # uncomment if lexc is good enough
else
HFST_LEXC_LOCAL_FLAGS=  # No --Werror if deps are missing !
endif


####### Morphology source file defs: ########

# Set this to name of lexc file containing Multichar_Symbols and LEXICON Root
GT_LEXC_ROOT=$(srcdir)/root.lexc

# Set this to the names of all regular lexc source files:
GT_LEXC_SRCS_L1_L2=\
					affixes/noun_affixes.lexc \
					affixes/verb_affixes.lexc \
					stems/noun_stems.lexc \
					stems/noun_vocatives.lexc \
					stems/numerals.lexc   \
					stems/verb_stems.lexc \
					stems/pronouns.lexc   \
					stems/particles.lexc  \
					stems/non_standard.lexc  \
					stems/derivation_stems.lexc

# As defined in ../morphological-fst-sources.mk + affixes/symbols.lexc & stems/crk-propernouns.lexc
EXTRA_MORPHOLOGY = \
					affixes/propernouns.lexc \
					affixes/symbols.lexc  \
					generated_files/eng-crk-propernouns.lexc \
					generated_files/punctuation.lexc \
					generated_files/symbols.lexc \
					stems/abbreviations.lexc \
					stems/crk-propernouns.lexc \
					stems/derivation_stems.lexc \
					stems/numeral_symbols.lexc

# If you are building an error-detecting L2 analyser, specify the lexc files
# that differ between the regular L1 and the L2 analysers below, in L1 and
# L2 respectively. L2 files must end in "*-L2.lexc". See SME for an example.
L1=

L2=

GT_LEXC_SRCS=\
			$(GT_LEXC_SRCS_L1_L2) \
			$(L1)

GT_LEXC_L2_SRCS=\
			$(GT_LEXC_SRCS_L1_L2) \
			$(L2)

# Set this to the names of all generated lexc files, if any
GENERATED_LEXC_SRCS=
#					generated_files/eng-$(GTLANG)-propernouns.lexc
#					generated_files/punctuation.lexc
#					generated_files/symbols.lexc

# change handling of shared lexical data here:
if HAVE_SHARED_COMMON
url.tmp.lexc: $(gt_SHARED_common)/src/fst/url.lexc
	$(AM_V_CP)cp -f $< $@

generated_files/mul-$(GLANG)-%.lexc: $(gt_SHARED_common)/src/fst/stems/%.lexc
	$(AM_V_at)$(MKDIR_P) generated_files
	$(AM_V_CP)cp -f $< $@
else
# this is "safe" fallback (compiles but you miss everything)
url.tmp.lexc:
	echo "LEXICON Root" > $@
	echo "< h t t p (s) %: %/ %/ ?*> # ;" >> $@

generated_files/mul-$(GLANG)-%.lexc:
	$(AM_V_at)$(MKDIR_P) generated_files
	echo "! Missing shared common data" > $@
endif
# add other lexical shared data handling here



# Set this to the names of all source xml files, if any
GT_XML_SRCS=

# Define any additional lexc sources here (compiled on their own):
GT_LOCAL_SRCS=

# Define local xfscripts here:
GT_LOCAL_XFSCRIPT_SRCS=

# Define here any additional sources just included in the distro:
GT_DISTRO_SRCS=stems/$(GTLANG)-propernouns.lexc

### BEGIN: Local processing: ###

### List additional targets in the following variable, for build targets not
### covered by other means. This comes ***in addition to*** what you can do by
### just targeting lexicon.*: lexicon.tmp.*, and is useful if you want to build
### separate fst's that need further treatment in the src/ dir. See the language
### gle/ for an example of how this is used.

GIELLA_LOCAL_TARGETS=

generated_files/eng-propernouns.lexc: \
			$(GIELLA_SHARED)/eng/src/fst/stems/eng-propernouns.lexc
	$(AM_V_at)$(MKDIR_P) generated_files
	$(AM_V_GEN)cp -f $< $@

generated_files/eng-$(GTLANG)-propernouns.lexc: \
		generated_files/eng-propernouns.lexc \
		$(srcdir)/stems/$(GTLANG)-propernouns.lexc
	$(AM_V_GEN)rm -f $@ && \
	cp -f $(srcdir)/stems/$(GTLANG)-propernouns.lexc $@ && \
	echo "" >> $@ && \
	echo "! <--- Dump from ENG -->" >> $@ && \
	echo "" >> $@ && \
	cat $< >> $@

### END: Local processing: ###

####### Other targets: ###########
# Clean: add local clean targets on separate lines, so that the first line can
# easily get updates from the template dir through svn merge.
clean-local:
	-rm -f *.all.* *fst *.foma *.script generated_files/*.lexc lexicon.*
	-rm -f url.lexc *.tmp*
	-rm -f *.relabel lexicon-tags.* lexicon-sigma.*

include $(srcdir)/Makefile.modifications-phon.am
include $(top_srcdir)/../giella-core/am-shared/src-morphology-dir-include.am

# vim: set ft=automake:
