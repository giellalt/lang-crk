# Copyright © 2019 Alberta Language Technology Lab (ALTLab)
# http://altlab.artsrn.ualberta.ca/
#
# This program is free software; you can redistribute and/or modify
# this file under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# Rules to create morphological Cree FSTs
#
# Derived from ../inc/crk-dict.sh

_RESET := $(shell tput sgr0)
_EMPH := $(shell tput setaf 6)
_DEEMPH := $(shell tput setaf 4)

WEIGHT_FORMAT=--format=openfst-tropical
ifeq ($(V), 0)
VERBOSITY=--silent
else
VERBOSITY=--verbose
endif

# Concatenate all the loose .lexc files into one big Lexc file.
crk-dict.lexc: $(MORPHOLOGY)
	-@echo "$(_EMPH)Concatenating LEXC files.$(_RESET)"
	cat $^ > $@

crk-lexc-dict.hfst: crk-dict.lexc
	-@echo "$(_EMPH)Compiling LEXC code.$(_RESET)"
	hfst-lexc $(WEIGHT_FORMAT) -o $@ $<

crk-phon.hfst: $(PHONOLOGY)
	-@echo "$(_EMPH)Compiling xfscript code for morphophonology.$(_RESET)"
	-@echo "$(_DEEMPH)(this one takes a while... ☕️)$(_RESET)"
	hfst-xfst --pipe-mode $(VERBOSITY) $(WEIGHT_FORMAT)	-e "source $^" -E "save stack $@"

convert-accented-y-to-simple-y.hfst: $(FILTERS)
	-@echo "$(_EMPH)Compiling filter to convert accented <ý> to simple <y>.$(_RESET)"
	hfst-regexp2fst $(VERBOSITY) --semicolon $< -o $@

crk-strict-generator-with-morpheme-boundaries.hfst: crk-lexc-dict.hfst crk-phon.hfst convert-accented-y-to-simple-y.hfst
	-@echo "$(_EMPH)Composing lexicon with morphophonology.$(_RESET)"
	hfst-compose --harmonize-flags -1 $(word 3, $^) -2 $(word 1, $^) | hfst-compose --harmonize-flags -1 - -2 $(word 2, $^) | hfst-minimize - -o $@

crk-orth.hfst: $(ORTHOGRAPHY)
	-@echo "$(_EMPH)Compiling regular expression implementing spelling-relaxation.$(_RESET)"
	hfst-regexp2fst $(VERBOSITY) --semicolon $< -o $@

remove-morpheme-boundary-filter.hfst:
	-@echo "$(_EMPH)Compiling filter to remove morpheme boundaries.$(_RESET)"
	echo '%> -> 0, %< -> 0;' | hfst-regexp2fst $(VERBOSITY) --semicolon -o $@

crk-strict-analyzer.hfst: crk-strict-generator-with-morpheme-boundaries.hfst remove-morpheme-boundary-filter.hfst
	-@echo "$(_EMPH)Removing morpheme boundaries to create strict analyzer.$(_RESET)"
	hfst-compose --harmonize-flags -1 $(word 1, $^) -2 $(word 2, $^) | hfst-invert | hfst-minimize -o $@

crk-strict-generator.hfst: crk-strict-analyzer.hfst
	-@echo "$(_EMPH)Inverting the analyzer to create the strict generator.$(_RESET)"
	hfst-invert $^ -o $@

crk-relaxed-analyzer.hfst: crk-strict-analyzer.hfst crk-orth.hfst
	-@echo "$(_EMPH)Composing spelling relaxation transducer with normative analyzer transducer to create descriptive analyzer.$(_RESET)"
	hfst-invert -i $(word 1, $^) | hfst-compose --harmonize-flags -1 - -2 $(word 2, $^) | hfst-minimize | hfst-invert - -o $@

crk-dict-filter.hfst: morphological-fst-rules.mk
	-@echo "$(_EMPH)Compiling filter to remove +Err/Frag analyses and omit +Err/Orth from analyses$(_RESET)"
	echo '~[ $$[ "+Err/Frag" ] ] .o. [ "+Err/Orth" -> 0 ] ; ' | hfst-regexp2fst $(VERBOSITY) --semicolon - -o $@

# HACK: Foma has issues with composing the orthographic FST, so we do it
# explicitly:
crk-relaxed-analyzer.fomabin: crk-strict-generator.fomabin crk-orth.fomabin morphological-fst-rules.mk
	foma\
		-e "load $(word 1, $^)" \
		-e "invert net" \
		-e "define M" \
		-e "load $(word 2, $^)" \
		-e "invert net" \
		-e "define O" \
		-e "regex [ M .o. O ];" \
		-e "save stack $@" \
		-s


############################### Pattern rules ################################

%.hfstol: %.hfst
	hfst-fst2fst --optimized-lookup-unweighted -i $< -o $@

%-for-dictionary.hfst: %.hfst crk-dict-filter.hfst
	-@echo "$(_EMPH)Creating dictionary version of $<$(_RESET)"
	hfst-compose $(VERBOSE) --harmonize-flags -1 $(word 1, $^) -2 $(word 2, $^) |\
		hfst-minimize - -o $@

%.fomabin: %.hfst
	@# HFST has the upper and lower sides inverted (I don't blame them)
	@# but this inverts it back so Foma users aren't confused.
	hfst-invert -i $< -o - |\
		hfst-fst2fst --foma --use-backend-format -i - -o - |\
		gzip > $@
