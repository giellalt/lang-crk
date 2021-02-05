#!/bin/sh

# eng2crk-phrase-transcriptor.sh

# Examples:

# English noun phrase: 
# echo 'in my little book' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin | head -10
# in my little book
# => book
# => +N+Dim+Px1Sg+Loc
# -----
# nimanicowi-masinahikanisihk <-- manitowi-masinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1]
#      God's book, the Bible [NI]
# 
# nicayamihêwasinahikanisihk <-- ayamihêwasinahikan+N+I+Der/Dim+N+I+Px1Sg+Loc [NI-1]
#      ≈  in my little prayer book [NI]
# ...
# English verb phrase:
# echo 'I work together with you' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin | head -10
# I work together with you
# => work together with
# => +V+TA+1Sg+2SgO
# -----
# ê-wîtatoskêmitân <-- PV/e+wîtatoskêmêw+V+TA+Cnj+1Sg+2SgO [VTA-1]
#      ≈  I work together with you, I have you as your fellow worker [VTA]
# 
# ê-wîtapimitân <-- PV/e+wîtapimêw+V+TA+Cnj+1Sg+2SgO [VTA-1]
#      ≈  I sit with you, I sit beside you, I stay with you, I am present with you; I work together with you; I sit by you [VTA]
# ...
# Cree verb form:
# echo 'niki-nitawi-kiskinwahamakosin' | inc/eng2crk-phrase-transcriptor.sh /Users/arppe/altlab/crk/dicts/Wolvengrey.tsv transcriptor-eng-phrase2crk-features.fomabin crk-anl-desc-dict.fomabin crk-gen-norm-dict.fomabin transcriptor-cw-eng-noun-entry2inflected-phrase-w-flags.fomabin transcriptor-cw-eng-verb-entry2inflected-phrase-w-flags.fomabin | head -10  
# nikî-nitawi-kiskinwahamâkosin (<- niki-nitawi-kiskinwahamakosin)
# => kiskinwahamâkosiw [VAI-1]
# => PV/ki+PV/nitawi+_+V+AI+Ind+1Sg
# -----
#      ≈  I learn>ed; I was a student, I attend>ed school; I was taught [VAI]
# ...


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
  phrase=$0;

  # English analysis
  print phrase |& flookup" -i "enganlfst;
  flookup" -i "enganlfst |& getline engfstanl;
  close(flookup" -i "enganlfst);
  split(engfstanl,f,"\t");
  engphraseanl=f[2];
  match(engphraseanl, "(^[^\\+]+)(\\+.+$)", ff);
  engphraselex=ff[1]; engphrasetags=ff[2];
  gsub("^[ ]+|[ ]+$","",engphraselex);
  match(engphrasetags,"^\\+([VN])\\+(II|AI|TI|TA)?",fff);
  engwordclass=fff[1] fff[2];

  # Cree analysis
  print phrase |& flookup" "crkanlfst;
  flookup" "crkanlfst |& getline crkfstanl;
  close(flookup" "crkanlfst);
  split(crkfstanl,f,"\t");
  crkwordanl=f[2];
  match(crkwordanl, "((IC\\+|PV/[^\\+]+\\+|Rdpl[SW]\\+)*)*([^\\+]+)(.+)", ff);
  # print "1:"ff[1], "3:"ff[3], "4:"ff[4];
  crkwordlex=ff[3]; crkwordtags=ff[1] "_" ff[4];
  match(crkwordtags,"^\\+([VN])\\+(II|AI|TI|TA|A|I|A)?\\+[D]?",fff);
  crkwordclass=fff[1] fff[2] fff[3];
  
  # Modifying the Cree word features to English phrase features
  match(crkwordtags,"(\\+[12345X]+(Sg|Pl|Sg/Pl)?O?)+",g);
  if(g[0]!="")
    { enggenwc="V"; subjobj=g[0]; }
  if(index(crkwordtags,"+Cond")!=0)
    engphrasegentags="Cond" subjobj "+";
  else
    if(index(crkwordtags,"+Imm")!=0)
      engphrasegentags="Imm" subjobj "+";
  else
    if(index(crkwordtags,"+Del")!=0)
      engphrasegentags="Del" subjobj "+";
  else
    if(index(crkwordtags,"PV/ka+")!=0 && index(crkwordtags,"+Ind")!=0)
      engphrasegentags="Fut" subjobj "+";
  else
    if(index(crkwordtags,"PV/ki+")!=0)
      engphrasegentags="Prt" subjobj "+";
  else
    if(index(crkwordtags,"PV/wi+")!=0)
      engphrasegentags="Int" subjobj "+";
  else
    if(index(crkwordtags,"PV/ta+")!=0 || index(crkwordtags,"PV/ka+")!=0 && index(crkwordtags,"+Cnj")!=0)
      engphrasegentags="Inf" subjobj "+";
  else
    { engphrasegentags="Prs" subjobj "+"; }

  match(crkwordtags,"(\\+Der/Dim)?(\\+Px[1234X]+(Sg|Pl|Sg/Pl))?(\\+(Sg|Pl|Obv|Loc|Distr))",g);
  if(g[0]!="")
    { enggenwc="N"; engphrasegentags=g[4] g[1] g[2] "+"; sub("^\\+","",engphrasegentags); }

  # Changing further obviative subjects/objects to closer obviatives
  if(index(engphrasetags,"5Sg/Pl")!=0)
    { gsub("4Sg/Pl","3Sg",engphrasetags); gsub("5Sg/Pl","4Sg/Pl",engphrasegentags); }
  gsub("21","12",engphrasegentags);

  # Removing +Err/XXX tags
  sub("\\+Err/(Orth|Frag)","",crkwordanl);

