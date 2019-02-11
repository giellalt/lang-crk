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

# Creates descriptive analyzer and a normative generator for crk
#
# How to create the FSTs:
#
# 	make -j -f quick.mk

MORPHOLGY = morphology/root.lexc \
    morphology/affixes/noun_affixes.lexc \
    morphology/affixes/propernouns.lexc \
    morphology/affixes/verb_affixes.lexc \
    morphology/stems/abbreviations.lexc \
    morphology/stems/crk-propernouns.lexc \
    morphology/stems/noun_stems.lexc \
    morphology/stems/numerals.lexc \
    morphology/stems/particles.lexc \
    morphology/stems/pronouns.lexc \
    morphology/stems/verb_stems.lexc
PHONOLOGY = phonology/crk-phon.twolc
ORTHOGRAPHY = orthography/spellrelax.regex
_RESET := $(shell tput sgr0)
_EMPH := $(shell tput setaf 6)

all: crk-anl-desc.hfstol crk-gen-norm.hfstol

crk.lexc: $(MORPHOLGY)
	-@echo "$(_EMPH)Concatenating LEXC code.$(_RESET)"
	cat $^ > $@

crk-morph.hfst: crk.lexc
	-@echo "$(_EMPH)Compiling LEXC code.$(_RESET)"
	hfst-lexc $< -o $@

crk-phon.hfst: $(PHONOLOGY)
	-@echo "$(_EMPH)Compiling TWOLC code.$(_RESET)"
	hfst-twolc -i $< -o $@

crk-gen-norm.hfst: crk-morph.hfst crk-phon.hfst
	-@echo "$(_EMPH)Composing and intersecting LEXC and TWOLC transducers.$(_RESET)"
	hfst-compose-intersect $^ | hfst-minimize - -o $@

crk-anl-norm.hfst: crk-gen-norm.hfst
	-@echo "$(_EMPH)Inverting normative generator tranducer into a normative analyzer transducer.$(_RESET)"
	hfst-invert $< -o $@

crk-orth.hfst: $(ORTHOGRAPHY)
	-@echo "$(_EMPH)Compiling regular expression implementing spelling-relaxation.$(_RESET)"
	hfst-regexp2fst -S -i $< -o $@

crk-anl-desc.hfst: crk-orth.hfst crk-anl-norm.hfst
	-@echo "$(_EMPH)Composing spelling relaxation transducer with normative analyzer transducer to create descriptive analyzer.$(_RESET)"
	hfst-compose -F -1 $(word 1, $^) -2 $(word 2, $^) | hfst-minimize - -o $@

%.hfstol: %.hfst
	hfst-fst2fst -O -i $< -o $@
