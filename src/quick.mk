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

FSTs = crk-strict-analyzer.hfstol \
       crk-relaxed-analyzer.hfstol \
       crk-strict-generator.hfstol \
       crk-strict-generator-with-morpheme-boundaries.hfstol \


DICTFSTs = $(FSTs) \
           crk-strict-analyzer-for-dictionary.hfstol \
           crk-relaxed-analyzer-for-dictionary.hfstol


FOMA_ONLY_FSTs = \
       transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin \
       transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin \
       transcriptor-eng-phrase2crk-features.fomabin \


FOMAFSTs = $(FSTs:.hfstol=.fomabin) $(FOMA_ONLY_FSTs)
# fsttest REQUIRES fomabins. Place any FSTs that you want to test here with
# the .fomabin extension:
FSTS_UNDER_TEST = $(FOMAFSTs) crk-lexc-dict.fomabin crk-strict-generator-with-morpheme-boundaries.fomabin


################################## Commands ##################################

all: $(FSTs)

dict: $(DICTFSTs)

clean:
	$(RM) $(FSTs) $(FSTS_UNDER_TEST) $(FOMAFSTs) $(wildcard *.hfst)

test: $(FSTS_UNDER_TEST)
	fsttest

.PHONY: all clean test


transcriptor%.fomabin: transcriptions/transcriptor%.xfscript
	@# The xfscript includes other files by referencing paths relative
	@# to a different directory. If foma can’t find those files, it just
	@# prints a warning and builds an invalid FST.
	(cd .. && foma -l src/$< -e 'save stack tmp.fomabin' -s) \
		&& mv ../tmp.fomabin $@



############################## Specific targets ##############################

fsts.zip: README.md $(DICTFSTs) $(FOMAFSTs)
	zip $@ $^


# The rest is defined in these two files
include morphological-fst-sources.mk
include morphological-fst-rules.mk