if(index(phrase," ")==0 && index(crkwordanl,"+?")==0)
  for(def in crk)
     for(wc in crk[def])
        for(lc in crk[def][wc])
           if(crkwordlex==crk[def][wc][lc])
           {

              print crkwordanl |& flookup" -x "crkgenfst;
              flookup" -x "crkgenfst |& getline crkgennorm;
              close(flookup" -x "crkgenfst);

              print crkgennorm" (<- "phrase")";
              print "=>", crkwordlex" ["lc"]";
              print "=>", crkwordtags;
              print "-----";

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
                     print "     ≈ "gg[2]" ["wc"]";
                  else
                     print "     ≈ "def" ["wc"]";
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
                     print "     ≈ "gg[2]" ["wc"]";
                  else
                     print "     ≈ "def" ["wc"]";
                  print "";
                }
              else
                 { print "     ["wc"] "def; print ""; }
            }


  # Modifying the English phrase features to Cree verb features
  crkformtags=engphrasetags;
  pv="";
  if(index(crkformtags,"+Cond")!=0)
    sub("\\+Cond","+Fut&",crkformtags);
  else
    if(index(crkformtags,"+Prt")!=0)
      { sub("\\+Prt","+Cnj",crkformtags); pv="PV/e+PV/ki+"; }
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

  # Converting inanimate subject/object tags
  if(index(crkformtags,"+V+TI")!=0)
    sub("\\+0SgO","",crkformtags);
  sub("\\+0Sg","+3Sg",crkformtags);

  # Switching inclusive plural feature
  gsub("21","12",crkformtags);


if(crkwordanl=="+?") {

  print phrase
  print "=> "engphraselex;
  print "=> "engphrasetags;
  print "-----";

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
              # Revising inclusive plural tags
              gsub("21","12",engphrasegentags);
              # Revising inanimate subject tags
              sub("\\+0Sg","+3Sg",engphrasegentags);
              sub("\\+0Pl","+3Pl",engphrasegentags);
              # Removing inanimate object tags
              gsub("\\+0SgO","",engphrasegentags);

              match(engphrasegentags, "((\\+N)(\\+Dim)?(\\+Px[1234X]+(Sg|Pl|Sg/Pl)?)?(\\+(Sg|Pl|Obv|Loc|Distr)))|((\\+V)(\\+(II|AI|TI|TA))(\\+(Prt|Fut|Int|Cond|Imm|Del|Inf))?(\\+[01234X]+(Sg|Pl|Sg/Pl)?)(\\+[01234X]+(Sg|Pl|Sg/Pl)?[OR])?)", g);

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
                     print "     ≈ "gg[2]" ["wc"]";
                  else
                     print "     "def" ["wc"]";
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
                     print "     ≈ "gg[2]" ["wc"]";
                  else
                     print "     "def"["wc"]";
                  print "";
                }
              else
                 { print "     "def"["wc"]"; print ""; }
            }
        }
    }
}'


