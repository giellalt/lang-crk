#!/bin/sh

# eng2crk-phrase-translator.sh

# Examples:

# English verb phrase: 
# echo 'in my little book' | inc/eng2crk-phrase-translator.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv eng-phrase-analyzer.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin eng-noun-phrase-inflector.fomabin eng-verb-phrase-inflector.fomabin| less

# English noun phrase:
# echo 'I work together with you' | inc/eng2crk-phrase-translator.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv eng-phrase-analyzer.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin eng-noun-phrase-inflector.fomabin eng-verb-phrase-inflector.fomabin| less


gawk -v DICT=$1 -v ENGANLFST=$2 -v CRKANLFST=$3 -v CRKGENFST=$4 -v ENGNOUNGENFST=$5 -v ENGVERBGENFST=$6 'BEGIN { FS="\t"; dict=DICT;
  enganlfst=ENGANLFST; crkanlfst=CRKANLFST; crkgenfst=CRKGENFST; engnoungenfst=ENGNOUNGENFST;  engverbgenfst=ENGVERBGENFST;
  hfstlookup="/usr/local/bin/hfst-lookup -q"
  flookup="/usr/local/bin/flookup -b"

while((getline < dict)!=0)
  { 
    crkentry=$1; crklexcat=$3; crkengdef=$4;
    gsub("ý","y",crkentry);
    crkwordclass=crklexcat
    sub("[-].*$","",crkwordclass);
    crk[crkengdef][crkwordclass][crklexcat]=crkentry;
  }
}
{ 
  engphrase=$0;
  print engphrase |& flookup" -i "enganlfst;
  flookup" -i "enganlfst |& getline engfstanl;
  close(flookup" -i "enganlfst);
  split(engfstanl,f,"\t");

#  if(f[2]=="+?")
#    { print engphrase |& flookup" "crkanlfst;
#      flookup" "crkanlfst |& getline crkfstanl;
#      close(flookup" "crkanlfst);
#      split(crkfstanl,f,"\t");
#    }

  engphraseanl=f[2];
  match(engphraseanl, "(^[^\\+]+)(\\+.+$)", ff);
  engphraselex=ff[1]; engphrasetags=ff[2];
  gsub("^[ ]+|[ ]+$","",engphraselex);
  match(engphrasetags,"^\\+([VN])\\+(II|AI|TI|TA)?",fff);
  engwordclass=fff[1] "" fff[2];

  # Modifying the English phrase features to Cree verb features
  crkformtags=engphrasetags;
  pv="";
  if(index(crkformtags,"+Cond")!=0)
    sub("\\+Cond","+Fut&",crkformtags);
  else
    if(index(crkformtags,"+Imm")!=0 || index(crkformtags,"+Del")!=0)
      sub("\\+(Imm|Del)","+Imp&",crkformtags);
  else
    if(index(crkformtags,"+Fut")!=0)
      { pv="PV/ka+"; sub("\\+Fut","+Cnj",crkformtags); }
  else
    if(index(crkformtags,"+Int")!=0)
      { pv="PV/wi+"; sub("\\+Int","+Ind",crkformtags); }
  else
    if(index(crkformtags,"+Inf")!=0)
      { pv="PV/ta+"; sub("\\+Inf","+Cnj",crkformtags); }
  else
    { pv="PV/e+"; sub("\\+V\\+(II|AI|TI|TA)","&+Cnj",crkformtags); }

  print engphrase
  print "=> "engphraselex;
  print "=> "engphrasetags;
  print "-----";

  # Converting inanimate subject/object tags
  if(index(crkformtags,"+V+TI")!=0)
    sub("\\+0SgO","",crkformtags);
  sub("\\+0Sg","+3Sg",crkformtags);

  # Switching inclusive plural feature
  gsub("21","12",crkformtags);

  n=split(engphraselex, w, "[ ,:;]+");

  for(def in crk)
    for(wc in crk[def])
       for(lc in crk[def][wc])
        { m=0;
          for(i=1; i<=n; i++)
              if(match(def,"\\<"w[i])!=0)
                { m++; }
          if(m==n && match(wc,"^"engwordclass)!=0)
            { if(match(wc, /^V/)!=0)
                crkfstform=pv "" crk[def][wc][lc] "" crkformtags;
              if(match(wc, /^N/)!=0)
                { crkformtags2=crkformtags;
                  # sub("(N\\+[AI]\\+(D\\+)?(Der/Dim\\+)?)+","N+",crkformtags);
                  if(wc=="NA")
                    sub("\\+N","+N+A",crkformtags2)
                  if(wc=="NI")
                    sub("\\+N","+N+I",crkformtags2);
                  if(wc=="NDA")
                    sub("\\+N","+N+A+D",crkformtags2)
                  if(wc=="NDI")
                    sub("\\+N","+N+I+D",crkformtags2);
                  if(index(crkformtags2,"+Dim")!=0)
                    crkformtags2=gensub("(\\+N.+)(\\+Dim)","\\1+Der/Dim\\1","g",crkformtags2);
                  crkfstform=crk[def][wc][lc] "" crkformtags2;
                }
              print crkfstform |& flookup" "crkgenfst;
              flookup" "crkgenfst |& getline crkgenform;
              close(flookup" "crkgenfst);
              split(crkgenform,gg,"\t");
              print gg[2]" <-- "crkfstform" ["lc"]" ;

              # Organizing the English phrase features for English phrase generation

              engphrasegentags=engphrasetags;
              match(engphrasegentags, "((\\+N)(\\+Dim)?(\\+Px[123](Sg|Pl))?(\\+(Sg|Pl|Obv|Loc|Distr)))|((\\+V)(\\+(II|AI|TI|TA))(\\+(Fut|Int|Cond|Imm|Del|Fut))?(\\+[0123](Sg|Pl))(\\+[0123](Sg|Pl)[OR])?)", g);

              if(g[1]!="")
                { enggenwc="N"; engphrasegentags=g[6] g[3] g[4] "+"; }
              if(g[8]!="")
                {
                  enggenwc="V";
                  if(g[12]=="")
                    g[12]="Prs+";
                  engphrasegentags=g[12] g[14] g[16] "+";
                }
              sub("\\+","",engphrasegentags);

              if(enggenwc=="N" && engphrasegentags!="" && engnoungenfst!="")
                {
                  def2=def;
                  gsub("\"","",def2);
                  gsub("[ ]*\\([^\\)]+\\)","",def2); gsub("[ ]*\\[[^\\]]+\\]","",def2); gsub("\"","",def2); gsub("[ ]*[;]+",";",def2); gsub("[,;] [Ll]iteral[^,;]+","",def2);

                  print engphrasegentags " "def2 |& flookup" -i "engnoungenfst;
                  flookup" -i "engnoungenfst |& getline enggenphrase;
                  close(flookup" -i "engnoungenfst);
                  split(enggenphrase,gg,"\t");
                  if(gg[2]!="+?")
                     print "     ["wc"] "gg[2];
                  else
                     print "     ["wc"] "def;
                  print "";
                }
              else if(enggenwc=="V" && engphrasegentags!="" && engverbgenfst!="")
                {
                  def2=def;
                  gsub("\"","",def2);
                  gsub("[ ]*\\([^\\)]+\\)","",def2); gsub("[ ]*\\[[^\\]]+\\]","",def2); gsub("\"","",def2); gsub("[ ]*[;]+",";",def2); gsub("[,;] [Ll]iteral[^,;]+","",def2);
                  print engphrasegentags " "def2 |& flookup" -i "engverbgenfst;
                  flookup" -i "engverbgenfst |& getline enggenphrase;
                  close(flookup" -i "engverbgenfst);
                  split(enggenphrase,gg,"\t");
                  if(gg[2]!="+?")
                     print "     ["wc"] "gg[2];
                  else
                     print "     ["wc"] "def;
                  print "";
                }
              else
                 { print "     ["wc"] "def; print ""; }
            }
        }
}'


