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

# Concatenate by leveraging existing Makefile target. Avoids errors due to
# missing files, and keeps the two build files syncronised wrt source files.
crk.lexc: $(MORPHOLOGY)
	-@echo "$(_EMPH)Concatenating LEXC code.$(_RESET)"
	cat $^ > $@

crk-morph.hfst: crk.lexc
	-@echo "$(_EMPH)Compiling LEXC code.$(_RESET)"
	hfst-lexc --format=openfst-tropical --output=$@ $<

crk-phon.hfst: $(PHONOLOGY)
	-@echo "$(_EMPH)Compiling TWOLC code.$(_RESET)"
	hfst-twolc -i $< -o $@

crk-phon-morph-bound.hfst: $(PHONOLOGY_WITH_BOUNDARIES)
	-@echo "$(_EMPH)Compiling TWOLC code (with morpheme boundaries).$(_RESET)"
	hfst-twolc -i $< -o $@

crk-normative-generator.hfst: crk-morph.hfst crk-phon.hfst
	-@echo "$(_EMPH)Composing and intersecting LEXC and TWOLC transducers.$(_RESET)"
	hfst-compose-intersect -1 $(word 1, $^) -2 $(word 2, $^) | hfst-minimize - -o $@

crk-normative-generator-with-morpheme-boundaries.hfst: ./crk-morph.hfst crk-phon-morph-bound.hfst
	-@echo "$(_EMPH)Composing and intersecting LEXC and TWOLC transducers (with morpheme boundaries).$(_RESET)"
	hfst-compose-intersect -1 $(word 1, $^) -2 $(word 2, $^) | hfst-minimize - -o $@

crk-strict-analyzer.hfst: crk-normative-generator.hfst
	-@echo "$(_EMPH)Inverting normative generator tranducer into a normative analyzer transducer.$(_RESET)"
	hfst-invert $< -o $@

crk-orth.hfst: $(ORTHOGRAPHY)
	-@echo "$(_EMPH)Compiling regular expression implementing spelling-relaxation.$(_RESET)"
	hfst-regexp2fst -S -i $< | hfst-invert -o $@

crk-descriptive-analyzer.hfst: crk-orth.hfst crk-strict-analyzer.hfst
	-@echo "$(_EMPH)Composing spelling relaxation transducer with normative analyzer transducer to create descriptive analyzer.$(_RESET)"
	hfst-compose -F -1 $(word 1, $^) -2 $(word 2, $^) | hfst-minimize - -o $@

%.hfstol: %.hfst
	hfst-fst2fst -O -i $< -o $@
