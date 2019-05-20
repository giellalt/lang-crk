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

MORPHOLOGY = morphology/root.lexc \
  morphology/affixes/noun_affixes.lexc \
  morphology/affixes/propernouns.lexc \
  morphology/affixes/symbols.lexc \
  morphology/affixes/verb_affixes.lexc \
  morphology/stems/abbreviations.lexc \
  morphology/stems/noun_stems.lexc \
  morphology/stems/numerals.lexc \
  morphology/stems/verb_stems.lexc \
  morphology/stems/pronouns.lexc \
  morphology/stems/particles.lexc

EXTRA_MORPHOLOGY = \
  morphology/generated_files/eng-crk-propernouns.lexc \
  morphology/generated_files/punctuation.lexc \
  morphology/generated_files/symbols.lexc

PHONOLOGY = phonology/crk-phon.twolc
ORTHOGRAPHY = orthography/spellrelax.regex
