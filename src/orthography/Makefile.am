## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

####### Source file defs: ########

# set this to names of available orthographic rules in regex and xfst format
GT_ORTHOGRAPHIC_SRCS=inituppercase.regex \
					 allcaps.xfscript    \
					 spellrelax.regex    \
					 spellrelax-mobile-keyboard.regex \
					 downcase-derived_proper-strings.xfscript

####### Automake targets: ########

GT_ORTHOGRAPHIC_FSTS=
if CAN_HFST
GT_ORTHOGRAPHIC_FSTS+=allcaps.hfst \
					  inituppercase.hfst \
					  spellrelax.hfst \
					  spellrelax-mobile-keyboard.hfst \
					  downcase-derived_proper-strings.hfst
endif
if CAN_XFST
GT_ORTHOGRAPHIC_FSTS+=allcaps.xfst \
					  inituppercase.xfst \
					  spellrelax.xfst \
					  spellrelax-mobile-keyboard.xfst \
					  downcase-derived_proper-strings.xfst
endif

####### Local source files: ########

GT_ORTHOGRAPHIC_SRCS+=syllabics2latin.xfscript

####### Local targets: ########

if CAN_HFST
GT_ORTHOGRAPHIC_FSTS+=syllabics2latin.hfst \
					  latin2syllabics.hfst
endif

if CAN_XFST
GT_ORTHOGRAPHIC_FSTS+=syllabics2latin.xfst \
					  latin2syllabics.xfst
endif

####### END Local targets ########

# This pattern rule is required to block inversion of the xfscript fst's.
# We do want inversion in the general case, but not for the orthographic fst's.
%s.hfst: %s.tmp.hfst
	$(AM_V_GEN)cp -f $< $@

%s.xfst: %s.tmp.xfst
	$(AM_V_GEN)cp -f $< $@

include $(top_srcdir)/am-shared/src-orthography-dir-include.am
