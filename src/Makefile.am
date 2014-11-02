## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = phonology morphology filters phonetics hyphenation orthography syntax transcriptions tagsets .

####### Automake targets: ########

# Define target variables first, before assigning to them:
GT_ANALYSERS_HFST=
GT_GENERATORS_HFST=
GT_ANALYSERS_XFST=
GT_GENERATORS_XFST=

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
#### GT_GENERATORS_HFST+=generator-oahpa-gt-norm.hfst
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

########################################################
#### Add language-specific transducer targets here: ####

#### Xerox transducers:
if CAN_XFST
# Transducers using syllabic writing system
GT_ANALYSERS_XFST+=analyser-gt-desc-syll.xfst
GT_GENERATORS_XFST+=generator-gt-norm-syll.xfst
endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS_HFST+=analyser-gt-desc-syll.hfst
GT_GENERATORS_HFST+=generator-gt-norm-syll.hfst
endif # CAN_HFST


#################################################
#### Add language-specific build rules here: ####

analyser-gt-desc-syll.hfst: analyser-gt-desc.tmp.hfst \
							orthography/syllabics2latin.compose.hfst
	$(AM_V_GEN)$(HFST_COMPOSE) $(HFST_FLAGS) -F -1 $< \
			-2 orthography/syllabics2latin.compose.hfst \
		| $(HFST_MINIMIZE) $(HFST_FLAGS) \
		| $(HFST_INVERT) $(HFST_FLAGS)\
		-o $@

generator-gt-norm-syll.hfst: generator-gt-norm.tmp.hfst \
							 orthography/latin2syllabics.compose.hfst
	$(AM_V_GEN)$(HFST_INVERT) $(HFST_FLAGS) \
			orthography/latin2syllabics.compose.hfst \
		| $(HFST_COMPOSE) $(HFST_FLAGS) -F -1 $< \
		| $(HFST_MINIMIZE) $(HFST_FLAGS) \
		-o $@

analyser-gt-desc-syll.xfst: analyser-gt-desc.xfst \
							orthography/latin2syllabics.lookup.xfst
	$(AM_V_GEN)$(PRINTF) "read regex \
			    @\"$<\" \
			.o. @\"orthography/latin2syllabics.lookup.xfst\".i        \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST) -q

generator-gt-norm-syll.xfst: generator-gt-norm.xfst \
							 orthography/latin2syllabics.lookup.xfst
	$(AM_V_GEN)$(PRINTF) "read regex \
			    @\"orthography/latin2syllabics.lookup.xfst\"        \
			.o. @\"$<\" \
			;\n\
		 save stack $@\n\
		 quit\n" | $(XFST) -q

##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

#### HFST transducer fallback target:
#### - inversion is needed FOR THE ANALYSER because the hfst model is upside
#### down compared to Xerox AT APPLICATION TIME. The other command makes the
#### final transducer ready for use.
analyser%.hfst: analyser%.tmp.hfst
	$(AM_V_INVERT)$(HFST_INVERT) -i $< -o $@

generator%.hfst: generator%.tmp.hfst
	$(AM_V_CP)cp -f $< $@

#### Xerox transducer fallback target:
%.xfst: %.tmp.xfst
	$(AM_V_CP)cp -f $< $@

include $(top_srcdir)/am-shared/src-dir-include.am
