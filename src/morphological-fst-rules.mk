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

# Rules to create morphological Cree FSTs:
#
#   - crk-descriptive-analyzer.hfstol
#   - crk-normative-generator.hfstol

_RESET := $(shell tput sgr0)
_EMPH := $(shell tput setaf 6)

WEIGHT_FORMAT=--format=openfst-tropical
ifeq ($(V), 0)
VERBOSITY=--silent
else
VERBOSITY=--verbose
endif

crk-strict-analyzer.hfst: crk-normative-generator-with-morpheme-boundaries.hfst remove-morpheme-boundary-filter.hfst
	-@echo "$(_EMPH)Removing morpheme boundaries to create strict analyzer.$(_RESET)"
	hfst-compose --harmonize-flags -1 $(word 1, $^) -2 $(word 2, $^) | hfst-invert -o $@

# Concatenate by leveraging existing Makefile target. Avoids errors due to
# missing files, and keeps the two build files syncronised wrt source files.
crk-dict.lexc: $(MORPHOLOGY)
	-@echo "$(_EMPH)Concatenating LEXC code.$(_RESET)"
	cat $^ > $@

crk-lexc-dict.hfst: crk-dict.lexc
	-@echo "$(_EMPH)Compiling LEXC code.$(_RESET)"
	hfst-lexc $(WEIGHT_FORMAT) -o $@ $<

crk-phon.hfst: $(PHONOLOGY)
	-@echo "$(_EMPH)Compiling xfscript code.$(_RESET)"
	printf "\n\nsave stack $@\nquit\n" | cat $< - \
		| hfst-xfst --pipe-mode $(VERBOSITY) $(WEIGHT_FORMAT)

crk-normative-generator-with-morpheme-boundaries.hfst: crk-lexc-dict.hfst crk-phon.hfst
	-@echo "$(_EMPH)Composing and intersecting LEXC and TWOLC transducers.$(_RESET)"
	hfst-compose-intersect -1 $(word 1, $^) -2 $(word 2, $^) | hfst-minimize - -o $@

crk-orth.hfst: $(ORTHOGRAPHY)
	-@echo "$(_EMPH)Compiling regular expression implementing spelling-relaxation.$(_RESET)"
	hfst-regexp2fst $(VERBOSITY) --semicolon $< -o $@

crk-descriptive-analyzer.hfst: crk-strict-analyzer.hfst crk-orth.hfst
	-@echo "$(_EMPH)Composing spelling relaxation transducer with normative analyzer transducer to create descriptive analyzer.$(_RESET)"
	hfst-invert -i $(word 1, $^) | hfst-compose --harmonize-flags -1 - -2 $(word 2, $^) | hfst-minimize - | hfst-invert - -o $@

remove-morpheme-boundary-filter.hfst:
	-@echo "$(_EMPH)Compiling filter to remove morpheme boundaries.$(_RESET)"
	echo '%> -> 0, %< -> 0;' | hfst-regexp2fst $(VERBOSITY) --semicolon -o $@

crk-err-filter.hfst:
	-@echo "$(_EMPH)Compiling filter to remove non-normative forms with +Err/Orth tag.$(_RESET)"
	echo '~[ $$[ "+Err/Orth" ] ] ;' | hfst-regexp2fst $(VERBOSITY) --semicolon -o $@

crk-normative-generator.hfst: crk-strict-analyzer.hfst
	hfst-invert -i $^ -o $@

# HACK: Foma has issues with composing the orthographic FST, so we do it
# explicitly:
crk-descriptive-analyzer.fomabin: crk-normative-generator.fomabin crk-orth.fomabin morphological-fst-rules.mk
	foma\
		-e "load $(word 1, $^)" \
		-e "invert net" \
		-e "define M" \
		-e "load $(word 2, $^)" \
		-e "define O" \
		-e "regex [ M .o. O ];" \
		-e "save stack $@" \
		-s

%.hfstol: %.hfst
	hfst-fst2fst --optimized-lookup-unweighted -i $< -o $@

%.fomabin: %.hfst
	@# HFST has the upper and lower sides inverted (I don't blame them)
	@# but this inverts it back so Foma users aren't confused.
	hfst-invert -i $< -o - |\
		hfst-fst2fst --foma --use-backend-format -i - -o - |\
		gzip > $@
