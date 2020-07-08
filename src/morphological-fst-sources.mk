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

# Lists the raw .lexc/.twolc/.regex sources required to create the
# morphological FSTs.

ALL_SOURCES = $(MORPHOLOGY) $(PHONOLOGY) $(PHONOLOGY_WITH_BOUNDARIES) $(ORTHOGRAPHY)
ALL_SOURCES_WITH_EXTRAS = $(ALL_SOURCES) $(EXTRA_MORPHOLOGY)

MORPHOLOGY = fst/root.lexc \
  fst/affixes/noun_affixes.lexc \
  fst/affixes/verb_affixes.lexc \
  fst/stems/derivation_stems.lexc \
  fst/stems/non_standard.lexc \
  fst/stems/noun_stems.lexc \
  fst/stems/noun_vocatives.lexc \
  fst/stems/numerals.lexc \
  fst/stems/particles.lexc \
  fst/stems/pronouns.lexc \
  fst/stems/verb_stems.lexc

EXTRA_MORPHOLOGY = \
  fst/affixes/propernouns.lexc \
  fst/generated_files/eng-crk-propernouns.lexc \
  fst/generated_files/punctuation.lexc \
  fst/generated_files/symbols.lexc \
  fst/stems/abbreviations.lexc \
  fst/stems/derivation_stems.lexc \
  fst/stems/numeral_symbols.lexc

PHONOLOGY = ./fst/phonology.xfscript
# According to aarppe, these are:
# > morphophonological rules that leaves the morpheme boundaries [intact], in
# > order to facilitate the splitting of an inflected form into its
# > constituent morphemes
PHONOLOGY_WITH_BOUNDARIES = phonology/crk-phon-morph-bound.twolc
ORTHOGRAPHY = orthography/spellrelax.regex
