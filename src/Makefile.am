## Process this file with automake to produce Makefile.in
## Copyright: Sámediggi/Divvun/UiT
## Licence: GPL v3+

# always build . last here, and tagsets have to be built after morphology
SUBDIRS = fst filters phonetics hyphenation orthography cg3 transcriptions tagsets .

####### Automake targets: ########

# Define target variables first, before assigning to them:
GT_ANALYSERS=
GT_GENERATORS=
CUSTOM_FSTS=

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

_RESET := $(shell tput sgr0)
_EMPH := $(shell tput setaf 6)
_DEEMPH := $(shell tput setaf 4)

########################################################
#### Add language-specific transducer targets here: ####

#### Xerox transducers:
if CAN_XFST
GT_ANALYSERS+=
GT_GENERATORS+=generator-gt-desc.borders.xfst

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=crk-strict-analyzer-giellaltbuild.xfst \
			 crk-strict-generator-giellaltbuild.xfst \
			 crk-relaxed-analyzer-giellaltbuild.xfst \
			 crk-strict-generator-with-morpheme-boundaries.xfst
endif # WANT_CUSTOM_FSTS

if WANT_DICTIONARIES
CUSTOM_FSTS+=crk-strict-analyzer-for-dictionary-giellaltbuild.xfst \
			 crk-relaxed-analyzer-for-dictionary-giellaltbuild.xfst \
			 generator-dict-gt-norm.boundaries.xfst \
			 analyser-dict-gt-desc.xfst
endif # WANT_DICTIONARIES

endif # CAN_XFST

#### HFST transducers
if CAN_HFST
GT_ANALYSERS+=
GT_GENERATORS+=generator-gt-desc.borders.hfstol

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=crk-strict-analyzer-giellaltbuild.hfstol \
			 crk-strict-generator-giellaltbuild.hfstol \
			 crk-relaxed-analyzer-giellaltbuild.hfstol \
			 crk-strict-generator-with-morpheme-boundaries-giellaltbuild.hfstol

if WANT_DICTIONARIES
CUSTOM_FSTS+=crk-strict-analyzer-for-dictionary-giellaltbuild.hfstol \
			 crk-relaxed-analyzer-for-dictionary-giellaltbuild.hfstol \
			 generator-dict-gt-norm.boundaries.hfstol \
			 analyser-dict-gt-desc.hfstol
endif # WANT_DICTIONARIES

endif # WANT_CUSTOM_FSTS

endif # CAN_HFST

#### FOMA transducers
if CAN_FOMA
GT_ANALYSERS+=
GT_GENERATORS+=generator-gt-desc.borders.foma

if WANT_CUSTOM_FSTS
CUSTOM_FSTS+=crk-strict-analyzer-giellaltbuild.foma \
			 crk-strict-generator-giellaltbuild.foma \
			 crk-relaxed-analyzer-giellaltbuild.foma \
			 crk-strict-generator-with-morpheme-boundaries.foma
endif # WANT_CUSTOM_FSTS

if WANT_DICTIONARIES
CUSTOM_FSTS+=crk-strict-analyzer-for-dictionary-giellaltbuild.foma \
			 crk-relaxed-analyzer-for-dictionary-giellaltbuild.foma \
			 generator-dict-gt-norm.boundaries.foma \
			 analyser-dict-gt-desc.foma
endif # WANT_DICTIONARIES

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

# Re quick.mk: crk-strict-generator-with-morpheme-boundaries.hfst = analyser-raw-gt-desc.hfst
crk-strict-generator-with-morpheme-boundaries-giellaltbuild.hfst  \
crk-strict-generator-with-morpheme-boundaries-giellaltbuild.xfst  \
crk-strict-generator-with-morpheme-boundaries-giellaltbuild.foma: \
crk-strict-generator-with-morpheme-boundaries-giellaltbuild.%: analyser-raw-gt-desc.%
	-@echo "$(_EMPH)Inverting Foma/Xfst analyzer to create the strict generator.$(_RESET)"
	$(AM_V_XFST_TOOL)$(PRINTF) "\
		 load stack $<\n\
		 $(INVERT_XFST)$(INVERT_FOMA)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

# Build crk-strict-analyzer, but with GiellaLT naming:
# Strict = descriptive (incl. Err/Orth) but NO spellrelax. Ie full lexicon only
analyser-gt-strict.hfst  \
analyser-gt-strict.xfst  \
analyser-gt-strict.foma: \
analyser-gt-strict.%: analyser-raw-gt-desc.% filters/remove-infl_boundary-marks.%
	-@echo "$(_EMPH)Removing morpheme boundaries to create strict analyzer.$(_RESET)"
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"$<\"                                           \
			.o. @\"filters/remove-infl_boundary-marks.$*\" \
			;\n\
		 minimise\n\
		 $(INVERT_HFST)\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)
