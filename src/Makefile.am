## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = fst filters phonetics hyphenation orthography cg3 transcriptions tagsets .

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
GT_GENERATORS+=generator-gt-desc.borders.xfst
endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=
GT_GENERATORS+=generator-gt-desc.borders.hfst
endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=
GT_GENERATORS+=generator-gt-desc.borders.foma
endif # CAN_FOMA

#################################################
#### Add language-specific build rules here: ####

# This is the default, descriptive generating transducer.
generator-gt-desc.borders.xfst  \
generator-gt-desc.borders.hfst  \
generator-gt-desc.borders.foma: \
generator-gt-desc.borders.%: analyser-raw-gt-desc.%            \
					filters/make-optional-transitivity-tags.% \
					filters/make-optional-homonymy-tags.%     \
					filters/make-optional-hyph-tags.%         \
					filters/make-optional-variant-tags.%      \
					filters/make-optional-semantic-tags.%     \
					filters/make-optional-error-tags.%        \
					filters/make-optional-adv_comp-tags.%     \
					filters/make-optional-grammatical-tags.%  \
					filters/remove-area-tags.%                \
					filters/remove-dialect-tags.%             \
					filters/remove-hyphenation-marks.%        \
					filters/remove-infl_deriv-borders.%       \
					filters/remove-word-boundary.%            \
					filters/remove-number-string-tags.%       \
					filters/remove-orthography-tags.%         \
					filters/remove-Orth_IPA-strings.%         \
					filters/remove-usage-tags.%               \
					filters/remove-Use_GC-strings.%           \
					filters/remove-Use_minusGC-tags.%         \
					filters/remove-Use_minus_PMatch-tags.%    \
					filters/remove-Use_PMatch-strings.%       \
					filters/remove-mwe-tags.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/make-optional-transitivity-tags.$*\" \
			.o. @\"filters/make-optional-homonymy-tags.$*\"     \
			.o. @\"filters/make-optional-hyph-tags.$*\"         \
			.o. @\"filters/make-optional-variant-tags.$*\"      \
			.o. @\"filters/make-optional-semantic-tags.$*\"     \
			.o. @\"filters/make-optional-error-tags.$*\"        \
			.o. @\"filters/make-optional-adv_comp-tags.$*\"     \
			.o. @\"filters/make-optional-grammatical-tags.$*\"  \
			.o. @\"filters/remove-area-tags.$*\"                \
			.o. @\"filters/remove-dialect-tags.$*\"             \
			.o. @\"filters/remove-number-string-tags.$*\"       \
			.o. @\"filters/remove-usage-tags.$*\"               \
			.o. @\"filters/remove-orthography-tags.$*\"         \
			.o. @\"filters/remove-Orth_IPA-strings.$*\"         \
			.o. @\"filters/remove-Use_minus_PMatch-tags.$*\"    \
			.o. @\"filters/remove-Use_GC-strings.$*\"           \
			.o. @\"filters/remove-Use_minusGC-tags.$*\"         \
			.o. @\"filters/remove-Use_PMatch-strings.$*\"       \
			.o. @\"filters/remove-mwe-tags.$*\"                 \
			.o. @\"$<\" \
			;\n\
		 $(INVERT_XFST)$(INVERT_FOMA)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

