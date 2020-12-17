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

FSTs = crk-descriptive-analyzer.hfstol \
	crk-normative-generator.hfstol \
	crk-strict-analyzer.hfstol \
	crk-normative-generator-with-morpheme-boundaries.hfstol

FOMAFSTs = $(FSTs:.hfstol=.fomabin)

all: $(FSTs)

fsts.zip: $(FSTs) $(FOMAFSTs)
	zip $@ $^

test: $(FOMAFSTs)
	fsttest

include morphological-fst-sources.mk
include morphological-fst-rules.mk
