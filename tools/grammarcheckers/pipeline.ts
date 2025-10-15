import * as cg3 from "./.divvun-rt/cg3.ts";
import * as divvun from "./.divvun-rt/divvun.ts";
import * as hfst from "./.divvun-rt/hfst.ts";
import { Command, StringEntry } from "./.divvun-rt/mod.ts";

export default function crkGramRelease(entry: StringEntry): Command {
  let x = hfst.tokenize("tokenize", entry, { model_path: "tokeniser-gramcheck-gt-desc.pmhfst" });
  x = divvun.blanktag("whitespace", x, { model_path: "analyser-gt-whitespace.hfst" });
  x = cg3.vislcg3("mwe-dis", x, { model_path: "mwe-dis.bin" });
  x = cg3.mwesplit("mwesplit", x);
  x = divvun.cgspell("speller", x, {
    acc_model_path: "acceptor.default.hfst",
    err_model_path: "errmodel.default.hfst",
  });
  x = cg3.vislcg3("disamb", x, { model_path: "disambiguator.bin" });
  x = cg3.vislcg3("spell-sugg-filtering", x, { model_path: "spellchecker.bin" });
  x = cg3.vislcg3("gramcheck", x, { model_path: "grammarchecker.bin" });
  return divvun.suggest("suggestions", x, { model_path: "generator-gramcheck-gt-norm.hfstol" });
}

/**
 * Dev pipeline for testing with local models.
 */
export function localTest_dev(entry: StringEntry): Command {
  let x = hfst.tokenize("tokenize", entry, { model_path: "@./tokeniser-gramcheck-gt-desc.pmhfst" });
  x = divvun.blanktag("whitespace", x, { model_path: "@./analyser-gt-whitespace.hfst" });
  x = cg3.vislcg3("mwe-dis", x, { model_path: "@../tokenisers/mwe-dis.cg3" });
  x = cg3.mwesplit("mwesplit", x);
  x = divvun.cgspell("speller", x, {
    acc_model_path: "@./acceptor.default.hfst",
    err_model_path: "@./errmodel.default.hfst",
  });
  x = cg3.vislcg3("disamb", x, { model_path: "@../../src/cg3/disambiguator.cg3" });
  x = cg3.vislcg3("spell-sugg-filtering", x, { model_path: "@./spellchecker.cg3" });
  x = cg3.vislcg3("gramcheck", x, { model_path: "@./grammarchecker.cg3" });
  return divvun.suggest("suggestions", x, { model_path: "@./generator-gramcheck-gt-norm.hfstol" });
}