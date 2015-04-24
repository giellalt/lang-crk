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

include $(top_srcdir)/am-shared/tools-spellcheckers-fstbased-hfst-dir-include.am

######### BEGIN: Local modifications for building the syllabic speller #########

GT_SYLLSPELLER_HFST=generator-fstspeller-gt-norm-syll.hfst
GT_SYLLSPELLER_ACCEPTOR=acceptor.syll.hfst

$(GT_SYLLSPELLER_HFST): $(GT_SPELLER_HFST) \
		$(top_builddir)/src/orthography/Latn-to-Cans.compose.hfst
	$(AM_V_GEN)$(HFST_COMPOSE_INTERSECT) $(HFST_FLAGS) \
		-1 $< \
		-2 $(top_builddir)/src/orthography/Latn-to-Cans.compose.hfst \
		| $(HFST_MINIMIZE) $(HFST_FLAGS) -o $@

####### Automake targets: ########

GT_SYLLERRMODELS=
if WANT_SPELLERS
if CAN_HFST
#GT_SYLLERRMODELS+=errmodel.edit-distance-1.hfst

# Only build speller if it is enabled (default=yes)
if WANT_SPELLERAUTOMAT
GT_SYLLERRMODELS+=errmodel.syll.hfst
# libvoikko can't yet handle multiple error models - do NOT include this line:
# errmodel.ocr.hfst

# Require zip to turn on zhfst target:
if WANT_VOIKKO
GT_SYLLSPELLING_HFST=$(GTLANG2)-Cans.zhfst
endif # WANT_VOIKKO
endif # WANT_SPELLERAUTOMAT
endif # CAN_HFST

if CAN_HFST
if WANT_VOIKKO
syllsharedir=$(libdir)/voikko/3/
#! @param GT_VOIKKO optional, set to spell checker automata names if
#!					installable
syllshare_DATA=$(GT_SYLLSPELLING_HFST)
endif # WANT_VOIKKO
endif # CAN_HFST
endif # WANT_SPELLERS

noinst_DATA+=$(GT_SYLLERRMODELS)

####### HFST build rules: ########

index.xml: index.Latn.xml
	$(AM_V_GEN)cp -f $< $@

# Error model building - edit distance based on transducer alphabet:
editdist.syll.hfst: editdist.syll.txt $(GT_SYLLSPELLER_ACCEPTOR)
	$(AM_V_GEN)$(GTCORE)/scripts/editdist.py -v -s -d 1 -e '@0@' -i $<   \
		-a $(GT_SYLLSPELLER_ACCEPTOR) \
		| $(HFST_TXT2FST) $(HFST_FLAGS) -e '@0@' -o $@

# Error model building - list of strings known to be misspelled:
strings.syll.hfst: strings.syll.txt anystar.hfst
	$(AM_V_GEN)grep -v '^#' $< | grep -v '^$$'   \
		| $(HFST_STRINGS2FST) $(HFST_FLAGS) -j \
		| $(HFST_CONCATENATE)   anystar.hfst - \
		| $(HFST_CONCATENATE) - anystar.hfst   \
		-o $@

# Combine edit distance with string pattern edits:
editStrings.syll.hfst: strings.syll.hfst editdist.syll.hfst
	$(AM_V_GEN)$(HFST_DISJUNCT) $^       \
		| $(HFST_MINIMIZE) $(HFST_FLAGS) \
		| $(HFST_REPEAT) -f 1 -t 2       \
		-o $@

# Error model building - list of words known to be misspelled:
words.syll.hfst: words.syll.txt easteregg.suggs.txt
	$(AM_V_GEN)grep -h -v '^#' $^ | grep -v '^$$'   \
		| $(HFST_STRINGS2FST) $(HFST_FLAGS) -j -o $@

# The final error model is assembled here:
errmodel.syll.hfst: words.syll.hfst editStrings.syll.hfst
	$(AM_V_GEN)$(HFST_DISJUNCT) $^ \
		| $(HFST_FST2FST) $(HFST_FLAGS) -f olw -o $@

# Alternatively, the error model can be constructed as a long list of regular
# expressions, semicolon separated:
#errmodel.syll.hfst: errmodel.syll.regex easteregg.suggs.hfst
#	$(AM_V_GEN)$(HFST_REGEXP2FST) $(HFSTFLAGS) -S -i $< \
#		| $(HFST_DISJUNCT) - easteregg.hfst \
#		-o $@

# Build the automaton used for the speller
$(GT_SYLLSPELLER_ACCEPTOR): $(GT_SYLLSPELLER_HFST) easteregg.hfst
	$(AM_V_GEN)cat $< \
		| $(HFST_PROJECT) $(HFST_FLAGS) --project=lower \
		| $(HFST_MINIMIZE) $(HFST_FLAGS)                \
		| $(HFST_DISJUNCT) - easteregg.hfst \
		| $(HFST_FST2FST) $(HFST_FLAGS) -f olw          \
		-o $@

# Finally build the zhfst file, and make a copy in a subdir named '3', so that
# we can test it without installing it (the '3' dir is a voikko requirement):
$(GT_SYLLSPELLING_HFST): $(srcdir)/index.Cans.xml \
					 $(GT_SYLLERRMODELS) \
					 $(GT_SYLLSPELLER_ACCEPTOR)
	$(AM_V_GEN)rm -f $@ && cp $(srcdir)/index.Cans.xml index.xml && \
		$(ZIP) $(ZIPFLAGS) $@ index.xml \
			$(GT_SYLLERRMODELS) $(GT_SYLLSPELLER_ACCEPTOR) && \
		$(MKDIR_P) 3 && \
		cp -f $@ 3/ && \
		rm -f index.xml

########## END: Local modifications for building the syllabic speller ##########

# vim: set ft=automake:
