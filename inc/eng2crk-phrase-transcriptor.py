#!/usr/bin/env python3

# EXAMPLES:
# English noun phrase:
# echo 'in my little book' | inc/eng2crk-phrase-transcriptor.py | head -10
# NO CRK MATCH
# in my little book
# => book
# => +N+Dim+Px1Sg+Loc
# -----
# nimasinahikanisihk <-- masinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1] (n=26)
#      ≈  in my little book; in my little letter, in my little mail; in my little written document, in my little report, in my little paper; in# my little magazine; in my little will [NI]
#
# ninêhiyawasinahikanisihk <-- nêhiyawasinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1] (n=1)
#      ≈  in my little Cree book; in my little Cree bible [NI]
#
# ...
# English verb phrase:
# echo 'I work together with you' | inc/eng2crk-phrase-transcriptor.py | head -10
# NO CRK MATCH
# I work together with you
# => work together with
# => +V+TA+1Sg+2SgO
# -----
# ê-wîtapimitân <-- PV/e+wîtapimêw+V+TA+Cnj+1Sg+2SgO [VTA-1] (n=16)
#      ≈  I sit with you, I sit beside you, I stay with you, I am present with you; I work together with you; I sit by you [VTA]
#
# ê-wîtatoskêmitân <-- PV/e+wîtatoskêmêw+V+TA+Cnj+1Sg+2SgO [VTA-1] (n=2)
#      ≈  I work together with you, I have you as your fellow worker [VTA]
#
# ...
# Cree verb form:
# echo 'niki-nitawi-kiskinwahamakosin' | inc/eng2crk-phrase-transcriptor.py | head -10
# nikî-nitawi-kiskinwahamâkosin (<- niki-nitawi-kiskinwahamakosin)
# => kiskinwahamâkosiw [VAI-1]
# => PV/ki+PV/nitawi+_+V+AI+Ind+1Sg
# -----
#      ≈  I learn>ed; I was a student, I attend>ed school; I was taught [VAI]
# ...

import os
import sys
from argparse import ArgumentParser
from pathlib import Path
from subprocess import check_call

inc_dir = Path(__file__).parent
src_dir = inc_dir / ".." / "src"
root_dir = inc_dir / ".."


def rel(p):
    return p.resolve().relative_to(Path(os.getcwd()).resolve())


parser = ArgumentParser()
parser.add_argument(
    "--dict", default=os.path.expanduser("~/altlab/crk/dicts/Wolvengrey.tsv")
)
parser.add_argument(
    "--eng-anl-fst",
    default=rel(src_dir / "transcriptor-eng-phrase2crk-features.fomabin"),
)
parser.add_argument(
    "--crk-anl-fst", default=rel(root_dir / "crk-anl-desc-dict.fomabin")
)
parser.add_argument(
    "--crk-gen-fst", default=rel(root_dir / "crk-gen-norm-dict.fomabin")
)
parser.add_argument(
    "--eng-noun-gen-fst",
    default=rel(
        src_dir
        / "transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin"
    ),
)
parser.add_argument(
    "--eng-verb-gen-fst",
    default=rel(
        src_dir
        / "transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin"
    ),
)
parser.add_argument(
    "--corp-freq", default=rel(root_dir / "WA_fst_cg.frequency_list.txt")
)
args = parser.parse_args()

allok = True
for k, v in vars(args).items():
    if not os.path.isfile(v):
        print(f"Error: --{k.replace('_', '-')} argument {v} is not a file.")
        allok = False

if not allok:
    parser.print_help()
    sys.exit(1)


check_call(
    [
        "gawk",
        "-v",
        f"DICT={args.dict}",
        "-v",
        f"ENGANLFST={args.eng_anl_fst}",
        "-v",
        f"CRKANLFST={args.crk_anl_fst}",
        "-v",
        f"CRKGENFST={args.crk_gen_fst}",
        "-v",
        f"ENGNOUNGENFST={args.eng_noun_gen_fst}",
        "-v",
        f"ENGVERBGENFST={args.eng_verb_gen_fst}",
        "-v",
        f"CORPFREQ={args.corp_freq}",
        "-f",
        inc_dir / "eng2crk-phrase-transcriptor.gawk",
    ]
)