# Rename above to Eddie name + extra, to differentiate from his name:
crk-strict-analyzer-giellaltbuild.%: analyser-gt-strict.%
	$(AM_V_MV)cp -f $< $@

# crk-strict-generator:
generator-gt-strict.hfst  \
generator-gt-strict.xfst  \
generator-gt-strict.foma: \
generator-gt-strict.%: analyser-gt-strict.%
	-@echo "$(_EMPH)Inverting the analyzer to create the strict generator.$(_RESET)"
	$(AM_V_XFST_TOOL)$(PRINTF) "\
		 load stack $<\n\
		 invert\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)
# Rename above to Eddie name + extra, to differentiate from his name:
crk-strict-generator-giellaltbuild.%: generator-gt-strict.%
	$(AM_V_MV)cp -f $< $@

# crk-relaxed-analyzer:
analyser-gt-relaxed.hfst  \
analyser-gt-relaxed.xfst  \
analyser-gt-relaxed.foma: \
analyser-gt-relaxed.%: analyser-gt-strict.% orthography/spellrelax.compose.%
	-@echo "$(_EMPH)Composing spelling relaxation transducer with normative analyzer to create descriptive analyzer.$(_RESET)"
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"orthography/spellrelax.compose.$*\".i \
			.o. @\"$<\"                                           \
			;\n\
		 minimise\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)
# Rename:
crk-relaxed-analyzer-giellaltbuild.%: analyser-gt-relaxed.%
	$(AM_V_MV)cp -f $< $@

crk-dict-filter.hfst: Makefile.am
	-@echo "$(_EMPH)Compiling filter to remove +Err/Frag strings, and omit +Err/Orth tags from analyses$(_RESET)"
	$(AM_V_RGX2FST)echo '~[ $$[ "+Err/Frag" ] ] .o. [ "+Err/Orth" -> 0 ] ; ' \
	| $(HFST_REGEXP2FST) $(MORE_VERBOSITY) --semicolon - -o $@

%-for-dictionary-giellaltbuild.hfst: %-giellaltbuild.hfst crk-dict-filter.hfst
	-@echo "$(_EMPH)Creating dictionary version of $<$(_RESET)"
	$(AM_V_COMPOSE)$(HFST_COMPOSE) $(MORE_VERBOSITY) --harmonize-flags -1 \
		$(word 1, $^) -2 $(word 2, $^) |\
		$(HFST_MINIMIZE) - -o $@

generator-dict-gt-norm.boundaries.hfst  \
generator-dict-gt-norm.boundaries.xfst  \
generator-dict-gt-norm.boundaries.foma: \
generator-dict-gt-norm.boundaries.%: analyser-raw-gt-desc.% \
									 filters/remove-error-strings.% \
									 filters/select-dict_POS-strings.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/select-dict_POS-strings.$*\" \
			.o. @\"filters/remove-error-strings.$*\" \
			.o. @\"$<\"                                           \
			;\n\
		 minimise\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

analyser-dict-gt-desc.hfst  \
analyser-dict-gt-desc.xfst  \
analyser-dict-gt-desc.foma: \
analyser-dict-gt-desc.%: analyser-raw-gt-desc.% \
						 filters/remove-error-tags.% \
						 filters/select-dict_POS-strings.% \
						 filters/remove-Err_Frag-strings.% \
						 filters/remove-CRK_der_border-symbol.% \
						 filters/remove-infl_boundary-marks.% \
						 orthography/spellrelax.compose.%
	$(AM_V_XFST_TOOL)$(PRINTF) "read regex \
				@\"filters/remove-error-tags.$*\" \
			.o. @\"filters/select-dict_POS-strings.$*\" \
			.o. @\"filters/remove-Err_Frag-strings.$*\" \
			.o. @\"$<\"                                           \
			.o. @\"filters/remove-infl_boundary-marks.$*\" \
			.o. @\"filters/remove-CRK_der_border-symbol.$*\" \
			.o. @\"orthography/spellrelax.compose.$*\" \
			;\n\
		 minimise\n\
		 save stack $@\n\
		 quit\n" | $(XFST_TOOL)

##################################################################
#### END: Add local processing instructions ABOVE this line ######
##################################################################

include $(top_srcdir)/../giella-core/am-shared/src-dir-include.am