generator-gt-desc.borders.Cans.xfst  \
generator-gt-desc.borders.Cans.hfst  \
generator-gt-desc.borders.Cans.foma: \
generator-gt-desc.borders.Cans.%: analyser-raw-gt-desc.%           \
					filters/make-optional-transitivity-tags.%  \
					filters/make-optional-homonymy-tags.%      \
					filters/make-optional-hyph-tags.%          \
					filters/make-optional-variant-tags.%       \
					filters/make-optional-semantic-tags.%      \
					filters/make-optional-error-tags.%         \
					filters/make-optional-adv_comp-tags.%      \
					filters/make-optional-grammatical-tags.%   \
					filters/remove-area-tags.%                 \
					filters/remove-dialect-tags.%              \
					filters/remove-number-string-tags.%        \
					filters/remove-orthography-tags.%          \
					filters/remove-Orth_IPA-strings.%          \
					filters/remove-orig_lang-tags.%            \
					filters/remove-usage-tags.%                \
					filters/remove-Use_minusGC-tags.%          \
					filters/remove-Use_GC-strings.%            \
					filters/remove-Use_minus_PMatch-tags.%     \
					filters/remove-Use_PMatch-strings.%        \
					filters/remove-mwe-tags.%                  \
					orthography/$(DEFAULT_WS)-to-Cans.compose.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/make-optional-transitivity-tags.$*\"   \
			.o. @\"filters/make-optional-homonymy-tags.$*\"       \
			.o. @\"filters/make-optional-hyph-tags.$*\"           \
			.o. @\"filters/make-optional-variant-tags.$*\"        \
			.o. @\"filters/make-optional-semantic-tags.$*\"       \
			.o. @\"filters/make-optional-error-tags.$*\"          \
			.o. @\"filters/make-optional-adv_comp-tags.$*\"       \
			.o. @\"filters/make-optional-grammatical-tags.$*\"    \
			.o. @\"filters/remove-area-tags.$*\"                  \
			.o. @\"filters/remove-dialect-tags.$*\"               \
			.o. @\"filters/remove-number-string-tags.$*\"         \
			.o. @\"filters/remove-usage-tags.$*\"                 \
			.o. @\"filters/remove-orig_lang-tags.$*\"             \
			.o. @\"filters/remove-orthography-tags.$*\"           \
			.o. @\"filters/remove-Orth_IPA-strings.$*\"           \
			.o. @\"filters/remove-Use_minus_PMatch-tags.$*\"      \
			.o. @\"filters/remove-Use_minusGC-tags.$*\"           \
			.o. @\"filters/remove-Use_GC-strings.$*\"             \
			.o. @\"filters/remove-Use_PMatch-strings.$*\"         \
			.o. @\"filters/remove-mwe-tags.$*\"                   \
			.o. @\"$<\"                                           \
			.o. @\"orthography/$(DEFAULT_WS)-to-Cans.compose.$*\" \
			;\n\
		 $(INVERT_XFST)$(INVERT_FOMA)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

generator-gt-desc.borders.macron.xfst  \
generator-gt-desc.borders.macron.hfst  \
generator-gt-desc.borders.macron.foma: \
generator-gt-desc.borders.macron.%: analyser-raw-gt-desc.%           \
					filters/make-optional-transitivity-tags.%  \
					filters/make-optional-homonymy-tags.%      \
					filters/make-optional-hyph-tags.%          \
					filters/make-optional-variant-tags.%       \
					filters/make-optional-semantic-tags.%      \
					filters/make-optional-error-tags.%         \
					filters/make-optional-adv_comp-tags.%      \
					filters/make-optional-grammatical-tags.%   \
					filters/remove-area-tags.%                 \
					filters/remove-dialect-tags.%              \
					filters/remove-number-string-tags.%        \
					filters/remove-orthography-tags.%          \
					filters/remove-Orth_IPA-strings.%          \
					filters/remove-orig_lang-tags.%            \
					filters/remove-usage-tags.%                \
					filters/remove-Use_minusGC-tags.%          \
					filters/remove-Use_GC-strings.%            \
					filters/remove-Use_minus_PMatch-tags.%     \
					filters/remove-Use_PMatch-strings.%        \
					filters/remove-mwe-tags.%                  \
					orthography/$(DEFAULT_ORTH)-to-macron.compose.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/make-optional-transitivity-tags.$*\"   \
			.o. @\"filters/make-optional-homonymy-tags.$*\"       \
			.o. @\"filters/make-optional-hyph-tags.$*\"           \
			.o. @\"filters/make-optional-variant-tags.$*\"        \
			.o. @\"filters/make-optional-semantic-tags.$*\"       \
			.o. @\"filters/make-optional-error-tags.$*\"          \
			.o. @\"filters/make-optional-adv_comp-tags.$*\"       \
			.o. @\"filters/make-optional-grammatical-tags.$*\"    \
			.o. @\"filters/remove-area-tags.$*\"                  \
			.o. @\"filters/remove-dialect-tags.$*\"               \
			.o. @\"filters/remove-number-string-tags.$*\"         \
			.o. @\"filters/remove-usage-tags.$*\"                 \
			.o. @\"filters/remove-orig_lang-tags.$*\"             \
			.o. @\"filters/remove-orthography-tags.$*\"           \
			.o. @\"filters/remove-Orth_IPA-strings.$*\"           \
			.o. @\"filters/remove-Use_minus_PMatch-tags.$*\"      \
			.o. @\"filters/remove-Use_minusGC-tags.$*\"           \
			.o. @\"filters/remove-Use_GC-strings.$*\"             \
			.o. @\"filters/remove-Use_PMatch-strings.$*\"         \
			.o. @\"filters/remove-mwe-tags.$*\"                   \
			.o. @\"$<\"                                           \
			.o. @\"orthography/$(DEFAULT_ORTH)-to-macron.compose.$*\" \
			;\n\
		 $(INVERT_XFST)$(INVERT_FOMA)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/../giella-core/am-shared/src-dir-include.am
