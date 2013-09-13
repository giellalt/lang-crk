## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

####### Source file defs: ########

# set this to names of available orthographic rules in regex and xfst format
GT_ORTHOGRAPHIC_SRCS=inituppercase.regex \
					 allcaps.xfscript    \
					 spellrelax.regex    \
					 spellrelax-mobile-keyboard.regex

####### Automake targets: ########

GT_ORTHOGRAPHIC_FSTS=
if CAN_HFST
GT_ORTHOGRAPHIC_FSTS+=allcaps.hfst \
					  inituppercase.hfst \
					  spellrelax.hfst \
					  spellrelax-mobile-keyboard.hfst
endif
if CAN_XFST
GT_ORTHOGRAPHIC_FSTS+=allcaps.xfst \
					  inituppercase.xfst \
					  spellrelax.xfst \
					  spellrelax-mobile-keyboard.xfst
endif

####### Local source files: ########

GT_ORTHOGRAPHIC_SRCS+=latin2syllabics.xfscript

####### Local targets: ########

if CAN_HFST
#GT_ORTHOGRAPHIC_FSTS+=latin2syllabics.hfst
endif

if CAN_XFST
GT_ORTHOGRAPHIC_FSTS+=latin2syllabics.xfst
endif

# Orthography transformation as xfst script:
.xfscript.xfst:
	$(AM_V_GEN)$(XFST) -l $< -e "save stack $@" -stop


####### END Local targets ########

include $(top_srcdir)/am-shared/orthography-include.am

