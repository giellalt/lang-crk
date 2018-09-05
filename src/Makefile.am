## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = phonology morphology filters phonetics hyphenation orthography syntax transcriptions tagsets .

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

########################################################
#### Add language-specific transducer targets here: ####

#### Xerox transducers:
if CAN_XFST
GT_ANALYSERS+=
GT_GENERATORS+=
endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=
GT_GENERATORS+=
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
ADDITIONAL_TARGETS+=analyser-gt-desc.Cans-to-Cans.hfstol
ADDITIONAL_TARGETS+=generator-gt-norm.Cans-to-Cans.hfstol

HFSTCOMPOSE.RULE = hfst-compose -F -o $@ -1 $(word 1,$^) -2 $(word 2,$^)

%.Cans-to-Latn.hfst: orthography/Cans-to-Latn.compose.hfst %.hfst 
	$(HFSTCOMPOSE.RULE)

%.Cans-to-Cans.hfst: %.Cans-to-Latn.hfst orthography/Latn-to-Cans.compose.hfst 
	$(HFSTCOMPOSE.RULE)
endif # CAN_HFST


##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/am-shared/src-dir-include.am
