## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = morphology phonology filters phonetics hyphenation orthography syntax transcriptions tagsets .

####### Automake targets: ########

# Define target variables first, before assigning to them:
GT_ANALYSERS=
GT_GENERATORS=
ADDITIONAL_TARGETS=

#### Local modifications in *fst processing: ####
####
#### Copy the fallback targets, and rename them to the desired targets. Then:
#### Replace the 'cp' command (Xerox) / Prepend the hfst-invert command (Hfst -
#### remember to move the $<) with whatever you need to complete
#### the processing to get the final target transducer.
#### Remember to add the dependencies as well.
#### Also make sure that HFST and Xerox processing are the same.
####
#### If you add new transducers to be built, you need to add them to the
#### relevant variable, e.g.:
####
#### if CAN_HFST
#### GT_GENERATORS+=generator-oahpa-gt-norm.hfst
#### endif
####
#### NB!!!! The HFST targets should get a hyphen after 'analyser'/'generator'
#### respectively, to make the local targets minimally different from and
#### slightly more specific than the fallback targets. This is to avoid warnings
#### about duplicate targets. That is, the local targets should looke like:
####
#### analyser-%.hfst: analyser-%.tmp.hfst
#### generator-%.hfst: generator-%.tmp.hfst

##################################################################
#### BEGIN: Add local processing instructions BELOW this line ####
##################################################################

all-am: Makefile $(DATA) $(ADDITIONAL_TARGETS)

# The analyzer MUST be inverted.
analyser-%.fomabin: analyser-%.hfst
	$(AM_V_FST2FST)$(HFST_INVERT) -i $< \
		| $(HFST_FST2FST) $(HFST_FLAGS) --use-backend-format --foma - -o $*.txt
	$(AM_V_GZIP)$(GZIP) --force $*.txt
	$(AM_V_MV)mv $*.txt.gz $@

generator-%.fomabin: generator-%.hfst
	$(AM_V_FST2FST)$(HFST_FST2FST) $(HFST_FLAGS) \
		--use-backend-format --foma $< -o $*.txt
	$(AM_V_GZIP)$(GZIP) --force $*.txt
	$(AM_V_MV)mv $*.txt.gz $@

########################################################
#### Add language-specific transducer targets here: ####

#### Xerox transducers:
if CAN_XFST
GT_ANALYSERS+=
GT_GENERATORS+=
endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=analyser-gt-desc.fomabin
GT_GENERATORS+=generator-gt-norm.fomabin
endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=
GT_GENERATORS+=
endif # CAN_FOMA

#################################################
#### Add language-specific build rules here: ####

# Author: Eddie Antonio Santos <easantos@ualberta.ca>
# Date:   Wed Jul  4 10:44:11 MDT 2018 **
# Origin: https://gist.github.com/eddieantonio/a6f8f29ea66ce5c1d12679283a7d8f25

# The source analyser and generator FSTs are done entirely in Standard Roman
# Orthography (Latn).  However, we require Canadian Aboriginal syllabics
# versions of both. This Makefile converts SRO FSTs in the equivillent
# syllabics FSTs.
#
# analyser-gt-desc.Cans-to-Cans.hfstol
# : An analyzer that accepts input in Canadian Aboriginal syllabics
#   and produces a morphological analysis with its lemma also written in syllabics.
#   "Descriptive" means it is able to understand non-standard orthography.
#
# generator-gt-desc.Cans-to-Cans.hfstol
# : A generator that accepts a morphological analysis in Canadian Aboriginal syllabics,
#   and produces an orthographically correct surface form, also in syllabics.

if CAN_HFST
# Creates the target FST as $@ :=  $^[0] .o. $^[1]
HFSTCOMPOSE.RULE = $(HFST_COMPOSE) -F -o $@ \
        -1 $(word 1,$^) -2 $(word 2,$^)

# Orthographically "omnivorous" FST:
# Consumes input in SRO-Macron, SRO-Circumflex or syllabics, and produces an
# analysis with lemmas in SRO-Circumflex.
#
# See: https://github.com/UAlbertaALTLab/itwewina/issues/43
ADDITIONAL_TARGETS+=analyser-gt-desc.omnivorous.hfstol
analyser-gt-desc.omnivorous.hfst: \
			orthography/Cans-to-Latn.compose.hfst \
			orthography/macron-to-circumfl.compose.hfst \
			analyser-gt-desc.hfst
	$(AM_V_COMPOSE)$(HFST_COMPOSE) -F -o $@ \
		-1 $(word 1,$^) \
		-2 $(word 2,$^) -o - \
		| $(HFST_COMPOSE) -F -1 - -2 $(word 3, $^) -o - \
		| $(HFST_MINIMIZE) --encode-weights -i - -o $@

# Cans-to-Cans FSTs -- FSTs whose "internal representation" is in syllabics.
ADDITIONAL_TARGETS+=analyser-gt-desc.Cans-to-Cans.hfstol
analyser-gt-desc.Cans-to-Cans.hfst: \
			analyser-gt-desc.omnivorous.hfst \
			orthography/Latn-to-Cans.compose.hfst
	$(AM_V_COMPOSE)$(HFSTCOMPOSE.RULE)

ADDITIONAL_TARGETS+=generator-gt-norm.Cans-to-Cans.hfstol
generator-gt-norm.Cans-to-Cans.hfst: \
			orthography/Cans-to-Latn.compose.hfst \
			generator-gt-norm.hfst \
			orthography/Latn-to-Cans.compose.hfst
	$(AM_V_COMPOSE)$(HFST_COMPOSE) -F \
		-1 orthography/Cans-to-Latn.compose.hfst \
		-2 generator-gt-norm.hfst -o - \
		| $(HFST_COMPOSE) -F \
		-1 - -2 orthography/Latn-to-Cans.compose.hfst -o $@

# Macr-to-Macr FSTs --FSTs whose "internal representation" is in macrons.
# See: https://github.com/UAlbertaALTLab/itwewina/issues/41#issuecomment-419189272
ADDITIONAL_TARGETS+=analyser-gt-desc.Macr-to-Macr.hfstol
analyser-gt-desc.Macr-to-Macr.hfst: \
			analyser-gt-desc.omnivorous.hfst \
			orthography/circumfl-to-macron.compose.hfst
	$(AM_V_COMPOSE)$(HFSTCOMPOSE.RULE)

ADDITIONAL_TARGETS+=generator-gt-norm.Macr-to-Macr.hfstol
generator-gt-norm.Macr-to-Macr.hfst: \
			orthography/macron-to-circumfl.compose.hfst \
			generator-gt-norm.hfst \
			orthography/circumfl-to-macron.compose.hfst
	$(AM_V_COMPOSE)$(HFST_COMPOSE) -F \
		-1 orthography/macron-to-circumfl.compose.hfst \
		-2 generator-gt-norm.hfst -o - \
		| $(HFST_COMPOSE) -F -1 - \
		-2 orthography/circumfl-to-macron.compose.hfst \
		-o $@

endif # CAN_HFST


##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/am-shared/src-dir-include.am
